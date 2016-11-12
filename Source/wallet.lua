local sqlite3 = require( "sqlite3" )

local dbFilename = "culturefun.db"
local dbPath = system.DocumentsDirectory


local function sqlTableExists( db, table )
    local exists

    local selectTable = [[SELECT name FROM sqlite_master WHERE type='table' AND name=']]..table..[[';]]
    local setExists = function(_, _, values, _)
        exists = #values == 1
    end
    db:exec( selectTable, setExists )

    return exists
end

local function sqlSelect( db, table, column )
    local _values

    local sql = [[SELECT "]]..column..[[" FROM ']]..table..[[';]]
    local setValues = function(_, _, values, _)
        _values = values
    end
    db:exec( sql, setValues )

    return _values
end

local function sqlDrop( db, table )
    db:exec( [[DROP TABLE ']]..table..[[';]] )
end

local function sqlSelectOne( db, table, column )
    local values = sqlSelect( db, table, column )
    return (values and values[1])
end

local function sqlGetSchema( db )
    if sqlTableExists( db, 'schema' ) then
        return sqlSelectOne( db, 'schema', 'version' )
    else
        return nil
    end
end

local function sqlSetSchema( db, version )
    sqlDrop( db, 'schema' )
    db:exec( [[CREATE TABLE 'schema' (version INTEGER);]] )
    db:exec( [[INSERT INTO 'schema' VALUES (]]..version..[[);]] )
end

local function setupTables( db )
    if sqlGetSchema( db ) == "1" then
        return
    end

    sqlDrop( db, 'coins' )
    db:exec( [[CREATE TABLE IF NOT EXISTS coins (count INTEGER);]] )
    db:exec( [[INSERT INTO coins VALUES (0);]] )
    sqlSetSchema( db, 1 )
end



local wallet = {
    initialized = false
}

function wallet.initialize()
    if wallet.initialized then
        return
    end

    -- Open the dbFilename file as a DB.
    -- If the file doesn't exist, it will be created.
    local path = system.pathForFile( dbFilename, dbPath )
    wallet.db = sqlite3.open( path )

    local function onSystemEvent( event )
        if ( event.type == "applicationExit" ) then
            wallet.db:close()
        end
    end
    Runtime:addEventListener( "system", onSystemEvent )

    setupTables( wallet.db )

    wallet.initialized = true
end

function wallet.getCoins()
    wallet.initialize()
    return sqlSelectOne( wallet.db, 'coins', 'count' )
end

function wallet.setCoins( count )
    wallet.initialize()
    wallet.db:exec( [[UPDATE coins SET count = ]]..count..[[;]] )
end

function wallet.addCoins( newCoins )
    wallet.initialize()
    wallet.setCoins( wallet.getCoins() + newCoins )
end

function wallet.resetCoins()
    wallet.initialize()
    wallet.setCoins( 0 )
end

return wallet
