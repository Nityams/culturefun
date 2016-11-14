local Vector = {}
Vector.__index = Vector

function Vector.new( x, y )
	local V = {}
	setmetatable( V, Vector )
	V.x = x
	V.y = y
	return V
end

-- Vector unary minus
--   -V
function Vector.__unm( V )
	return Vector.new( -V.x, -V.y )
end

-- Vector addition
--   V + W
function Vector.__add( V, W )
	return Vector.new( V.x + W.x, V.y + W.y )
end

-- Vector subtraction
--   V - W
function Vector.__sub( V, W )
	return Vector.new( V.x - W.x, V.y - W.y )
end

-- Cross product's magnitude
--   V * W
function Vector.__mul( V, W )
	return V.x * W.y - V.y * W.x
end

-- Dot product
--   V .. W
function Vector.__concat( V, W )
	return V.x * W.x + V.y * W.y
end

function Vector:unit()
	local magnitude = self:magnitude()
	return Vector.new( self.x / magnitude, self.y / magnitude )
end

function Vector:scaleBy( c )
	return Vector.new( c * self.x, c * self.y )
end

function Vector:magnitude()
	local x = self.x
	local y = self.y
	return math.sqrt( x * x + y * y )
end

function Vector:withMagnitude( c )
	return self:unit():scaleBy( c )
end

function Vector:distanceTo( other )
	return (self - other):magnitude()
end

function Vector:toString()
	return "{x=" .. self.x .. ",y=" .. self.y .. "}"
end

return Vector
