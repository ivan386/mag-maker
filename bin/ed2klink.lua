require("encoding") 
require("sharead")

function tagstotext(tags)
	local rez=""
	for idx, tagdata in pairs(tags) do
		rez=rez.."\n[b]"..tagdata["name"]..":[/b] "..tagdata["text"]
	end
	return rez
end

function main()
	print("File ED2KLinker by Ivan386")
	
	files=loadfiles()
	if not files then return nil end
	
	bbf=io.open("..\\result\\links.txt","w")
	
	for fileidx, fileinfo in pairs(files) do
		local havetbl = checkhave(fileinfo)
		if havetbl.bEd2k then
			bbf:write(ed2klink(fileinfo, havetbl).."\n")
		end
	end
end

main()