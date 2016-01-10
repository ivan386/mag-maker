C:
cd \MagMaker\bin
@echo return {[=[%1]=],[=[%2]=],[=[%3]=],[=[%4]=],[=[%5]=],[=[%6]=],[=[%7]=],[=[%8]=],[=[%9]=]}> ..\temp\fla.lua
@lua5.1 -e "args=loadfile([[..\temp\fla.lua]])()" xmlparser.lua
