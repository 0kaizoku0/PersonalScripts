$video1 = "D:\Torrents\One Piece - 001 (DVDRip 768x576 x264 10bit AC3).mkv" # Pega la ruta con comillas
$video2 = "D:\Torrents\One Piece\01 Saga de East Blue (001-061)\One Piece Opening 01 [Shichibukai] [53FB0BDE].mkv" # Pega la ruta con comillas
$outputFolder = "screenshots"

New-Item -ItemType Directory -Force -Path $outputFolder

# Extrae 1 captura por cada minuto 1/60 o cada 10 segundos 1/10
# ffmpeg -i $video1 -vf fps=1/10 "$outputFolder\thumb_%04d_video1.png"
# ffmpeg -i $video2 -vf fps=1/10 "$outputFolder\thumb_%04d_video2.png"

# ffmpeg -ss 00:10:00 -i $video1 -frames:v 1 -accurate_seek "$outputFolder\capture1.png"
# ffmpeg -ss 00:10:00 -i $video2 -frames:v 1 -accurate_seek "$outputFolder\capture2.png"

# Definir los timestamps
$timestamps = @(
    "00:00:30",
    "00:01:00",
    "00:01:00",
    "00:05:00",
    "00:10:00"
)

foreach ($t in $timestamps) {
    ffmpeg -ss $t -i $video1 -frames:v 1 "$outputFolder\$($t.Replace(':','-'))_Video1.png"
    ffmpeg -ss $t -i $video2  -frames:v 1 "$outputFolder\$($t.Replace(':','-'))_Video2.png"
}
