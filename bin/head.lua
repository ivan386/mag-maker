settings={
	myaddress="daily.sytes.net:6352", --([address] поменять на свой внешний адрес (no-ip.com)). Если у вас динамический или приватный IP то не имеет смысла его публиковать. При динамичемком внешнем IP можно использовать сервис no-ip.com.
	addlink={
		freebase = true --Вставка ссылки на Freebase
	},
	counters={
		freebase = true --Вставка счетчиков Freebase в BBCode
	},
	bbcode={
		tags={
			magnet="url", --Используемый тег для пуликации магнет ссылок в BBCode
			--magnet="magnet",
			ed2k="url" --Тег для публикации ed2k ссылок в BBCode
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
		--addurl(fileinfo,"p2purl", "http://"..settings.myaddress.."/uri-res/N2R?urn:sha1:"..fileinfo.sha1) --источник для клиентов Gnutella2*
		-- if settings.addlink.freebase then addurl(fileinfo,"p2purl", "http://cache.freebase.be/"..fileinfo.sha1) end -- http://cache.freebase.be/[sha1] Кеш альтернативных источников для p2p сети G2.
	end
	if type(fileinfo.ed2k)=="string" and fileinfo.ed2k~="" then
		--addurl(fileinfo,"p2purl", "ed2kftp://"..settings.myaddress.."/"..fileinfo.ed2k.."/"..fileinfo.size.."/") --источник для клиентов Ed2k*
	end
	-- addurl(fileinfo,"p2purl", "dchub://smarthub.spb.ru") --DirectConnect Хаб на котором можно найти источники файла
	--addurl(fileinfo,"url", "http://"..settings.myaddress.."/"..fileinfo.name)
	
	--* Перед использованием данных функций надо указать свой IP и порт.
	
end

return {-- Здесь начнется хеш таблитца. ДАЛЬШЕ НИЧЕГО НЕ ИЗМЕНЯТЬ!!!
