local base32="ABCDEFGHIJKLMNOPQRSTUVWXYZ234567"
local thex={"0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"}

function hexdec(hex)
	return string.gsub(hex, "([0-9A-Fa-f][0-9A-Fa-f])", function(hex)
		return string.char(tonumber(hex, 16))
	end)
end

function b32enc(sBytes)
	local byte=0
	local bits=0
	local rez=""
	local i=0
	for i = 1, string.len(sBytes) do
		byte=byte*256+string.byte(sBytes,i)
		bits=bits+8
		repeat 
			bits=bits-5
			local mul=(2^(bits))
			local b32n=math.floor(byte/mul)
			byte=byte-(b32n*mul)
			b32n=b32n+1
			rez=rez..string.sub(base32,b32n,b32n)
		until bits<5
	end
	if bits>0 then
		local b32n= math.fmod(byte*(2^(5-bits)),32)
		b32n=b32n+1
		rez=rez..string.sub(base32,b32n,b32n)
	end
	return rez
end

function geturlhexbyte(iByte)
		local firstd=math.floor(iByte/16)
		local secondd=iByte-(firstd*16)
		return "%"..thex[firstd+1]..thex[secondd+1]
end

function repl(chr,ord,sch)
	
	if (ord(sch)>=192 and ord(sch)<=239)  then return chr(208)..chr(ord(sch)-48) end
	if (ord(sch)>=240 and ord(sch)<=255) then return chr(209)..chr(ord(sch)-112) end
	if (ord(sch)==168) then return chr(208)..chr(129) end --¨
	if (ord(sch)==184) then return chr(209)..chr(145) end --¸
	if (ord(sch)==150) then return chr(226)..chr(128)..chr(147) end --–
	if (ord(sch)==151) then return chr(226)..chr(128)..chr(148) end --—
	--[[if (ord(sch)==218) then return chr(208)..chr(172) end --Ú
	if (ord(sch)==220) then return chr(208)..chr(170) end --Ü
	if (ord(sch)==250) then return chr(208)..chr(140) end --ú
	if (ord(sch)==252) then return chr(208)..chr(138) end --ü]]
	return chr(ord(sch))
end

function wintoutf8url(st)
	local chr=geturlhexbyte
	local ord=string.byte
--[[

RFC 2396                   URI Generic Syntax                August 1998

2.3. Unreserved Characters

   Data characters that are allowed in a URI but do not have a reserved
   purpose are called unreserved.  These include upper and lower case
   letters, decimal digits, and a limited set of punctuation marks and
   symbols.

      unreserved  = alphanum | mark

      mark        = "-" | "_" | "." | "!" | "~" | "*" | "'" | "(" | ")"

   Unreserved characters can be escaped without changing the semantics
   of the URI, but this should not be done unless the URI is being used
   in a context that does not allow the unescaped character to appear.

]]
	local rez=string.gsub(st, "([^ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789_.!~*'()-])", function(sch)
		if (ord(sch)==" ") then return "+" end --" "
		return repl(chr,ord,sch)
	end)
	return rez
end

function wintoutf8ru(text)
	local chr=string.char
	local ord=string.byte
	local rez=string.gsub(text, "(.)", function(sch)
		return repl(chr,ord,sch)
	end)
	return rez
end

function escapexml(text)
	local rez =  string.gsub(text, "([<>&\"])", function(sch)
		if (sch=="<") then return "&lt;" end
		if (sch==">") then return "&gt;" end
		if (sch=="&") then return "&amp;" end
		if (sch=="\"") then return "&quot;" end
	end)
	return rez
end