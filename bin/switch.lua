if rhash=="min" then
	rhash=[=[\nsha1=b32enc(hexdec(\"%%H\")), \ned2k=\"%%E\", \ntth=\"%%T\"]=]
elseif rhash=="max" then
	rhash=[=[\ncrc32=\"%%C\", \nsha1=b32enc(hexdec(\"%%H\")), \ned2k=\"%%E\", \naich=\"%%A\", \ntiger=\"%%G\", \ntth=\"%%T\", \nmd5=\"%%M\"]=]
elseif rhash=="shareaza" then
	rhash=[=[\nsha1=b32enc(hexdec(\"%%H\")), \ned2k=\"%%E\", \ntth=\"%%T\", \nmd5=\"%%M\"]=]
elseif rhash=="shared2k" then
	rhash=[=[\nsha1=b32enc(hexdec(\"%%H\")), \ned2k=\"%%E\", \ntth=\"%%T\", \nmd5=\"%%M\", \naich=\"%%A\"]=]
else
	rhash=false
end

if rhash then
	wrf=io.open("rhash.cmd","w")
	wrf:write("@echo \"Calc hash...\"\n")
	wrf:write("@rhash.exe -r -o\"..\\temp\\hashpart.txt\" --percents --ansi --printf \"\\n{\\npath=[=[%%p]=], \\nname=[=[%%f]=], \\nsize=%%s, ")
	wrf:write(rhash)
	wrf:write(" \\n},\" %1 %2 %3 %4 %5 %6 %7 %8 %9")
	wrf:close()
end
