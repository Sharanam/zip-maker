@echo off
set /a counter=1
@REM create 200 pdfs with 100 bytes each
for /L %%i in (1,1,200) do (
    fsutil file createnew .\test-%%i.pdf 100
    set /a counter+=1
)