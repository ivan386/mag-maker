@C:
@cd "\MagMaker\install\"
@md  "%USERPROFILE%\SendTo\MagMaker"

@copy head.cmd.part/B+ed2k_link.cmd.part/B "%USERPROFILE%\SendTo\MagMaker\ed2k_link.cmd"

@copy head.cmd.part/B+rhash.cmd.part/B+join.cmd.part/B+mag_BB.cmd.part/B "%USERPROFILE%\SendTo\MagMaker\mag_BB.cmd"
@copy head.cmd.part/B+rhash.cmd.part/B+join.cmd.part/B+mag_HTML.cmd.part/B "%USERPROFILE%\SendTo\MagMaker\mag_HTML.cmd"
@copy head.cmd.part/B+rhash.cmd.part/B+join.cmd.part/B+magnet.cmd.part/B "%USERPROFILE%\SendTo\MagMaker\magnet.cmd"

@copy head.cmd.part/B+rhash.cmd.part/B+join.cmd.part/B+filelist.cmd.part/B "%USERPROFILE%\SendTo\MagMaker\filelist.cmd"
@copy head.cmd.part/B+rhash.cmd.part/B+join.cmd.part/B+htext.cmd.part/B "%USERPROFILE%\SendTo\MagMaker\htext.cmd"
@copy head.cmd.part/B+rhash.cmd.part/B+join.cmd.part/B+html.cmd.part/B "%USERPROFILE%\SendTo\MagMaker\html.cmd"

@copy head.cmd.part/B+rhash.cmd.part/B+hashonly.cmd.part/B "%USERPROFILE%\SendTo\MagMaker\hashonly.cmd"
@copy head.cmd.part/B+rhash.cmd.part/B+hash_push.cmd.part/B "%USERPROFILE%\SendTo\MagMaker\hash_push.cmd"

@copy head.cmd.part/B+torpatch.cmd.part/B "%USERPROFILE%\SendTo\MagMaker\torpatch.cmd"

@md "%USERPROFILE%\Start Menu\Programs\MagMaker\"
@copy head.cmd.part/B+rhash_max.cmd.part/B "%USERPROFILE%\Start Menu\Programs\MagMaker\rhash_max.cmd"
@copy head.cmd.part/B+rhash_min.cmd.part/B "%USERPROFILE%\Start Menu\Programs\MagMaker\rhash_min.cmd"
@copy head.cmd.part/B+rhash_shareaza.cmd.part/B "%USERPROFILE%\Start Menu\Programs\MagMaker\rhash_shareaza.cmd"

@copy head.cmd.part/B+join.cmd.part/B+mag_BB.cmd.part/B "%USERPROFILE%\Start Menu\Programs\MagMaker\mag_BB.cmd"
@copy head.cmd.part/B+join.cmd.part/B+mag_HTML.cmd.part/B "%USERPROFILE%\Start Menu\Programs\MagMaker\mag_HTML.cmd"
@copy head.cmd.part/B+join.cmd.part/B+magnet.cmd.part/B "%USERPROFILE%\Start Menu\Programs\MagMaker\magnet.cmd"

@copy head.cmd.part/B+join.cmd.part/B+filelist.cmd.part/B "%USERPROFILE%\Start Menu\Programs\MagMaker\filelist.cmd"
@copy head.cmd.part/B+join.cmd.part/B+htext.cmd.part/B "%USERPROFILE%\Start Menu\Programs\MagMaker\htext.cmd"
@copy head.cmd.part/B+join.cmd.part/B+html.cmd.part/B "%USERPROFILE%\Start Menu\Programs\MagMaker\html.cmd"

@copy head.cmd.part/B+hash_pop.cmd.part/B "%USERPROFILE%\Start Menu\Programs\MagMaker\hash_pop.cmd"
@copy head.cmd.part/B+hash_push.cmd.part/B "%USERPROFILE%\Start Menu\Programs\MagMaker\hash_push.cmd"

@copy head.cmd.part/B+torredactor.cmd.part/B "%USERPROFILE%\Start Menu\Programs\MagMaker\torredactor.cmd"

@rem @md "%USERPROFILE%\My Documents\MagMaker\Markers\BadQ"
@rem @md "%USERPROFILE%\My Documents\MagMaker\Markers\Fake"
@rem @md "%USERPROFILE%\My Documents\MagMaker\Markers\Must Have"

@md "..\result"
@md "..\temp"

@echo "--[[Start]]--" > ..\temp\hashstack.txt