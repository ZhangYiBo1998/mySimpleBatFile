@echo off
chcp 65001
setlocal enabledelayedexpansion

set /p "target_extension=请输入文件后缀名（默认为m4s）："
if "%target_extension%"=="" set "target_extension=m4s"

set "file_size_threshold=52428800"
set "output_folder=output"

echo ----- 遍历到的文件名 -----

rem 设置基础文件名为空，即视频和音频文件名相同的部分
set "basename="

rem 同一组的视频文件和音频文件的变量
set "video_name="
set "voice_name="

rem 创建输出文件夹
mkdir "%output_folder%" 2>nul

rem 获取当前文件夹路径
set "current_folder=%cd%"

rem 遍历当前文件夹中指定后缀名的文件并排除非指定后缀的文件
for %%F in ("%current_folder%\*.%target_extension%") do (
    rem 获取文件名和前半部分（不包括扩展名）
    set "filename=%%~nF"

    echo 文件名: !filename!

    rem 获取文件大小
    for %%A in ("%%F") do (
        set "size=%%~zA"
        echo 文件大小：%%~nxF, !size!
    )

    rem 判断文件大小，并进行标记
    if !size! GTR %file_size_threshold% (
        set "video_name=%%~nxF"
        echo 标记为视频文件: !video_name!
    ) else (
        set "voice_name=%%~nxF"
        echo 标记为音频文件: !voice_name!
    )

    if "!basename!"=="" (

        rem 如果basename为空，说明这是新的一组，设置basename为当前文件名的前半部分
        set "basename=!filename:~0,-6!"

    ) else if "!basename!"=="!filename:~0,-6!" (

        rem 如果basename有值，且和当前文件名前半部分相同，说明当前分组已完成

        echo ----------开始合并音视频文件----------
        echo 视频文件: !video_name!
        echo 音频文件: !voice_name!
        echo 输出文件: %output_folder%\!basename!.mp4

        rem 执行ffmpeg命令进行音视频合并
        ffmpeg -i "!video_name!" -i "!voice_name!" -c copy "%output_folder%\!basename!.mp4"

        echo ----------音视频文件合并完成----------

        set "basename="
    )

    echo basename: !basename!
    echo.
)

echo --------------------------

echo 所有音视频合并操作完成。

pause
endlocal
