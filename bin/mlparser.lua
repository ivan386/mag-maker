require([[serialize]])

function splitpath(path)
	--print(path)
	names={}
	string.gsub(path, "([^\\]+)", function(dirname) 
		table.insert(names,dirname)
		--print(dirname)
	end)
	return names
end

function parseargs(s)
	local arg = {}
	string.gsub(s, "(%w+)=([\"'])(.-)%2", function (w, _, a)
		arg[w] = a
	end)
	return arg
end

function setvalue(tbl1, tbl1key, tbl2, tbl2key)
	if tbl1[tbl1key] and tbl1[tbl1key]~="" then
		tbl2[tbl2key]=tbl1[tbl1key]
	end
end

function insertinkey(tTable, key, newvalue)
	if tTable[key] then
		if type(tTable[key])~="table" then
			tTable[key]={tTable[key]}
		end
		table.insert(tTable[key],newvalue)
	else
		tTable[key]=newvalue
	end
end

function createht(s, hashtbl)
	local path = ""
	local file = nil
	local hashtbl = hashtbl or {}
	local ni,c,label,xarg, empty
	local i, j = 1, 1
	local startlabel
	local slargs
	local xmlpath=""
	while true do
		ni,j,c,label,xarg, empty = string.find(s, "<(%/?)(%w+)(.-)(%/?)>", i)
		if not ni then break end
		local text = string.sub(s, i, ni-1)
		xarg=parseargs(xarg)
		if c=="" and empty=="" then
			xmlpath=xmlpath.."/"..label
			startlabel=label
			slargs=xarg
			
		end
		if xmlpath=="/metalink/files/file" then
			if c=="" then
				file={path=path..xarg["name"]}
				table.insert(hashtbl,file)
				file.name = string.match(xarg["name"],"[/\\]?([^/\\]-)$")
			end
		elseif xmlpath=="/metalink/files/file/size" and c=="/" and (text and text~="")  then
			file["size"]=tonumber(text)
		elseif xmlpath=="/metalink/files/file/verification/hash" and c=="/" and (text and text~="") then
			if slargs.type=="kzh" then  slargs.type="kzhash" end
			file[slargs.type]=text
		elseif xmlpath=="/metalink/files/file/resources/url" and c=="/" and (text and text~="") then
			if file.url then
				table.insert(file.url,text)
			else
				file.url={text}
			end
		end
		if c=="/" then
			local lastlbl
			xmlpath, lastlbl=string.match(xmlpath,"(.-)[/\\]([^/\\]-)$")
			if lastlbl~=label then print(lastlbl.." ~= "..label) end
		end
		i = j+1
	end
	return hashtbl
end

function start()
	local filestbl={}
	for index, path in pairs(arg) do
		if type(index)=="number" and index>=1 then
			local filein = io.open(path, "r")
			createht(filein:read("*a"),filestbl)
			filein:close()
		end
	end
	fileout= io.open("../temp/hashpart.txt","w")
	fileout:write(Serialize(filestbl, ""))
	fileout:close()
end

start()