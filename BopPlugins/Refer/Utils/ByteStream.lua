-- Crude implementation of a byte stream

import "BopPlugins.Refer.Utils.bit32"; --!*!

local extract = BopPlugins.Refer.Utils.bit32.extract; --!*!
local table_insert = table.insert;

ByteStream = class();
function ByteStream:Constructor()
	self.position = 1;
	self.bytes = {};
end

-- output one byte
function ByteStream:Put( byte )
	table_insert( self.bytes, byte );
end

-- output a 16 bits word, little endian
function ByteStream:PutWordLE( word )
	table_insert( self.bytes, extract( word, 0, 8 ) );
	table_insert( self.bytes, extract( word, 8, 8 ) );
end

-- output a 32 bits longword, little endian
function ByteStream:PutLongLE( word )
	table_insert( self.bytes, extract( word, 0, 8 ) );
	table_insert( self.bytes, extract( word, 8, 8 ) );
	table_insert( self.bytes, extract( word, 16, 8 ) );
	table_insert( self.bytes, extract( word, 24, 8 ) );
end

-- get one byte from the stream
function ByteStream:Get()
	if self.position <= #self.bytes then
		local byte = self.bytes[self.position];
		self.position = self.position + 1;
		return byte;
	end
	return nil;
end

-- Consume n bytes, without reading them
function ByteStream:Consume( n )
	self.position = math.min( #self.bytes, self.position + n );
end

-- Get a 16bits word from the stream, little endian
function ByteStream:GetWordLE()
	if self.position + 1 <= #self.bytes then
		local low = self.bytes[self.position];
		local high = self.bytes[self.position+1];
		self.position = self.position + 2;
		return (high*256)+low;
	end
	return nil;
end

-- get a 32bits word from the stream, little endian
function ByteStream:GetLongLE()
	if self.position + 3 <= #self.bytes then
		local b1 = self.bytes[self.position];
		local b2 = self.bytes[self.position+1];
		local b3 = self.bytes[self.position+2];
		local b4 = self.bytes[self.position+3];
		self.position = self.position + 4;
		return (((((b4*256)+b3)*256)+b2)*256)+b1;
	end
	return nil;
end

-- get the content of the stream as an array of byte
function ByteStream:GetData()
	return self.bytes;
end

-- set the content of the stream as an array of byte
function ByteStream:SetData( data )
	self.position = 1;
	self.bytes = data;
end
