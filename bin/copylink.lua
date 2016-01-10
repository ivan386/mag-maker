function printfileinfo(fileinfo)
	if fileinfo then
		print()
		print(fileinfo.path)
		print(fileinfo.hash, fileinfo.size)
	end
end

function command(c, noreturn)
	os.execute(c.." > ..\\temp\\cmdres.txt")
	os.execute("@fdoswin /off ..\\temp\\cmdres.txt")
	local listfile=io.open("../temp/cmdres.txt","r")
	local list=listfile:read("*a")
	listfile:close()
	return list
end

function getfilehash(fileinfo)
	os.execute("@clrhash.cmd \""..fileinfo.path.."\" > ..\\temp\\rhashres.txt")
	local newfileinfo = loadfile("..\\temp\\rhashres.txt")()
	
	if newfileinfo then
		local hash = newfileinfo.sha1
		if hash and fileinfo.size==newfileinfo.size and newfileinfo.path~=""  then
			fileinfo.name=newfileinfo.name
			fileinfo.path=newfileinfo.path
			fileinfo.hash=hash
			printfileinfo(fileinfo)
			return hash
		end
	end
end

function getlist(path, dft)
	return command("@dir /s /a:"..dft.." /b \""..path.."\"")
end

function getfilesize(fileinfo)
	local listfile=io.open(fileinfo.path,"r")
	if listfile then
		local size=listfile:seek("end")
		listfile:close()
		fileinfo.size=size
		return size
	end
end

function readfirstbytes(fileinfo, part)
	local file=io.open(fileinfo.path,"r")
	local bytes
	if fileinfo.size<=part then
		bytes=file:read(fileinfo.size)
	else
		file:seek("set",0)
		local partsize=math.floor(part/3)
		local part1=file:read(partsize)
		local point2 = partsize+math.floor((fileinfo.size-part)/2)
		if point2~=file:seek("set", point2) then return nil end
		local part2=file:read(partsize)
		local point3=file:seek("end") - (partsize)
		if point3~=file:seek("set", point3) then return nil end
		local part3=file:read(partsize)
		if not (part1 and part2 and part3) then
			printfileinfo(fileinfo)
			print(part)
			print(point2, point3)
			return nil
		else
			bytes=part1..part2..part3
		end
		
	end
	file:close()
	fileinfo.bytes=bytes
	return bytes
end

function makroCheckBy(fileinfo, firstinlist, list, idfunct, param2, noremovefirst)
	local fileid=idfunct(fileinfo, param2)
	if fileinfo and fileid and firstinlist and list then
		local firstinlistid=idfunct(firstinlist, param2)
		if fileid == firstinlistid then
			local newlist={}
			list[fileid]=newlist
			return newlist, firstinlist
		else
			if fileid then list[fileid]={[-1]=fileinfo} end
			if firstinlistid then list[firstinlistid]={[-1]=firstinlist} end
		end
	elseif fileinfo and fileid and list then
		local list2=list[fileid]
		if list2 then
			firstfile = list2[-1]
			if firstfile and not noremovefirst then
				list2[-1]=nil
			end
			return list2, firstfile
		else
			list[fileid]={[-1]=fileinfo}
			return nil
		end
	end
end

checklist={[1]=getfilesize, [2]=readfirstbytes, [3]=getfilehash}
by_size_bytes_hash={}
counters={}
copylists={}
firstpart=900

function dirfind(path)
	for filepath in string.gmatch(getlist(path,"-d"), "[^\n]+") do
		if filepath and filepath~="" then
			local fncidx=1
			local list, firstfile = by_size_bytes_hash, nil
			local fileinfo={path=filepath}
			repeat
				list, firstfile = makroCheckBy(fileinfo, firstfile, list, checklist[fncidx], (fncidx==2 and firstpart))
				fncidx=fncidx+1
			until ((fncidx==4) or (not list))

			if  list and fileinfo.hash then
				print("find: "..fileinfo.hash)
				if firstfile then table.insert(list,firstfile) end
				table.insert(list,fileinfo)
				copylists[fileinfo.hash]=list
				local counter=counters[fileinfo.hash]
				if counter then
					counters[fileinfo.hash]=counter+1
				else
					counters[fileinfo.hash]=1
				end
			end
		end
    end
end

local i=1
while arg[i] do
dirfind(arg[i])
i=i+1
end

result=io.open("../result/clres.txt","w")
hl=io.open("../result/clrun.cmd","w")
print("----------------------------------------------------------------")
freebytes=0
for hash, files1 in pairs(copylists) do
	local line = "\nHASH: "..hash.."\nSIZE: "..files1[1].size
	local masterfile
	local idx = 1
	for hash, fileinfo in pairs(files1) do
		if idx==1 then
			masterfile=fileinfo.path
			line = line.."\n".."FILE: "..fileinfo.path
		elseif idx==2 then
			line=line.."\nFILE: "..fileinfo.path
			result:write("\n"..line)
			print(line)
		else
			line = "FILE: "..fileinfo.path
			result:write("\n"..line)
			print(line)
		end
		if idx>1 then
			hl:write("\ndel \""..fileinfo.path.."\"")
			hl:write("\nfsutil hardlink create \""..fileinfo.path.."\" \""..masterfile.."\"")
			freebytes=freebytes+fileinfo.size
		end
		idx=idx+1
	end
end
print("----------------------------------------------------------------")
print("Free size: "..freebytes)
result:close()
hl:close()