settings={
	myaddress="daily.sytes.net:6352", --([address] �������� �� ���� ������� ����� (no-ip.com)). ���� � ��� ������������ ��� ��������� IP �� �� ����� ������ ��� �����������. ��� ������������ ������� IP ����� ������������ ������ no-ip.com.
	addlink={
		freebase = true --������� ������ �� Freebase
	},
	counters={
		freebase = true --������� ��������� Freebase � BBCode
	},
	bbcode={
		tags={
			magnet="url", --������������ ��� ��� ��������� ������ ������ � BBCode
			--magnet="magnet",
			ed2k="url" --��� ��� ���������� ed2k ������ � BBCode
		},
		imgs={
			magnet="http://www.freebase.be/img/magnet.png",
			ed2k="http://www.freebase.be/img/ed2k.gif"
		}
	}
}

function addurl(hash, key, url)
	if hash[key] then
		if type(hash[key])=="table" then
			table.insert(hash[key],url)
		elseif type(hash[key])=="string" then
			hash[key]={hash[key],url}
		end
	else
		hash[key]=url
	end
end

function forallmod(index, fileinfo)


	if type(fileinfo.sha1)=="string" and fileinfo.sha1~="" then 
		--addurl(fileinfo,"p2purl", "http://"..settings.myaddress.."/uri-res/N2R?urn:sha1:"..fileinfo.sha1) --�������� ��� �������� Gnutella2*
		-- if settings.addlink.freebase then addurl(fileinfo,"p2purl", "http://cache.freebase.be/"..fileinfo.sha1) end -- http://cache.freebase.be/[sha1] ��� �������������� ���������� ��� p2p ���� G2.
	end
	if type(fileinfo.ed2k)=="string" and fileinfo.ed2k~="" then
		--addurl(fileinfo,"p2purl", "ed2kftp://"..settings.myaddress.."/"..fileinfo.ed2k.."/"..fileinfo.size.."/") --�������� ��� �������� Ed2k*
	end
	-- addurl(fileinfo,"p2purl", "dchub://smarthub.spb.ru") --DirectConnect ��� �� ������� ����� ����� ��������� �����
	--addurl(fileinfo,"url", "http://"..settings.myaddress.."/"..fileinfo.name)
	
	--* ����� �������������� ������ ������� ���� ������� ���� IP � ����.
	
end

return {-- ����� �������� ��� ��������. ������ ������ �� ��������!!!
