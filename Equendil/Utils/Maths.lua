-- utility 'maths' function

Maths = {};

-- constrain a value within the min ... max range and returns it
function Maths.constrain( min, x, max )
	if x < min then x = min elseif x > max then x = max end;
	return x;
end