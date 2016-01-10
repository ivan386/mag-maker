local base32="ABCDEFGHIJKLMNOPQRSTUVWXYZ234567"


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

local thex={"0","1","2","3","4","5","6","7","8","9","A","B","C","D","E","F"}

function geturlhexbyte(iByte)
		local firstd=math.floor(iByte/16)
		local secondd=iByte-(firstd*16)
		return "%"..thex[firstd+1]..thex[secondd+1]
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

function urlstomagnet(amp, prefix,urls)
		local rez=""
		local wtoutf8url=function(url)
			if string.sub(url,1,5)=="dchub" then
				return url
			else
				return wintoutf8url(url)
			end
		end
		if type(urls)=="string" then
			rez=rez..amp..prefix..wtoutf8url(urls) 
		elseif type(urls)=="table" then
			for idx, urldata in pairs(urls) do
				rez=rez..amp..prefix..wtoutf8url(urldata)
				if amp=="" then amp="&" end
			end
		end
		return rez
end

function checkdata(data)
	if type(data)=="table" then 
		if next(data) then
			return "table"
		else
			return nil
		end
	elseif (type(data)=="string" and (data~="")) then
		return "string"
	else
		return nil
	end
end

function checkhave(hash)
	local hw = {
		bUrl = checkdata(hash.url),
		bPUrl=checkdata(hash.purl),
		bP2Purl=checkdata(hash.p2purl),
		bSha1=checkdata(hash.sha1),
		bTTH=checkdata(hash.tth),
		bEd2k=checkdata(hash.ed2k),
		bAich=checkdata(hash.aich),
		bMd5 =checkdata(hash.md5),
		bCrc32 =checkdata(hash.crc32),
		bTiger =checkdata(hash.tiger),
		bKZhash =checkdata(hash.kzhash),
		bBtih=checkdata(hash.btih),
		bUuid=checkdata(hash.uuid),
		bTags=checkdata(hash.tags)}
		hw.bHashed=hw.bSha1 or hw.bTTH or hw.bEd2k or hw.bAich or hw.bMd5 or hw.bCrc32 or hw.bTiger or hw.bKZhash or hw.bBtih
	
	return hw
end

function magnet(fileinfo, havetbl, tthfirst)
	local sLink="magnet:?"
	function amp()
		if string.len(sLink)>8 then 
			return "&" 
		else 
			return "" 
		end
	end
	function add(text)
		sLink=sLink..amp()..text
	end
	if tthfirst then
		if havetbl.bTTH  then add("xt=urn:tree:tiger:"..fileinfo.tth) end
		if fileinfo.size then add("xl="..fileinfo.size) end
		if fileinfo.name then add("dn="..wintoutf8url(fileinfo.name)) end
		if havetbl.bEd2k then add("xt=urn:ed2k:"..fileinfo.ed2k) end
	else
		if havetbl.bEd2k then add("xt=urn:ed2k:"..fileinfo.ed2k) end
		if fileinfo.size then add("xl="..fileinfo.size) end
		if fileinfo.name then add("dn="..wintoutf8url(fileinfo.name)) end
	end

	if havetbl.bSha1 and havetbl.bTTH then
		add("xt=urn:bitprint:"..fileinfo.sha1.."."..fileinfo.tth)
	else
		if havetbl.bSha1 then add("xt=urn:sha1:"..fileinfo.sha1) end
		if havetbl.bTTH and (tthfirst==nil or tthfirst==false) then add("xt=urn:tree:tiger:"..fileinfo.tth) end
	end
	if havetbl.bAich then add("xt=urn:aich:"..fileinfo.aich) end
	if havetbl.bBtih then add("xt=urn:btih:"..fileinfo.btih) end
	if havetbl.bKZhash then add("xt=urn:kzhash:"..fileinfo.kzhash) end
	if havetbl.bMd5 then add("xt=urn:md5:"..fileinfo.md5) end
	if havetbl.bTiger then add("xt=urn:tiger:"..fileinfo.tiger) end
	if havetbl.bCrc32 then add("xt=urn:crc32:"..fileinfo.crc32) end
	if havetbl.bUuid then add("xt=urn:uuid:"..fileinfo.uuid) end
	if havetbl.bUrl then  add(urlstomagnet(amp(), "as=",fileinfo.url))	end
	if havetbl.bP2Purl then add(urlstomagnet(amp(), "xs=",fileinfo.p2purl)) end
	return sLink
end

function hexurldec(hex)
	return string.gsub(hex, "%%([0-9A-Fa-f][0-9A-Fa-f])", function(hex)
		return string.char(tonumber(hex, 16))
	end)
end

function checkfileexist(filepath)
	local file = io.open(filepath, "rb")
	if file then
		local size=file:seek("end")
		if size > 3 then
			newpos = file:seek("end",-3)
			if newpos == size-3 then
				bytes = file:read(3)
				if string.len(bytes) == 3 then
					file:close()
					return size
				end
			end
		else
			file:close()
			return size
		end
	end
	return false
end

function escapeurl(rawurl)
	local rez =  string.gsub(rawurl, "([^A-z0-9])", function(sch)
		return geturlhexbyte(string.byte(sch,1))
	end)
	return rez
end

function escapexml(text)
	local rez =  string.gsub(text, "([<>&\"\010\013])", function(sch)
		if (sch=="<") then return "&lt;" end
		if (sch==">") then return "&gt;" end
		if (sch=="&") then return "&amp;" end
		if (sch=="\"") then return "&quot;" end
		if (sch=="\010") then return "&#010;" end
		if (sch=="\013") then return "&#013;" end
	end)
	return rez
end

site = "http://ivan386.narod.ru/p2p/"

function encode_magnet(filepath)
	local newfilepath = getnewpatch(filepath)
	sizeifexist = checkfileexist(newfilepath)
	print (newfilepath, sizeifexist, "magnet")	
	if (sizeifexist ~= nil and sizeifexist~=false) then
		local cmd = nil
		local uuid = nil
		local name = nil
		os.execute("del ..\\temp\\hashpart.txt")
		if string.sub(newfilepath,-3)=="htm" or string.sub(newfilepath,-4)=="html" then
			local data, fileidtbl = packfile(newfilepath)
			uuid = fileidtbl.uuid
			if fileidtbl.magnet then return fileidtbl.magnet, fileidtbl end
			if data then
				name = fileidtbl.magname
				local file = io.open("../temp/hashthisfile.bin", "wb")
				file:write(data)
				file:close()
				os.execute ("rhash.cmd ../temp/hashthisfile.bin")
				cmd={bg="move ..\\temp\\hashthisfile.bin ..\\result\\", en=""}
			elseif fileidtbl.uuid then
				local fileinfo={
					name=fileidtbl.magname,
					uuid=uuid
				}
				if site then fileinfo.url=site..uuid end
				return magnet(fileinfo, checkhave(fileinfo)), fileidtbl
			end
		else
			name = string.match(newfilepath, "[^\\/]+$")
			os.execute ("rhash.cmd \""..newfilepath.."\"")
			cmd={bg="copy \""..newfilepath.."\" ..\\result\\", en=""}
		end
		local file = io.open("../temp/hashpart.txt", "rb")
		hashpartdata = file:read("*a")
		print(hashpartdata)
		local fileinfo, err = loadstring("return {"..hashpartdata.."}")()
		print(err)
		file:close()
		fileinfo = fileinfo[1]
		fileinfo.uuid = uuid
		fileinfo.name = name
		if site and name then fileinfo.p2purl=site..uuid end
		local magnetlnk = magnet(fileinfo, checkhave(fileinfo))
		paths[newfilepath].fileinfo = fileinfo
		paths[newfilepath].magnet = magnetlnk
		if uuid then fid = name elseif fileinfo.tth then fid = fileinfo.tth end
		if cmd then os.execute (cmd.bg..fid..cmd.en) end
		return magnetlnk, paths[newfilepath]
	else return filepath
	end
end

function encode_magnet1(b, filepath, e)
	local magnet, info = encode_magnet(filepath)
	if info and info.magname then
		return "<a href=\""..escapexml(magnet).."\">[magnet]</a> "..b..info.magname..e
	else
		return b..escapexml(magnet)..e
	end
end



function binutf8towin1251(text)
	local res = string.gsub(text, "([\208\209])(.)", function(code,char) --utf8 to 1251
		if code=="\208" and char=="\129" then return "\168"
		elseif code=="\209" and char=="\145" then return "\184" 
		elseif code=="\208" then return string.char(string.byte(char, 1)+48)
		elseif code=="\209" then return string.char(string.byte(char, 1)+112)
		end
	end)
	return res
end

function getnewpatch(filepath)
	local newfilepath = toppath..binutf8towin1251(hexurldec(filepath))
	newfilepath = string.gsub(newfilepath, "/","\\")
	return newfilepath
end

function encode_data1(b, filepath, e)
	return b..encode_data(filepath)..e
end

function encode_data(filepath)
	local newfilepath = getnewpatch(filepath)
	sizeifexist = checkfileexist(newfilepath)
	print (newfilepath, sizeifexist)
	if (sizeifexist ~= nil and sizeifexist~=false) and (sizeifexist < 300000) then
		local function packfile1(newfilepath, nosign)
			local data = packfile(newfilepath, nosign)
			if data==nil then return "" else return data end
		end
		if string.sub(newfilepath,-4)==".htm" or string.sub(newfilepath,-5)==".html" then
			return "data:text/html;,"..escapeurl(packfile1(newfilepath))
		elseif string.sub(newfilepath,-4)==".css" then
			return "data:text/css;,"..escapeurl(packfile1(newfilepath, nosign))
		else
			os.execute ("base64 -e \""..newfilepath.."\" ..\\temp\\encb64.txt")
			local file = io.open("../temp/encb64.txt","rb")
			local data = file:read("*a")
			data = string.gsub(data,"[\n\f\r]","")
			file:close(file)
			os.execute ("del ..\\temp\\encb64.txt")
			return "data:application/octet-stream;base64,"..data
		end
	else return filepath end
end

toppath=""
savedtp={}
paths={}




function settoppath(filepath)
	table.insert(savedtp,toppath)
	toppath=string.match(filepath, "(.*\\)[^\\]*$")
end

function signdata(data)
	os.execute("del ..\\temp\\datatosign.sig&del ..\\temp\\datatosign.htm")
	local file = io.open("../temp/datatosign.htm","wb")
	file:write(data)
	file:close()
	os.execute("\"C:\\Program Files\\GNU\\GnuPG\\gpg.exe\" --armor --output ..\\temp\\datatosign.sig --detach-sign ..\\temp\\datatosign.htm")
	file = io.open("../temp/datatosign.htm","rb")
	data = file:read("*a")
	file:close()
	os.execute("del ..\\temp\\datatosign.htm")
	file = io.open("../temp/datatosign.sig","rb")
	local sign = file:read("*a")
	file:close()
	local data = string.gsub( data, "</[Hh][Tt][Mm][Ll]>", "%1<!-- \n"..sign.." \n-->", 1)
	return data
end

math.randomseed (os.time())
function newuuid()
	local function h(len) --8 max
		return string.sub(string.format("%x",math.random(-1, 2147483647 --[[(2^((8*4)-1)-1)]])),-len)
	end
	return h(4)..h(4).."-"..h(4).."-"..h(4).."-"..h(4).."-"..h(6)..h(6)
end

--[[] ]
nid = newuuid()
nidt = {}
print(nid)
while nidt[nid]==nil do
	nidt[nid]=true
	nid = newuuid()
	print(nid)
end
--[ []]

function packfile(filepath, nosign)
	settoppath(filepath)
	if paths[filepath]==nil then
		local info={uuid=newuuid(), name=string.match(filepath, "[^\\/]+$"), path=filepath}
		paths[filepath]=info
		local name, ext = string.match(info.name, "(.-)(%.?[^%.]*)$")
		info.ext = ext
		info.magname = name.."_("..string.gsub(info.uuid, "-", "_")..")"..ext
		local file, err = io.open(filepath,"rb")
		local data = file:read("*a")
		
		print(filepath, err, string.len(data))
		file:close()
		
		data = string.gsub(	data, "<[Hh][Ee][Aa][Dd]>", "%1\n<meta http-equiv=\"X-Content-URN\" content=\"urn:uuid:"..info.uuid.."\" />" , 1)
		data = string.gsub( data, "<[Ll][Ii][Nn][Kk][^>]-rel=\"?stylesheet\"?[^>]->", 
			function (link)
				local filepath = string.match( link, "href=\"([^:\"]+)#?([^:\"]*)\"")
				local newfilepath = getnewpatch(filepath)
				local sizeifexist = checkfileexist(newfilepath)
				if sizeifexist then
					local data = packfile(newfilepath, true)
					return "<style>\n<!--\n"..data.."\n-->\n</style>"
				end
				return nil
			end
		)
		data = string.gsub( data, 'encode="data"(%s+href=")([^:"#]*)(#?[^:"]*")', encode_data1 )
		data = string.gsub( data, '(<a[^>]*%s+href=")([^:"#]+)(#?[^:"]*")', encode_magnet1 )
		data = string.gsub(	data, '(url%([\'"]?)([^:\'"]*)([\'"]?%))', encode_data1 )
		data = string.gsub( data, '(src=[\'"])([^:"]*)([\'"])', encode_data1 )
		-- data = string.gsub(	data, "[%s]+", " " )
		-- if nosign==nil then data = signdata( data ) end
		info.data = data
		toppath = table.remove(savedtp)
		return data, info
	else return paths[filepath].data, paths[filepath]
	end
end

os.execute("del ..\\result\\*")
i=1
while arg[i] do

data, info = packfile(arg[i])

file = io.open("../result/"..info.magname,"wb")
file:write(data)
file:close()
i=i+1
end
