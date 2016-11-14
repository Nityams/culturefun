local Vector = require( "Source.vector" )

local math2 = {}

function math2.randomPointWithin( minX, maxX, minY, maxY )
	local x = math.random( minX, maxX )
	local y = math.random( minY, maxY )
	return Vector.new( x, y )
end

function math2.randomPointOnBorder( x1, x2, y1, y2 )
	local side = math.random( 1, 4 )

	if side == 1 then  -- top
		return math2.randomPointWithin( x1, x2, y1, y1 )
	elseif side == 2 then  -- right
		return math2.randomPointWithin( x2, x2, y1, y2 )
	elseif side == 3 then  -- bottom
		return math2.randomPointWithin( x1, x2, y2, y2 )
	else  -- left
		return math2.randomPointWithin( x1, x1, y1, y2 )
	end
end

-- Will two circles in motion with a constant linear velocity collide? And if
-- so, when?
-- Algorithm from page 372 of _Mathematics for 3D Game Programming and Computer
-- Graphics_, 3rd edition, by Eric Lengyel.
function math2.whenTwoCirclesCollide( P1, P2, Q1, Q2, rP, rQ )
	-- Distance between the two circles centers if they are tangent.
	local r = rP + rQ

	-- If the distance between the two circles ever drops below "r", they have
	-- collided.

	-- Do they start out intersecting?
	if P1:distanceTo( Q1 ) < r then
		return true, 0
	end

	-- Velocities of circles P and Q.
	local VP = P2 - P1
	local VQ = Q2 - Q1

	local A = P1 - Q1  -- Vector from Q to P.
	local B = VP - VQ  -- Vector from VQ to VP

	local a = A:magnitude()
	local b = B:magnitude()

	local a_dot_b = A .. B

	-- We solve this quadratic formula for "t":
	--     A^2 + 2 * t * (A .. B) + t^2 * B^2
	-- where A .. B is the vector dot product between A and B.
	-- "t" is the time when the spheres intersect.

	-- Starting the quadratic formula...
	local discriminant = a_dot_b * a_dot_b - b * b * (a * a - r * r)

	-- If the descriminant is negative it means the solutions are imaginary.
	if discriminant <= 0 then
		-- No collision happens.
		return false
	end

	-- Continue with quadratic formula.
	local t = (-a_dot_b - math.sqrt(discriminant)) / (b * b)

	return true, t
end

return math2
