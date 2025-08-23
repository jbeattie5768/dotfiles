::::::::::::::::::::::::::::::::::::::::::::
:: Drop into startup folder %APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup
:: Also get to from run -> shell:startup
::::::::::::::::::::::::::::::::::::::::::::

IF EXIST c:\w_local_drive (
subst W: c:\w_local_drive
)

