@Echo OFF
CLS

set FW=20.12.1-0002
set ROM=FW2657A.rom
set SUBDEV=1f4e
set DOS32A=/NOC /NOWARN:9004

echo ΙΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ»
echo Ί Dell PERC H310 Adapter Package Version %FW%               Ί
echo Ί                                                                   Ί
echo Ί This package will update the firmware of your Dell PERC H310      Ί
echo Ί Adapter to version %FW%.                                  Ί
echo Ί                                                                   Ί
echo Ί After the firmware update, your system must be rebooted before    Ί
echo Ί attempting any access to drives attached to the controller.       Ί
echo Ί                                                                   Ί
echo Ί If you are attempting to downgrade the current firmware, please   Ί
echo Ί exit this flash process and type NOCHECK.                         Ί
echo ΘΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΌ

@echo.
echo ΙΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ»
echo Ί Press ctrl-C to stop the firmware flash process or any other key  Ί
echo Ί to continue.                                                      Ί
echo ΘΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΌ
@pause >nul
cls

echo ΙΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ»
echo Ί Please wait while supported controller(s) are identified.         Ί
echo ΘΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΌ
@megafl.exe -ADPCOUNT >ADPCOUNT.LOG
@XGREP "Controller Count: 0" adpcount.log >NUL
@If errorlevel 1 GOTO ADAPTER0
@GOTO NOADP

:ADAPTER0
@megafl.exe -ADPALLINFO -A0 -NOLOG >ADP0.log
@If errorlevel 1 GOTO ADAPTER1
@XGREP %SUBDEV% ADP0.LOG >NUL
@If errorlevel 1 GOTO ADAPTER1
@XGREP %FW% ADP0.LOG >NUL
@If errorlevel 1 GOTO FLASH0
@GOTO SAME0

:FLASH0
@Echo.attempt0 >>ADPCOUNT.LOG
@Echo.
echo ΙΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ»
echo Ί Controller found! - Please wait while update is performed.        Ί
echo Ί Do not power off or reboot system until all flash updates         Ί
echo Ί have completed.                                                   Ί
echo ΘΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΌ
@megafl.exe -ADPFWFLASH -F %ROM% -A0 >NUL
@if errorlevel 1 GOTO FAIL0
@Echo.
echo ΙΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ»
echo Ί Flash update completed successfully!                              Ί
echo Ί                                                                   Ί
echo Ί Please wait while searching for additional controllers.           Ί
echo ΘΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΌ
@GOTO ADAPTER1

:SAME0
@Echo.
echo ΙΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ»
echo Ί Controller found, but the firmware version is already up to date. Ί
echo Ί Flash will NOT be performed.                                      Ί
echo Ί                                                                   Ί
echo Ί Please wait while searching for additional controllers.           Ί
echo ΘΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΌ
@Echo.
@echo.same0 >>ADPCOUNT.LOG
@GOTO ADAPTER1

:FAIL0
@Echo.
echo ΙΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ»
echo Ί An error was encountered during this controller's flash update.   Ί
echo Ί                                                                   Ί
echo Ί Please wait while searching for additional controllers.           Ί
echo ΘΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΌ
@Echo.error0 >>ADPCOUNT.LOG
@Echo.
@GOTO ADAPTER1

:ADAPTER1
@megafl.exe -ADPALLINFO -A1 -NOLOG >ADP1.log
@If errorlevel 1 GOTO ADAPTER2
@XGREP %SUBDEV% ADP1.LOG >NUL
@If errorlevel 1 GOTO ADAPTER2
@XGREP %FW% ADP1.LOG >NUL
@If errorlevel 1 GOTO FLASH1
@GOTO SAME1

:FLASH1
@Echo.attempt1 >>ADPCOUNT.LOG
@Echo.
echo ΙΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ»
echo Ί Controller found! - Please wait while update is performed.        Ί
echo Ί Do not power off or reboot system until all flash updates         Ί
echo Ί have completed.                                                   Ί
echo ΘΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΌ
@megafl.exe -ADPFWFLASH -F %ROM% -A1 >NUL
@if errorlevel 1 GOTO FAIL1
@Echo.
echo ΙΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ»
echo Ί Flash update completed successfully!                              Ί
echo Ί                                                                   Ί
echo Ί Please wait while searching for additional controllers.           Ί
echo ΘΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΌ
@GOTO ADAPTER2

:SAME1
@Echo.
echo ΙΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ»
echo Ί Controller found, but the firmware version is already up to date. Ί
echo Ί Flash will NOT be performed.                                      Ί
echo Ί                                                                   Ί
echo Ί Please wait while searching for additional controllers.           Ί
echo ΘΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΌ
@Echo.
@echo.same1 >>ADPCOUNT.LOG
@GOTO ADAPTER2

:FAIL1
@Echo.
echo ΙΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ»
echo Ί An error was encountered during this controller's flash update.   Ί
echo Ί                                                                   Ί
echo Ί Please wait while searching for additional controllers.           Ί
echo ΘΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΌ
@Echo.error1 >>ADPCOUNT.LOG
@Echo.
@GOTO ADAPTER2

:ADAPTER2
@megafl.exe -ADPALLINFO -A2 -NOLOG >ADP2.log
@If errorlevel 1 GOTO CHECK
@XGREP %SUBDEV% ADP2.LOG >NUL
@If errorlevel 1 GOTO CHECK
@XGREP %FW% ADP2.LOG >NUL
@If errorlevel 1 GOTO FLASH2
@GOTO SAME2

:FLASH2
@Echo.attempt2 >>ADPCOUNT.LOG
@Echo.
echo ΙΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ»
echo Ί Controller found! - Please wait while update is performed.        Ί
echo Ί Do not power off or reboot system until all flash updates         Ί
echo Ί have completed.                                                   Ί
echo ΘΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΌ
@megafl.exe -ADPFWFLASH -F %ROM% -A2 >NUL
@if errorlevel 1 GOTO FAIL2
@Echo.
echo ΙΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ»
echo Ί Flash update completed successfully!                              Ί
echo Ί                                                                   Ί
echo Ί Please wait while searching for additional controllers.           Ί
echo ΘΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΌ
@GOTO CHECK

:SAME2
@Echo.
echo ΙΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ»
echo Ί Controller found, but the firmware version is already up to date. Ί
echo Ί Flash will NOT be performed.                                      Ί
echo Ί                                                                   Ί
echo Ί Please wait while searching for additional controllers.           Ί
echo ΘΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΌ
@Echo.
@echo.same2 >>ADPCOUNT.LOG
@GOTO CHECK

:FAIL2
@Echo.
echo ΙΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ»
echo Ί An error was encountered during this controller's flash update.   Ί
echo Ί                                                                   Ί
echo Ί Please wait while searching for additional controllers.           Ί
echo ΘΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΌ
@Echo.error2 >>ADPCOUNT.LOG
@Echo.
@GOTO CHECK

:CHECK
@XGREP "error" ADPCOUNT.LOG >NUL
@If errorlevel 1 GOTO CHECK2
@Echo.
echo ΙΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ»
echo Ί One or more controllers encountered a flash failure.              Ί
echo Ί                                                                   Ί
echo Ί Please reboot for any changes to take effect.                     Ί
echo ΘΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΌ
@Echo.
@GOTO END

:CHECK2
@XGREP "same" ADPCOUNT.LOG >NUL
@if errorlevel 1 GOTO PASS
@Echo.
echo ΙΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ»
echo Ί All flash attempts have completed!                                Ί
echo Ί One or more controllers were already up to date.                  Ί
echo Ί                                                                   Ί
echo Ί Please reboot for any changes to take effect.                     Ί
echo ΘΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΌ
@Echo.
@GOTO END

:PASS
@XGREP "attempt" ADPCOUNT.LOG >NUL
@if errorlevel 1 GOTO NOADP
@Echo.
echo ΙΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ»
echo Ί All flash updates completed successfully!                         Ί
echo Ί                                                                   Ί
echo Ί Please reboot for changes to take effect.                         Ί
echo ΘΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΌ
@Echo.
@GOTO END


:NOADP
@Echo.
echo ΙΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝ»
echo Ί No supported controllers present or detected.                     Ί
echo ΘΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΝΌ
@Echo.
@GOTO END

:END
@del *.log