require("encoding")
require("sharead")

function tagstometalink(tags)
	local rtab={}
	local ctab=rtab
	local lastkey=""
	for k,v in pairs(tags) do
		string.gsub(v.key,"([^:]+):?", function(key)
			if lastkey:len()>0 then
				ctab[lastkey]={}
				ctab=ctab[lastkey]
			end
			lastkey=key
		end)
		if type(ctab[lastkey])=="table" then
			table.insert(ctab[lastkey],wintoutf8ru(escapexml(v.text)))
		elseif ctab[lastkey] then
			ctab[lastkey]={ctab[lastkey], wintoutf8ru(escapexml(v.text))}
		else
			ctab[lastkey]=wintoutf8ru(escapexml(v.text))
		end
		ctab=rtab
		lastkey=""
	end
	local ml=function(key, value, ml, parentkey)
		local ret=""
		if type(key)=="number" then
			if key>1 then
				ret="</"..parentkey..">\n<"..parentkey..">"
			end
		elseif type(key)=="string" and key:len()>0 then
			ret="<"..key..">"
		end
		
		if type(value)=="table" then
			for k, v in pairs(value) do
				ret=ret..ml(k,v, ml, key)
			end
		else
			ret=ret..value
		end

		if type(key)=="string" and key:len()>0 then
			return ret.."</"..key..">".."\n"
		else
			return ret
		end
	end
	return ml("",rtab, ml)
end 

function metalinkfile(hashtbl, havetbl)
	local sListItem="<file name=\""..wintoutf8ru(escapexml(hashtbl.path)).."\">\n<size>"..hashtbl.size.."</size>\n<verification>\n"
	if havetbl.bTTH  then sListItem=sListItem..[[<hash type="tth">]]..hashtbl.tth.."</hash>\n" end
	if havetbl.bSha1  then sListItem=sListItem..[[<hash type="sha1">]]..hashtbl.sha1.."</hash>\n" end
	if havetbl.bEd2k  then sListItem=sListItem..[[<hash type="ed2k">]]..hashtbl.ed2k.."</hash>\n" end
	if havetbl.bMd5 then sListItem=sListItem..[[<hash type="md5">]]..hashtbl.md5.."</hash>\n" end
	if havetbl.bKZhash then sListItem=sListItem..[[<hash type="kzh">]]..hashtbl.kzhash.."</hash>\n" end
	if havetbl.bBtih then sListItem=sListItem..[[<hash type="btih">]]..hashtbl.btih.."</hash>\n" end
	if havetbl.bAich then sListItem=sListItem..[[<hash type="aich">]]..hashtbl.aich.."</hash>\n" end
	if havetbl.bTiger then sListItem=sListItem..[[<hash type="tiger">]]..hashtbl.tiger.."</hash>\n" end
	if havetbl.bCrc32 then sListItem=sListItem..[[<hash type="crc32">]]..hashtbl.crc32.."</hash>\n" end
	sListItem=sListItem.."</verification>\n"
	print(havetbl.bUrl, havetbl.bP2Purl)
	if havetbl.bUrl or havetbl.bP2Purl then
		sListItem=sListItem.."<resources>\n"
		if havetbl.bUrl then sListItem=sListItem..urlstoxml(hashtbl.url,"<url>","</url>\n") end
		if havetbl.bP2Purl then sListItem=sListItem..urlstoxml(hashtbl.p2purl,"<url>","</url>\n") end
		sListItem=sListItem.."</resources>\n"
	end
	if havetbl.bTags then sListItem=sListItem..tagstometalink(hashtbl.tags) end
	return sListItem.."</file>\n"
end

function main()
	print("MetaLink by Ivan386")
	
	files = loadfiles()
	if not files then return nil end
	
	mlf=io.open("..\\result\\files.metalink","w")
	
	mlf:write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n")
	mlf:write([[<metalink version="3.0" xmlns="http://www.metalinker.org/" 
generator="Magnet Maker - http://forum.proc.ru/index.php?showtopic=41607">
<files>
]])

	for fileidx, fileinfo in pairs(files) do
		if type(forallmod)=="function" then forallmod(fileidx, fileinfo) end
		local havetbl = checkhave(fileinfo)
		fileinfo.path=correctpath(fileinfo.path, arg)
		mlf:write(metalinkfile(fileinfo, havetbl))
	end

	mlf:write([[</files>
</metalink>]])
	
end

main()