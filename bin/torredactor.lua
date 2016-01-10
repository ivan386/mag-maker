loaded = require("torred")
loaded = require("serialize")

local repl={["�"]=128,["�"]=129,["�"]=130,["�"]=131,
["�"]=132,["�"]=133,["�"]=134,["�"]=135,["�"]=136,
["�"]=137,["�"]=138,["�"]=139,["�"]=140,["�"]=141,
["�"]=142,["�"]=143,["�"]=144,["�"]=145,["�"]=146,
["�"]=147,["�"]=148,["�"]=149,["�"]=150,["�"]=151,
["�"]=152,["�"]=153,["�"]=154,["�"]=155,["�"]=156,
["�"]=157,["�"]=158,["�"]=159,["�"]=160,["�"]=161,
["�"]=162,["�"]=163,["�"]=164,["�"]=165,["�"]=166,
["�"]=167,["�"]=168,["�"]=169,["�"]=170,["�"]=171,
["�"]=172,["�"]=173,["�"]=174,["�"]=175,["�"]=224,
["�"]=225,["�"]=226,["�"]=227,["�"]=228,["�"]=229,
["�"]=230,["�"]=231,["�"]=232,["�"]=233,["�"]=234,
["�"]=235,["�"]=236,["�"]=237,["�"]=238,["�"]=239,
["�"]=240,["�"]=241}


function forwin(text)
	local t = string.gsub(text, "([�-�])", function(ch)
		return string.char(repl[ch])
	end)
	return t
end

local thex={"0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"}
function tohex(str)
        local hex=""
        for i=1,string.len(str) do
            local digit = str:byte(i)
            local firstd=math.floor(digit/16)
            local secondd=digit-(firstd*16)
            hex=hex..thex[firstd+1]..thex[secondd+1]
        end
        return hex
end

local b16dec = function (s)
	return string.gsub(s, "(%[A-F0-9a-f]%[A-F0-9a-f])", function(hex)
		return string.char(base.tonumber(hex, 16))
	end)
end

--[[ Lua 5.1  ]]--
local base32="ABCDEFGHIJKLMNOPQRSTUVWXYZ234567"
function b32dec(b32str)
	local byte=0
	local bits=0
	local rez=""
	string.gsub(string.upper(b32str), "(["..base32.."])", function(ch)
		local n=string.find(base32,ch)
		n=n-1
		byte=byte*32+n
		bits=bits+5
		if bits>=8 then
			bits=bits-8
			rez=rez..string.char(math.floor(byte/(2^bits)))
			byte=math.fmod(byte,(2^bits))
		end 
	end)
	-- if bits>0 then
		-- rez=rez..string.char(byte*(2^(8-bits)))
	-- end
	return rez
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

function hexdec(hex)
	return string.gsub(hex, "([0-9A-Fa-f][0-9A-Fa-f])", function(hex)
		return string.char(tonumber(hex, 16))
	end)
end

function bits(bytes)
	local rez=""
	local chi=0
	local i=0
	for chi=1,string.len(bytes) do
		local byte=string.byte(bytes,chi)
		for i = 7,0,-1 do
			local m=(2^i)
			local x=math.floor(byte/m)
			byte=byte-(x*m)
			if x>0 then	rez=rez.."1" else rez=rez.."0" end
		end
	end
	return rez
end


torrents={}
pieces={}
lastindex=0
line="-------------------------------------------------------------------------------"
function help(command)
	if command==nil then
		print(line)
		print(forwin(
[[
Torrent Redactor by Ivan386

	�������� �������:
		help(command) -- ������� ������ �� �������
		open(filename) -- ��������� �������
		save(filename,index) -- ��������� �������
		printT(tbl,name) -- ���������� ���������� ��������
		p(index) -- ���������� ���������� �������� torrents[index]
	
	�������:
		torrents -- ������ �������� ��������
		pieces -- ������ ���� pieces ���������

	� ����� ��� �������� ����������� ����������� ����� Lua
		
]]
		))
		print(line)
		
	elseif command==open or command=="open" then
		print(line)
		print(forwin(
[[
	help(command) -- ������� ������ �� �������
		command -- ��� �������. ���������� ������ � �������� "
		
]]
		))
		print(line)
	elseif command==open or command=="open" then
		print(line)
		print(forwin(
[[
	open(filename) -- ��������� �������
		filename -- ��� ������� ����� ������� ���� �������

		���� ����������� � �������� � �������� torrents ��� ��������� ��������
		���� pieces ����������� �������� � �������� pieces
]]		
		))
		print(line)
	elseif command==save or command=="save" then
		print(line)
		print(forwin(
[[
	save(filename,index) -- ��������� �������
		filename -- ��� ������� ����� ������� ���� �������
		index -- ������ ��������� ��������
		
		��������� � ���� ������ ��� �������� ��������
]]		
		))
		print(line)
	elseif command==printT or command=="printT" then
		print(line)
		print(forwin(
[[
	printT(tbl,name) -- ���������� ���������� ��������
		tbl -- ��������
		name -- ��� �������� (������������ ���������)
]]		
		))
		print(line)
	elseif command==torrents or command=="torrents" then
		print(line)
		print(forwin(
[[
	torrents -- ������ �������� ��������
	l (list) � d (dictionary) ����������� � �������� � �������:
		� ���� t (type) �������� ����� ������ "l" ��� "d" ��������������
		� ���� v (value) �������� ������� ������ � �������� ����� ��� �������.
]]
		))
		print(line)
	end
end

function open(filename)
	lastindex=lastindex+1
	--filename=towin(filename)
	--print(filename)
	torrents[lastindex]=readtor(filename)
	pieces[lastindex]=torrents[lastindex].v.info.v.pieces
	torrents[lastindex].v.info.v.pieces=nil
	print(line)
	print(forwin(filename.."\n\t������ � torrents["..lastindex.."]"))
	print(forwin("\t���� torrents["..lastindex.."].v.info.v.pieces ��������� � pieces["..lastindex.."]"))
	print(line)
end

function save(filename,index)
	torrents[index].v.info.v.pieces=pieces[index]
	writetor(filename,torrents[index])
	torrents[index].v.info.v.pieces=nil
	print(forwin("� "..filename.." ���������  torrents["..index.."]"))
end

function UserSerialize(key,value, tTable, sTableName, sTabs, sLongKey)
	if type(value)=="string" and (key=="sha1" or key=="ed2k")then
		local s = string.format(value,"%q")
		local v = string.gsub(s, "([%c])", function(chr)
			local b = string.byte(chr)
			if string.len(b)<2 then b="0"..b end
			if string.len(b)<3 then b="0"..b end
			b="\\"..b
	        return b
	    end)
		local k = string.format(key,"%q")
		return sTabs.."\t".."[\""..k.."\"]=\""..v.."\",\n"
	end
end

function writein(filename, data)
	local f=io.open(filename,"w")
	f:write(data)
	f:close()
end

function insert(dict,index,key,data)
	table.insert(dict.o,index,key)
	dict.v[key]=data
end

function p(index)
	assert(type(index)=="number","index must be a number")
	printT(torrents[index],"torrents["..index.."]")
end

function printT(tbl,name)
	print(line)
	if name==nil then name="print" end
	print (Serialize(tbl,name,"\n","\t",UserSerialize))
	print(line)
end

-- for i=0,255 do
	-- print("[\""..string.char(i).."\"]="..i)
-- end
help()

if arg[1] then
	open(arg[1])
end
