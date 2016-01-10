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
	print("File BBCoder by Ivan386")
	
	files=loadfiles()
	if not files then return nil end
	
	bbf=io.open("..\\result\\links.txt","w")
	
	magnettag = settings.bbcode.tags.magnet or "url"
	ed2ktag = settings.bbcode.tags.ed2k or "url"
	
	retimg=function(imgurl)
		if imgurl then
			return "[img]"..imgurl.."[/img]"
		else
			return ""
		end
	end
	ed2kimg = retimg(settings.bbcode.imgs.ed2k)
	magnetimg=retimg(settings.bbcode.imgs.magnet)
	
	
	for fileidx, fileinfo in pairs(files) do
		if type(forallmod)=="function" then forallmod(fileidx, fileinfo) end
		local havetbl = checkhave(fileinfo)
		if havetbl.bTags then bbf:write("\n"..tagstotext(fileinfo.tags)) end

		bbf:write("\n")
		
		if havetbl.bHashed then
			bbf:write(magnetimg.." ["..magnettag.."="..magnet(fileinfo, havetbl).."][m][/"..magnettag.."]")
		end
		
		if havetbl.bEd2k then
			bbf:write(" "..ed2kimg.." ["..ed2ktag.."="..ed2klink(fileinfo, havetbl).."][e][/"..ed2ktag.."]")
		end
		
		local UrlB = ""
		local UrlE = ""
		
		if settings.counters.freebase and settings.addlink.freebase and havetbl.bSha1 then
			bbf:write(" [DL: 7d [img]http://www.freebase.be/g2/img/"..fileinfo.sha1..".png[/img], T [img]http://www.freebase.be/g2/total/"..fileinfo.sha1..".png[/img]]")
		end
		
		
		function writeurls(file, urls, prefix, first)
			function wuinternal(url, prefix, index, first)
				return (" [url="..escapexml(url).."]"..((index==1 and first) or ("["..prefix..index.."]")).."[/url]")
			end
			
			prefix = prefix or ""
			if type(urls)=="string" then
				return wuinternal(urls, prefix, 1, first)
			elseif type(urls)=="table" then
				local r=""
				for index, url in pairs(urls) do
					r=r..wuinternal(url, prefix, index, first)
				end
				return r
			else
				return first
			end
		end
		
		bbf:write(" ("..fileinfo.size..") ")
		
		local nameshow=("[b]"..escapexml(fileinfo.name).."[/b]")
		
		if havetbl.bUrl then
			bbf:write(writeurls(wrf, fileinfo.url, "", nameshow))
			nameshow=nil
		end
		
		if havetbl.bPUrl then
			bbf:write(writeurls(wrf, fileinfo.purl, "p", nameshow))
			nameshow=nil
		end
		
		if nameshow then
			bbf:write(nameshow)
		end
	end
end

main()