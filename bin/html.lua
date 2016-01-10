require("encoding") 
require("sharead")

--Start
function main()
	print("MagMaker by Ivan386")

	--print("load hash.lua")
	files = loadfiles()
	if not files then return nil end
	
	wrf=io.open("..\\result\\links.htm","w")


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
			td{
				background-color: #aaaaaa;
			}
			img{
				border: 0px;
			}
			-->
		</style>
	</head>
	<body>
]])

	local lastnames=nil

	for fileidx, hash in pairs(files) do
		--/gnutella/preview/v1?[urn] --превью на файл
		--/gnutella/metadata/v1?[urn] --дополнительные данные на файл (XML)
		--/uri-res/N2R?[urn]  --Источник файла
		if type(forallmod)=="function" then forallmod(fileidx, hash) end
		local havetbl = checkhave(hash)


		local N2Rlink=findN2Rlink(hash.p2purl)
		if N2Rlink then
			wrf:write([[
		<table>
			<tr>
				<td align="center">
					<img src="]]..escapexml(string.gsub(N2Rlink,"%/(uri%-res%/N2R)%?", "/gnutella/preview/v1?"))..[[" alt="]]..escapexml(hash.name)..[[" title="]]..escapexml(hash.name)..[[">
				</td>
			</tr>
			<tr>
				<td valign="bottom">
]])
			
		else
			wrf:write([[
		<table>
			<tr>
				<td align="center">]]..
				[[<a href="/]]..hash.name..[["><img src="/gnutella/preview/v1?urn:tree:tiger:]]..hash.tth..[[" /></a>]]
					--No Preview of ]]..escapexml(hash.name)..[[
				..[[</td>
			</tr>
			<tr>
				<td  valign="bottom">
]])
		end
		if hash.sizef then
			wrf:write("("..hash.sizef..")<br />")
		else
			wrf:write("("..hash.size..")<br />")
		end
		
		wrf:write([[
					<a href="]]..escapexml(magnet(hash, havetbl))..[[">
						<img src="http://www.freebase.be/img/magnet.png" /></a>
]])
		if havetbl.bEd2k then
			wrf:write([[
					<a href="]]..escapexml(ed2klink(hash, havetbl))..[[">
						<img src="http://www.freebase.be/img/ed2k.gif" /></a>
]])
		end
					
		function writeurls(file, urls, prefix)
			if type(urls)=="string" then
				wrf:write([[
					<a href="]]..escapexml(urls)..[=[">[]=]..prefix..[=[1]</a> ]=])
			elseif type(urls)=="table" then
				for index, url in pairs(urls) do
					wrf:write([[
					<a href="]]..escapexml(url)..[=[">[]=]..prefix..index..[=[]</a> ]=])
				end
			end
		end
		
		if havetbl.bUrl then
			writeurls(wrf, hash.url, "")
		end
		
		if havetbl.bPUrl then
			writeurls(wrf, hash.purl, "p")
		end
		
		--[[if havetbl.bP2Purl then
			writeurls(wrf, hash.p2purl, "n")
		end]]
		
		if N2Rlink then
			wrf:write([[
					<a href="]]..escapexml(string.gsub(N2Rlink,"%/uri%-res%/N2R%?", "/gnutella/metadata/v1?" ))..[[">[m]</a>
]])
		end
		
		if havetbl.bSha1 then
			wrf:write([=[
					<br />
					[dl: 7d <img src="http://www.freebase.be/g2/img/]=]..hash.sha1..[=[.png" />, T <img src="http://www.freebase.be/g2/total/]=]..hash.sha1..[=[.png" />]
]=])
		end
		wrf:write([[
				</td>
			</tr>
		</table>
]])

	end

	wrf:write([[
		<p style="clear:left;" align="right">
			<a href="http://shareaza.sf.net">
				Shareaza
			</a>
		</p>
	</body>
</html>]])

	wrf:close()
end

main()