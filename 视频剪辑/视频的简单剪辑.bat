@echo off
chcp 65001 > nul

set /p input_video=请输入原视频名称（默认为input.mp4，注意需要加上后缀名）：
if "%input_video%"=="" set input_video=input.mp4

set /p output_video=请输入导出视频名称（默认为output.mp4，注意需要加上后缀名）：
if "%output_video%"=="" set output_video=output.mp4

set /p start_time=请输入视频剪辑开始时间（默认为00:00:00，注意:符号格式为英文）：
if "%start_time%"=="" set start_time=00:00:00

set /p end_time=请输入视频剪辑结束时间（默认为原视频的结束时间）：

if "%end_time%"=="" (
    set cmd=ffmpeg -ss %start_time% -i %input_video% -c copy %output_video%
) else (
    set cmd=ffmpeg -ss %start_time% -to %end_time% -i %input_video% -c copy %output_video%
)

echo 开始剪辑视频...
echo %cmd%
%cmd%

pause
