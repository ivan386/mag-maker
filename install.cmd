%~d0
@cd "%~p0\install\"
@md  "%USERPROFILE%\SendTo\MagMaker"

@copy head.cmd.part/B+rhash.cmd.part/B+join.cmd.part/B+mag_BB.cmd.part/B+debugmode.cmd.part/B "%USERPROFILE%\SendTo\MagMaker\mag_BB.cmd"
@copy head.cmd.part/B+rhash.cmd.part/B+join.cmd.part/B+mag_HTML.cmd.part/B+debugmode.cmd.part/B "%USERPROFILE%\SendTo\MagMaker\mag_HTML.cmd"
@copy head.cmd.part/B+rhash.cmd.part/B+join.cmd.part/B+magnet.cmd.part/B+debugmode.cmd.part/B "%USERPROFILE%\SendTo\MagMaker\magnet.cmd"
@copy head.cmd.part/B+rhash.cmd.part/B+join.cmd.part/B+full_BB.cmd.part/B+debugmode.cmd.part/B "%USERPROFILE%\SendTo\MagMaker\full_BB.cmd"
@copy head.cmd.part/B+rhash.cmd.part/B+join.cmd.part/B+full_htm.cmd.part/B+debugmode.cmd.part/B "%USERPROFILE%\SendTo\MagMaker\full_htm.cmd"

@copy head.cmd.part/B+rhash.cmd.part/B+join.cmd.part/B+filelist.cmd.part/B+debugmode.cmd.part/B "%USERPROFILE%\SendTo\MagMaker\filelist.cmd"
@copy head.cmd.part/B+rhash.cmd.part/B+join.cmd.part/B+metalink.cmd.part/B+debugmode.cmd.part/B "%USERPROFILE%\SendTo\MagMaker\metalink.cmd"
@copy head.cmd.part/B+rhash.cmd.part/B+join.cmd.part/B+htext.cmd.part/B+debugmode.cmd.part/B "%USERPROFILE%\SendTo\MagMaker\htext.cmd"
@copy head.cmd.part/B+rhash.cmd.part/B+join.cmd.part/B+html.cmd.part/B+debugmode.cmd.part/B "%USERPROFILE%\SendTo\MagMaker\html.cmd"
@copy head.cmd.part/B+rhash.cmd.part/B+join.cmd.part/B+ed2k_link.cmd.part/B+debugmode.cmd.part/B "%USERPROFILE%\SendTo\MagMaker\ed2k_link.cmd"

@copy head.cmd.part/B+rhash.cmd.part/B+echofla.cmd.part/B+hashonly.cmd.part/B+debugmode.cmd.part/B "%USERPROFILE%\SendTo\MagMaker\hashonly.cmd"
@copy head.cmd.part/B+rhash.cmd.part/B+echofla.cmd.part/B+hash_push.cmd.part/B+debugmode.cmd.part/B "%USERPROFILE%\SendTo\MagMaker\hash_push.cmd"
@copy head.cmd.part/B+mlparser.cmd.part/B+debugmode.cmd.part/B "%USERPROFILE%\SendTo\MagMaker\mlparser.cmd"
@copy head.cmd.part/B+flparser.cmd.part/B+debugmode.cmd.part/B "%USERPROFILE%\SendTo\MagMaker\flparser.cmd"

@md "%USERPROFILE%\SendTo\Torrent Editor\"
@copy head.cmd.part/B+torpatch.cmd.part/B+debugmode.cmd.part/B "%USERPROFILE%\SendTo\Torrent Editor\torpatch.cmd"
@copy head.cmd.part/B+torredactor.cmd.part/B+debugmode.cmd.part/B "%USERPROFILE%\SendTo\Torrent Editor\torredactor.cmd"

@md "%USERPROFILE%\SendTo\Copy Link\"
@copy head.cmd.part/B+copylink.cmd.part/B+debugmode.cmd.part/B "%USERPROFILE%\SendTo\Copy Link\copylink.cmd"

@md "%USERPROFILE%\SendTo\Encoder\"
@copy head.cmd.part/B+datahtml.cmd.part/B+debugmode.cmd.part/B "%USERPROFILE%\SendTo\Encoder\datahtml.cmd"

@md "%USERPROFILE%\Start Menu\Programs\MagMaker\"
@copy head.cmd.part/B+join.cmd.part/B+mag_BB.cmd.part/B+debugmode.cmd.part/B "%USERPROFILE%\Start Menu\Programs\MagMaker\mag_BB.cmd"
@copy head.cmd.part/B+join.cmd.part/B+mag_HTML.cmd.part/B+debugmode.cmd.part/B "%USERPROFILE%\Start Menu\Programs\MagMaker\mag_HTML.cmd"
@copy head.cmd.part/B+join.cmd.part/B+magnet.cmd.part/B+debugmode.cmd.part/B "%USERPROFILE%\Start Menu\Programs\MagMaker\magnet.cmd"
@copy head.cmd.part/B+join.cmd.part/B+full_BB.cmd.part/B+debugmode.cmd.part/B "%USERPROFILE%\Start Menu\Programs\MagMaker\full_BB.cmd"
@copy head.cmd.part/B+join.cmd.part/B+ed2k_link.cmd.part/B+debugmode.cmd.part/B "%USERPROFILE%\Start Menu\Programs\MagMaker\ed2k_link.cmd"

@copy head.cmd.part/B+join.cmd.part/B+filelist.cmd.part/B+debugmode.cmd.part/B "%USERPROFILE%\Start Menu\Programs\MagMaker\filelist.cmd"
@copy head.cmd.part/B+join.cmd.part/B+metalink.cmd.part/B+debugmode.cmd.part/B "%USERPROFILE%\Start Menu\Programs\MagMaker\metalink.cmd"
@copy head.cmd.part/B+join.cmd.part/B+htext.cmd.part/B+debugmode.cmd.part/B "%USERPROFILE%\Start Menu\Programs\MagMaker\htext.cmd"
@copy head.cmd.part/B+join.cmd.part/B+html.cmd.part/B+debugmode.cmd.part/B "%USERPROFILE%\Start Menu\Programs\MagMaker\html.cmd"

@copy head.cmd.part/B+hash_pop.cmd.part/B+debugmode.cmd.part/B "%USERPROFILE%\Start Menu\Programs\MagMaker\hash_pop.cmd"
@copy head.cmd.part/B+hash_push.cmd.part/B+debugmode.cmd.part/B "%USERPROFILE%\Start Menu\Programs\MagMaker\hash_push.cmd"

@md "%USERPROFILE%\Start Menu\Programs\MagMaker\Settings\"

@copy head.cmd.part/B+rhash_max.cmd.part/B+debugmode.cmd.part/B "%USERPROFILE%\Start Menu\Programs\MagMaker\Settings\rhash_max.cmd"
@copy head.cmd.part/B+rhash_min.cmd.part/B+debugmode.cmd.part/B "%USERPROFILE%\Start Menu\Programs\MagMaker\Settings\rhash_min.cmd"
@copy head.cmd.part/B+rhash_shareaza.cmd.part/B+debugmode.cmd.part/B "%USERPROFILE%\Start Menu\Programs\MagMaker\Settings\rhash_shareaza.cmd"
@copy head.cmd.part/B+rhash_shared2k.cmd.part/B+debugmode.cmd.part/B "%USERPROFILE%\Start Menu\Programs\MagMaker\Settings\rhash_shared2k.cmd"
@copy head.cmd.part/B+hledit.cmd.part/B+debugmode.cmd.part/B "%USERPROFILE%\Start Menu\Programs\MagMaker\Settings\hledit.cmd"

@copy head.cmd.part/B+uninstall.cmd.part/B+debugmode.cmd.part/B "%USERPROFILE%\Start Menu\Programs\MagMaker\Settings\uninstall.cmd"

@md "%USERPROFILE%\Start Menu\Programs\Torrent Editor\"
@copy head.cmd.part/B+torredactor.cmd.part/B+debugmode.cmd.part/B "%USERPROFILE%\Start Menu\Programs\Torrent Editor\torredactor.cmd"

@md "%USERPROFILE%\SendTo\Marker\"
@copy head.cmd.part/B+rhash.cmd.part/B+join.cmd.part/B+marker_must_have.cmd.part/B+debugmode.cmd.part/B "%USERPROFILE%\SendTo\Marker\must_have.cmd"
@copy head.cmd.part/B+rhash.cmd.part/B+join.cmd.part/B+marker_bad.cmd.part/B+debugmode.cmd.part/B "%USERPROFILE%\SendTo\Marker\bad.cmd"
@copy head.cmd.part/B+rhash.cmd.part/B+join.cmd.part/B+marker_fake.cmd.part/B+debugmode.cmd.part/B "%USERPROFILE%\SendTo\Marker\fake.cmd"

@md "%USERPROFILE%\My Documents\MagMaker\Markers\bad"
@md "%USERPROFILE%\My Documents\MagMaker\Markers\fake"
@md "%USERPROFILE%\My Documents\MagMaker\Markers\must have"

@md "..\result"
@md "..\temp"

@echo --[[]]> ..\temp\fla.lua
@echo --[[]]> ..\temp\hashstack.txt

@xcopy /S "%USERPROFILE%\Start Menu\Programs\MagMaker" "%USERPROFILE%\Application Data\Microsoft\Internet Explorer\Quick Launch\MagMaker\"
@xcopy /S "%USERPROFILE%\Start Menu\Programs\Torrent Editor" "%USERPROFILE%\Application Data\Microsoft\Internet Explorer\Quick Launch\Torrent Editor\"

pause