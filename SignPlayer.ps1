@echo off
:: Configuration
set "video_folder=C:\path\to\synced\google\drive\folder"
set "local_video_folder=C:\path\to\local\video\directory"
set "player=C:\path\to\vlc\vlc.exe"
set "default_video=C:\path\to\default\video.mp4"
set "play_duration=600" :: Time in seconds (10 minutes)

:loop
    :: Check for the most recently updated video
    set "current_video="
    for /f "delims=" %%F in ('dir /b /a-d /o-d /t:w "%video_folder%\*.mp4"') do (
        set "current_video=%video_folder%\%%F"
        goto download_and_play
    )

    :: If no video found, play default video
    set "current_video=%default_video%"
    goto download_and_play

:download_and_play
    tasklist /fi "imagename eq vlc.exe" 2>NUL | find /i "vlc.exe" > NUL
    if not errorlevel 1 (
        echo VLC is already running. Skipping new video playback.
        goto wait_and_check
    )

  
    if exist "%local_video_folder%\*.mp4" (
        echo Deleting previous video...
        del /f /q "%local_video_folder%\*.mp4"
    )

    echo Copying new video to local folder...
    copy "%current_video%" "%local_video_folder%"

    echo Starting VLC to play the video...
    "%player%" "%current_video%" --fullscreen --loop --play-and-exit --quiet

    timeout /t 10 /nobreak > nul
    goto loop

timeout /t 43200 /nobreak > nul
echo Restarting script after 12 hours...
start "" "%~f0"  :: Restart the batch script
exit

