@echo off
chcp 65001
setlocal enabledelayedexpansion

rem 默认音视频的后缀名为m4s
set "target_extension=m4s"

set "video_name="
set "voice_name="

echo ----- 遍历到的文件名 -----

rem 遍历当前文件夹中指定后缀名的文件
for /r %%F in (*.%target_extension%) do (
    rem 获取文件大小
    for %%A in ("%%F") do (
        set "size=%%~zA"
        echo %%~nxF, !size!
    )

    rem 判断文件大小，并进行标记
    if !size! GTR 104857600 (
        set "video_name=%%~nxF"
    ) else (
        set "voice_name=%%~nxF"
    )
)

echo --------------------------

rem 执行ffmpeg命令进行音视频合并
echo 开始合并音视频……

ffmpeg -i "%video_name%" -i "%voice_name%" -c copy "output.mp4"

echo.
echo 音视频合并完成

pause
endlocal
