cd "%~dp0"

rmdir tmp /S /Q
mkdir tmp

for /d %%i in (src\*) do (
  echo %%~nxi
  xcopy "%%i" "tmp\%%~nxi" /D /E /C /R /I /K /Y
  cd "tmp\%%~nxi"
  call ..\..\proc.bat build.txt
  cd "%~dp0"
)

rmdir out /S /Q
mkdir out
mkdir out\XLDLIBS
mkdir out\XLDLIBS\ENGLISH
mkdir out\XLDLIBS\INITIAL
for /d %%i in (tmp\*) do (
  for %%a in (%%~si\*.xlp %%~si\*.xlz %%~si\*.xlp.gz %%~si\*.pat %%~si\*.pat.gz) do (
    albtool -m "%%a" "out\XLDLIBS\%%~nxa"
  )
  for %%a in (%%~si\ENGLISH\*.xlp %%~si\ENGLISH\*.xlz %%~si\ENGLISH\*.xlp.gz %%~si\ENGLISH\*.pat %%~si\ENGLISH\*.pat.gz) do (
    albtool -m "%%a" "out\XLDLIBS\ENGLISH\%%~nxa"
  )
  for %%a in (%%~si\INITIAL\*.xlp %%~si\INITIAL\*.xlz %%~si\INITIAL\*.xlp.gz %%~si\INITIAL\*.pat %%~si\INITIAL\*.pat.gz) do (
    albtool -m "%%a" "out\XLDLIBS\INITIAL\%%~nxa"
  )
)
rmdir tmp /S /Q

copy albtool.exe out\albtool.exe
copy patch.bat out\patch.bat

PAUSE