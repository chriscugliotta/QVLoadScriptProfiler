:: Memory monitoring script
:: Chris Cugliotta
:: March 21, 2014

:: This script will monitor the memory usage of an application over time, and
:: store the data into a text file.  It assumes that the current Windows user
:: is running exactly one instance of the application.  The loop can be safely
:: terminated by simply x-ing out the command window.

:: ===============
:: [1]  Parameters
:: ===============

:: Application name
:: The application to be monitored
set app=Qv11.exe

:: Output file
:: The results will be saved to this file
set output=memory.csv

:: Wait time
:: The amount of time between snapshots (in seconds)
set wait=1

:: Stop time
:: The time to stop monitoring (in hours, i.e. 13 = 1:00 PM)
set stop=25



:: =========
:: [2]  Loop
:: =========

:: Header
tasklist /fi "imagename eq %app%" /fi "username eq %username%" /fo csv > temp.txt
set /p x=<temp.txt
echo "Date","Time",%x% > %output%

:: Begin loop
:loop

:: Update
tasklist /fi "imagename eq %app%" /fi "username eq %username%" /fo csv /nh > temp.txt
set /p x=<temp.txt
echo "%date:~4,10%","%time:~0,8%",%x% >> %output%

:: Wait
timeout /T %wait%

:: Check stopping criteria
if %time:~0,2% LEQ %stop% goto loop