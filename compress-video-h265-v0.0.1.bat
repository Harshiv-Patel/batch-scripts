::@echo off

:: use `FFMPEG` windows build, either present in path, or in current working directory will do

:: conversion parameters
set extension="mp4"

:: desired output video resolution width:height
set res="960:540"

:: desired output video FPS
set fps="30"

:: video codec, h264 is widely compatible, but h265 should work on most modern hardware
::set codec="libx264"
set codec="libx265"

::constant rate factor, 0 gives best quality for huge file size
:: a sane number would be b/w 18-28, 22 or 23 should work well
set crf="23"

:: output file will have same name with suffix added in a folder level up named 'done'
set suffix="conv-x265"

md ..\done
:: loop through every mp4 video file in current working directory
:: `dir /b` gives all files, we are only interested in video files
:: probably does not work with file names containing spaces.
for /f %%f in ('dir /b .\*.%extension%') do ^
ffmpeg ^
-i "%%f" ^
-vcodec %codec% ^
-crf %crf% ^
-vf "scale=%res%,fps=fps=%fps%" ^
-y "..\done\\"%%f".%suffix%.%extension%"