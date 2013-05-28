
-- Declare an example class for running and stopping any example.
Example = class();

function Example:GetName()
	return "<Unnamed>";
end

function Example:IsRunning()
	return false;
end

function Example:Start()
	if ( ( self.Started ~= nil ) and ( type( self.Started ) == "function" ) ) then
		self.Started( self, { } );
	end
end

function Example:Stop()
	if ( ( self.Stopped ~= nil ) and ( type( self.Stopped ) == "function" ) ) then
		self.Stopped( self, { } );
	end
end

-- Create a table that maps example names to function used to execute them.
examples = { }

-- Function to register examples.
function RegisterExample( example )
	-- Lower case the name before registering so that we can be case
	-- insensitive when looking for them in the table.
	local name = string.lower( example:GetName() );
	examples[name] = example;
end
