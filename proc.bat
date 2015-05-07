@rem Executes each line from a file as an albtool command
cd "%~dp1"
for /F "tokens=*" %%a in (%~sdpnx1) do (
  echo %%a
  "%~dp0albtool.exe" -d "%~dp0data" %%a
)