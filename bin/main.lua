require("encoding") 
require("sharead")

--Start
function main()
	print("MagMaker by Ivan386")

	--print("load hash.lua")
	files = loadfiles()
	if not files then return nil end
	
	wrf=nil

	if xmlfl then
		wrf=io.open("..\\temp\\files.xml","w")
	elseif htmltbl then
		wrf=io.open("..\\result\\links.htm","w")
	else
		wrf=io.open("..\\result\\links.txt","w")
	end

	if bbcode then
		print("bbcode")
	elseif htmlenc then
		print("html")
	elseif htmltbl then --html document select
		wrf:write([[
	<html>
		<head>
			<style>
				<!--
				table{
					width: 140px;
					height: 220px;
					float: left;
					border: 1px solid black;
				}
				-->
			</style>
		</head>
		<body>
		]])
		htmlenc=1
	elseif xmlfl then
		

		wrf:write([[<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<FileListing Version="1" CID="MAGNETMAKERBYIVAN386FORUM0PROC0RUP2PNET" Base="/" Generator="Magnet Maker">
	]])
	else
		print("magnet")
	end

	local lastnames=nil

	for fileidx, hash in pairs(files) do
		--/gnutella/preview/v1?[urn] --превью на файл
		--/gnutella/metadata/v1?[urn] --дополнительные данные на файл (XML)
		--/uri-res/N2R?[urn]  --Источник файла
		if type(forallmod)=="function" then forallmod(fileidx, hash) end
		local havetbl = checkhave(hash)

		if htmlenc then
			wrf:write("\n<a href=\"")
			wrf:write(escapexml(magnet(hash, havetbl)))
			wrf:write("\">"..escapexml(hash.name).."</a><br />")
		elseif xmlfl then
			if hash.path then
				hash.path=correctpath(hash.path, args)
				local names=splitpath(hash.path)
				table.remove(names) --Удаляем имя файла
				local startindex=0
				local closefolders=false
				if lastnames then
					for index,name in pairs(lastnames)do
						if (closefolders==false) and (names[index]~=name) then
							closefolders=true
						end
						if closefolders==false then
							startindex=index+1
						end
						if closefolders then
							wrf:write("</Directory>\n")
						end
					end
				end
				
				for index,name in pairs(names)do
					if index>=startindex then
						wrf:write("<Directory Name=\""..wintoutf8ru(escapexml(name)).."\">\n")
					end
				end
				lastnames=names
			end
			wrf:write(filelist(hash, havetbl))
			wrf:write("\n")
		elseif bbcode then
			wrf:write("[url=\"")
			wrf:write(magnet(hash, havetbl))
			wrf:write("\"]"..hash.name.."[/url]")
			wrf:write("\n\n")
		elseif htext then
			wrf:write(hashtext(hash, havetbl))
			wrf:write("\n")
		else
			--wrf:write("#"..fileidx.." "..(hash.path or "").."\n")
			wrf:write(magnet(hash, havetbl))
			wrf:write("\n\n")
		end
	end
	
	if xmlfl then
		for index,name in pairs(names)do
			wrf:write("</Directory>\n")
		end
		wrf:write("</FileListing>")
	end

	wrf:close()
end

main()