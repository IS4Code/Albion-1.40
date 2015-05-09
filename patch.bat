@echo off
for /r XLDLIBS %%i in (*.xlp, *.xlz, *.xlp.gz) do (
  echo %%~nxi
  albtool.exe -i -f xlp "%%i" "%%~dpni.XLD"
  del "%%i"
)
for /r XLDLIBS %%i in (*.pat, *.pat.gz) do (
  echo %%~nxi
  albtool.exe -c -f xlp "%%i" "%%~dpni.DAT"
  del "%%i"
)