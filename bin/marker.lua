require("encoding") 
require("sharead")

--Start
function main()
	print("File Marker by Ivan386")
	
	local hashloader, err = loadfile("..\\temp\\hash.lua")
	if err or not hashloader then print(err) return nil end
	os.remove("..\\temp\\hash.lua")
	files = hashloader()
	hashloader=nil
	
	for fileidx, fileinfo in pairs(files) do
		if type(forallmod)=="function" then forallmod(fileidx, fileinfo) end
		local hashchecktbl = checkhave(fileinfo)
		local markerfn="("..marker..") "..fileinfo.name.." (SZ_"..fileinfo.size.." "
		-- if hashchecktbl.bSha1 then markerfn=markerfn.."SHA1_"..fileinfo.sha1.." " end
		if hashchecktbl.bTTH then markerfn=markerfn.."TTH_"..fileinfo.tth.." " end
		if hashchecktbl.bEd2k then markerfn=markerfn.."ED2K_"..fileinfo.ed2k.." " end
		local markerfn=markerfn..").txt"
		local markerfn=os.getenv("USERPROFILE").."\\My Documents\\MagMaker\\Markers\\"..marker.."\\"..markerfn
		print(markerfn)
		local markerfile, err = io.open(markerfn,"a")
		if err then print(err); return nil end
		markerfile:write(wintoutf8ru("Marker: "..marker.."\n\n"))
		markerfile:write(wintoutf8ru(hashtext(fileinfo, hashchecktbl)))
		markerfile:write(wintoutf8ru("\n\nComment:\n"))
		markerfile:close()
		print(os.execute("notepad.exe "..markerfn))
	end
end

main()