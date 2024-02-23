@echo off
chcp 65001

set /p video_name="请输入视频文件名（无需后缀）："
set /p voice_name="请输入音频文件名（无需后缀）："
set /p output_name="请输入输出文件名（无需后缀），不填默认为output："
set /p video_type_name="请输入视频文件名后缀（不填默认后缀m4s）："
set /p voice_type_name="请输入音频文件名后缀（不填默认后缀m4s）："
set /p output_type_name="请输入输出文件名后缀（不填默认后缀mp4）："

if "%output_name%"=="" (set output_name=output)
if "%video_type_name%"=="" (set video_type_name=.m4s)
if "%voice_type_name%"=="" (set voice_type_name=.m4s)
if "%output_type_name%"=="" (set output_type_name=.mp4)

echo 开始合并音视频……

ffmpeg -i "%video_name%%video_type_name%" -i "%voice_name%%voice_type_name%" -c copy "%output_name%%output_type_name%"

echo.
echo 音视频合并完成

pause