local vector = {}
vector.__index = vector

function vector.new( x, y )
	local V = {}
	setmetatable( V, vector )
	V.x = x
	V.y = y
	return V
end

-- Vector unary minus
--   -V
function vector.__unm( V )
	return vector.new( -V.x, -V.y )
end

-- Vector addition
--   V + W
function vector.__add( V, W )
	return vector.new( V.x + W.x, V.y + W.y )
end

-- Vector subtraction
--   V - W
function vector.__sub( V, W )
	return vector.new( V.x - W.x, V.y - W.y )
end

-- Cross product's magnitude
--   V * W
function vector.__mul( V, W )
	return V.x * W.y - V.y * W.x
end

-- Dot product
--   V .. W
function vector.__concat( V, W )
	return V.x * W.x + V.y * W.y
end

function vector:unit()
	local magnitude = self:magnitude()
	return vector.new( self.x / magnitude, self.y / magnitude )
end

function vector:scaleBy( c )
	return vector.new( c * self.x, c * self.y )
end

function vector:magnitude()
	local x = self.x
	local y = self.y
	return math.sqrt( x * x + y * y )
end

function vector:withMagnitude( c )
	return self:unit():scaleBy( c )
end

function vector:distanceTo( other )
	return (self - other):magnitude()
end

function vector:toString()
	return "{x=" .. self.x .. ",y=" .. self.y .. "}"
end

return vector
