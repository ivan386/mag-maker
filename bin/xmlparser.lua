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
	local stpath = {}
	local hashtbl = hashtbl or {}
	local ni,c,label,xarg, empty
	local i, j = 1, 1
	while true do
		ni,j,c,label,xarg, empty = string.find(s, "<(%/?)(%w+)(.-)(%/?)>", i)
		if not ni then break end
		local text = string.sub(s, i, ni-1)
		xarg=parseargs(xarg)
		if label=="File" then
			if c=="" then
				file={path=path..xarg["Name"]}
				table.insert(hashtbl,file)
				setvalue(xarg,"Name",file,"name")
				setvalue(xarg,"Size",file,"size")
				setvalue(xarg,"TTH",file,"tth")
				setvalue(xarg,"SHA1",file,"sha1")
				setvalue(xarg,"MD5",file,"md5")
				setvalue(xarg,"KZH",file,"kzhash")
				setvalue(xarg,"BTIH",file,"btih")
				setvalue(xarg,"AICH",file,"aich")
			end
		elseif label=="Directory" then
			if c=="/" then
				table.remove(stpath)
			elseif empty=="" then
				table.insert(stpath, xarg["Name"])
			end
			if c=="/" or empty=="" then
				path=table.concat(stpath, [[\]])..[[\]]
			end
		elseif (label=="url" or label=="p2purl") and c=="" then
			insertinkey(file,label, xarg["address"])
		elseif label=="tag" then
			if file.tags==nil then
				file.tags={}
			end
			local tagtbl={}
			setvalue(xarg,"name",tagtbl,"name")
			setvalue(xarg,"text",tagtbl,"text")
			if not string.find(text, "^%s*$") then
				tagtbl.text=text
			end
			if next(tagtbl) then table.insert(file.tags, tagtbl) end
		end
		i = j+1
	end
	return hashtbl
end


function main(args)
	for k,v in pairs(args) do
		if v and v~="" then 
			print ([[7za.exe e -o"..\temp\" ]]..v)
			os.execute([[7za.exe e -o"..\temp\" ]]..v)
		end
	end
end


main(args)
-- xmlfile=io.open(args[1],"r")
-- fle=io.open("test.txt","w+")
-- fle:write(Serialize(createht(xmlfile:read("*a")),""))
-- fle:close()