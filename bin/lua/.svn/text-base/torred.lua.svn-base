function readtor(filename)
	local torfile=io.open(filename,"rb")
	local asdata=false
	local numbers={["0"]=0,["1"]=1,["2"]=2,["3"]=3,["4"]=4,["5"]=5,["6"]=6,["7"]=7,["8"]=8,["9"]=9}
	local function select(hfile)
			local key=hfile:read(1)
			local value=""
			--[[debug]]-- print(key)
			if key=="i" then
				local char=hfile:read(1)
				while char~="e" do
					value=value..char
					char=hfile:read(1)
				end
				if asdata then
					return "i"..value.."e"
				else
					return tonumber(value,10)
				end
			elseif key=="l" then
				value = select(hfile)
				local list=""
				if asdata==false then list={t=key,v={}} end
				while value do
					if asdata then
						list =list..value
					else
						table.insert(list.v,value)
					end
					value = select(hfile)
				end
				if asdata then
					return "l"..list.."e"
				else
					return list
				end
			elseif key=="d" then
				local dict=""
				if asdata==false then dict={t=key,v={},o={}} end
				local key = select(hfile)
				while key do
					-- if key=="info" and asdata==false then
						-- asdata=true
						-- value=select(hfile)
						-- if value==nil then break end
						-- value={t="s",v=value}
						-- asdata=false
					-- else
						value=select(hfile)
					-- end
					if value then
						if asdata then
							dict=dict..key..value
						else
							table.insert(dict.o,key)
							dict.v[key]=value
						end
					else
						break
					end
					key = select(hfile)
				end
				if asdata then
					return "d"..dict.."e"
				else
					return dict
				end
			elseif key=="e" then
				return nil
			elseif numbers[key] then
				local len=key
				local rchar=hfile:read(1)
				while rchar~=":" do
					len=len..rchar
					rchar=hfile:read(1)
				end
				len=tonumber(len,10)
				value = hfile:read(len)
				--[[debug]]-- print(len..rchar..value)
				if asdata then
					return len..":"..value
				else
					return value
				end
			end
			--[[debug]]-- print("error")
		end
	local r=select(torfile)
	torfile:close()
	return r
end



function writetor(filename,ttor)
	local torfile=io.open(filename,"wb")
	local function wselect(hfile,data)
		if type(data)=="number" then
			--[[debug]]-- print("number")
			hfile:write("i"..data.."e")
		elseif type(data)=="string" then
			--[[debug]]-- print("string")
			hfile:write(string.len(data)..":"..data)
		elseif type(data)=="table" then
			--[[debug]]-- print(data.t)
			if data.t=="s" then
				hfile:write(data.v)
			elseif data.t=="d" or data.t=="l" then
				local m = data.t
				hfile:write(m)
				if m=="l" then
					for i,v in pairs(data.v) do
						wselect(hfile,v)
					end
				elseif m=="d" then
					for i,k in pairs(data.o) do
						if data.v[k] then
							wselect(hfile,k)
							wselect(hfile,data.v[k])
						end
					end
				end
				hfile:write("e")
			end
		end
	end
	local r=wselect(torfile,ttor)
	torfile:close()
	return r
end


