$video = "D:\Torrents\Initial D\Initial D - [01] First Stage\Initial D 1x01 - El superderrape del repartidor [Elektronik].mkv"
ffmpeg -i $video -map 0:s:0 Track0.ass -y
ffmpeg -i $video -map 0:s:1 Track1.ass -y
# ffmpeg -i $video -map 0:s:2 Track2.ass
