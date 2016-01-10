
-- local table1={nil,nil,nil,[{"no linked table as key 1"}]={"nn1"},"test1"}
-- local table2={table1,nil,nil,[{"no linked table as key 2",table1}]={"nn2"},"test2"}
-- local table3={table1,table2,nil,[{"no linked table as key 3",table1,table2,[{"no linked table as key 3.1"}]="3.1"}]={"nn3"},"test3"}
-- table1[1]=table1
-- table1[2]=table2
-- table1[3]=table2
-- table2[2]=table2
-- table2[3]=table3
-- table3[3]=table3
-- table1[table1]="table1.1"
-- table1[table2]="table1.2"
-- table1[table3]="table1.3"
-- table2[table1]=table1
-- table2[table2]=table2
-- table2[table3]=table3
-- table3[table1]=table1


function Serialize(tTable, sTableName,sNewLine ,sTab, fUserSerialize)
    assert(tTable, "tTable equals nil");
    assert(sTableName, "sTableName equals nil");
    assert(type(tTable) == "table", "tTable must be a table!");
    assert(type(sTableName) == "string", "sTableName must be a string!");
	if not sNewLine then sNewLine="\n" end
	if not sTab then sTab="\t" end
    local tTablesCollector={}
    local SerializeInternal = nil
	local kidx = 0
	
    SerializeInternal = function (tTable, sTableName, sTabs, sLongKey)
        sTabs = sTabs or "";
        local sRepear = "";
        sLongKey = sLongKey or sTableName;
        local sTmp = ""
		if tTablesCollector[tTable]~=nil then
			sRepear=sRepear..sNewLine..sTab..sLongKey.."="..tTablesCollector[tTable]..";"
			return nil, sRepear
		end
		tTablesCollector[tTable]=sLongKey
        if sTableName~="" then sTmp = sTmp..sTabs..sTableName.."={"..sNewLine end
		local bJump=false
        for key, value in pairs(tTable) do
			
			local userser = nil
			if type(fUserSerialize)=="function" then
				userser = fUserSerialize(key, value, tTable, sTableName, sTabs, sLongKey)
			end
			if userser then
				sTmp=sTmp..userser
			else
				local sKey
				local bToRepear = false
	            if (type(key) == "table") then
					if tTablesCollector[key] then
						sKey="["..tTablesCollector[key].."]"
					else
						kidx=kidx+1
						sKey="tKey["..kidx.."]"
						local sTmp2,sRepear2=SerializeInternal(key, sKey, sTab)
						sRepear = sRepear..sNewLine..sTmp2..";"..sRepear2
						sKey="["..sKey.."]"
					end
					bToRepear = true
					bJump=true
				elseif (type(key) == "string") then
					sKey = string.format("[%q]",key)
				else
					sKey = string.format("[%d]",key);
				end
	            if(type(value) == "table") then
	                local sTmp2,sRepear2=SerializeInternal(value, sKey,(bToRepear and sTab) or sTabs..sTab, sLongKey..sKey)
	                if bToRepear then
						if sTmp2~=nil then
							sRepear = sRepear..sNewLine..sTab..sLongKey..sTmp2..";"
		                end
						bJump=true
					else
						if sTmp2==nil then
		                    bJump=true
		                else
		                    sTmp = sTmp..sTmp2;
		                end
					end
					sRepear = sRepear..sRepear2;
			   else
	                local sValue = (type(value) == "string") and string.format("%q",value) or tostring(value);
	                if bToRepear then
						sRepear = sRepear..sNewLine..sTab..sLongKey..sKey.."="..sValue..";"
						bJump=true
					else
						sTmp = sTmp..sTabs..sTab..sKey.."="..sValue
					end
	            end
				if bJump then bJump=false; else sTmp = sTmp..","..sNewLine; end
			end
        end
        if sTableName~="" then sTmp = sTmp..sTabs.."}" end
        return sTmp, sRepear
    end

    local sResult, sRepear = SerializeInternal(tTable,sTableName,sTab)
    if sRepear~=nil and sRepear~="" then
		sResult=sTableName.."=function()"..sNewLine.."local tKey={};"..sNewLine.."local "..sResult..";"..sNewLine..sRepear..sNewLine.."return tTable;"..sNewLine.."end;"..sNewLine..sTableName.."="..sTableName.."();"
	end
	collectgarbage()
	return sResult
end

-- local seri=Serialize(_G,"testtable").."\n return testtable"
-- print(seri)
-- local file = io.open("D:\\xxx.txt","w")
-- file:write(seri)
-- for i=0,1000 do
	-- seri=Serialize(assert(loadstring(seri))(),"testtable").."\n return testtable"
-- end
-- print(seri)
