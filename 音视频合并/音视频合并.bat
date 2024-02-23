@chcp 65001

@echo off
set /p video_name="请输入视频文件名（需要加文件后缀）："
set /p voice_name="请输入音频文件名（需要加文件后缀）："
set /p output_name="请输入输出文件名（需要加文件后缀），不填默认为output.mp4："

if "%output_name%"=="" (set output_name=output.mp4)

echo 开始合并音视频……

ffmpeg -i "%video_name%" -i "%voice_name%" -c copy "%output_name%"

echo.
echo 音视频合并完成

pause