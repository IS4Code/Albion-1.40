@echo off
for /r XLDLIBS %%i in (*.xlp, *.xlz, *.xlp.gz) do (
  echo %%~nxi
  albtool -i -f xlp %%i %%~dpni.XLD
)
for /r XLDLIBS %%i in (*.pat, *.pat.gz) do (
  echo %%~nxi
  albtool -c -f xlp %%i %%~dpni.DAT
)