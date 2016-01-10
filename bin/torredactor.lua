loaded = require("torred")
loaded = require("serialize")

local repl={["А"]=128,["Б"]=129,["В"]=130,["Г"]=131,
["Д"]=132,["Е"]=133,["Ж"]=134,["З"]=135,["И"]=136,
["Й"]=137,["К"]=138,["Л"]=139,["М"]=140,["Н"]=141,
["О"]=142,["П"]=143,["Р"]=144,["С"]=145,["Т"]=146,
["У"]=147,["Ф"]=148,["Х"]=149,["Ц"]=150,["Ч"]=151,
["Ш"]=152,["Щ"]=153,["Ъ"]=154,["Ы"]=155,["Ь"]=156,
["Э"]=157,["Ю"]=158,["Я"]=159,["а"]=160,["б"]=161,
["в"]=162,["г"]=163,["д"]=164,["е"]=165,["ж"]=166,
["з"]=167,["и"]=168,["й"]=169,["к"]=170,["л"]=171,
["м"]=172,["н"]=173,["о"]=174,["п"]=175,["р"]=224,
["с"]=225,["т"]=226,["у"]=227,["ф"]=228,["х"]=229,
["ц"]=230,["ч"]=231,["ш"]=232,["щ"]=233,["ъ"]=234,
["ы"]=235,["ь"]=236,["э"]=237,["ю"]=238,["я"]=239,
["Ё"]=240,["ё"]=241}


function forwin(text)
	local t = string.gsub(text, "([А-я])", function(ch)
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

	Доступны команды:
		help(command) -- выводит помощь по команде
		open(filename) -- открывает торрент
		save(filename,index) -- сохраняет торрент
		printT(tbl,name) -- показывает содержимое таблитци
		p(index) -- показывает содержимое таблитци torrents[index]
	
	Таблицы:
		torrents -- хранит открытые торренты
		pieces -- хранит поля pieces торрентов

	А также вам доступны стандартные возможности языка Lua
		
]]
		))
		print(line)
		
	elseif command==open or command=="open" then
		print(line)
		print(forwin(
[[
	help(command) -- выводит помощь по команде
		command -- имя команды. Желательно писать в кавычках "
		
]]
		))
		print(line)
	elseif command==open or command=="open" then
		print(line)
		print(forwin(
[[
	open(filename) -- открывает торрент
		filename -- имя торрент файла который надо открыть

		файл открывается и читается в таблитцу torrents под свободным индексом
		поле pieces сохраняется отдельно в таблитцу pieces
]]		
		))
		print(line)
	elseif command==save or command=="save" then
		print(line)
		print(forwin(
[[
	save(filename,index) -- сохраняет торрент
		filename -- имя торрент файла который надо открыть
		index -- индекс открытого торрента
		
		сохраняет в файл торент под заданным индексом
]]		
		))
		print(line)
	elseif command==printT or command=="printT" then
		print(line)
		print(forwin(
[[
	printT(tbl,name) -- показывает содержимое таблитци
		tbl -- таблитца
		name -- имя таблитци (опциональный параметер)
]]		
		))
		print(line)
	elseif command==torrents or command=="torrents" then
		print(line)
		print(forwin(
[[
	torrents -- хранит открытые торренты
	l (list) и d (dictionary) сохраняются в таблитцу в которой:
		в поле t (type) хранится метка литера "l" или "d" соответственно
		в поле v (value) хранится таблица ключей и значений листа или словаря.
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
	print(forwin(filename.."\n\tоткрыт в torrents["..lastindex.."]"))
	print(forwin("\tполе torrents["..lastindex.."].v.info.v.pieces сохранено в pieces["..lastindex.."]"))
	print(line)
end

function save(filename,index)
	torrents[index].v.info.v.pieces=pieces[index]
	writetor(filename,torrents[index])
	torrents[index].v.info.v.pieces=nil
	print(forwin("в "..filename.." сохранено  torrents["..index.."]"))
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
