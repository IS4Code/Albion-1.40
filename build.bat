@echo off
cd "%~dp0"

rmdir tmp /S /Q
mkdir tmp

for /d %%i in (src\*) do (
  echo %%~nxi
  set VERSION=%%~nxi
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
for /F "usebackq tokens=1,2 delims==" %%i in (`wmic os get LocalDateTime /VALUE 2^>NUL`) do if '.%%i.'=='.LocalDateTime.' set ldt=%%j
set ldt=%ldt:~0,4%-%ldt:~4,2%-%ldt:~6,2% %ldt:~8,2%:%ldt:~10,2%:%ldt:~12,6%
echo.>>out\patch.bat
echo albtool.exe -v "%VERSION%" "%ldt%">>out\patch.bat
echo del albtool.exe>>out\patch.bat
echo del patch.bat>>out\patch.bat

PAUSE