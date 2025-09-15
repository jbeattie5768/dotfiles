::::::::::::::::::::::::::::::::::::::::::::
:: Copy into startup folder:
::
::     CMD:    %APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup
::      PS: $env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup
::
:: Can also get to from run -> shell:startup
::
::::::::::::::::::::::::::::::::::::::::::::

IF EXIST c:\w_local_drive (
subst W: c:\w_local_drive
)
