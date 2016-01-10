loaded = require([[torred]])

function patch(file)
	local torrent=readtor(file)
	torrent.v["announce-list"]=nil
	torrent.v["announce"]=nil

	torrent.v["announce"]="" --¬ведите между кавычек (")  адрес трекера на который будет мен€тс€ заданный в торренте
	
	local newpath =string.gsub(file,"(\.tor(r?e?n?t?))$", "[patched]%1") 
	print(newpath)
	writetor(newpath, torrent)
end

for index, path in pairs(args) do
	if string.sub(path,1,1)==[["]] and string.sub(path,-1,-1)==[["]] then
		path=string.sub(path,2,-2)
	end
	if path~="" then patch(path) end
end
