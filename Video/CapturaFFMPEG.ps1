$video1 = "C:\Users\FTW3\OneDrive\Animee\[df68] One Piece Season 01 [v2][1080p][x264][JPN][SUB]\One Piece - 0001 - I'm Luffy! The Man Who's Gonna Be King of the Pirates! [v2][1080p][x264][AC3][SUB]-df68.mkv"
$video2 = "D:\Torrents\One Piece\01. Romance Dawn 1-3 [RLSP]\[RedLineSP] One Piece 1 [DVD 480p] [987092E4].avi"
$outputFolder = "screenshots"

New-Item -ItemType Directory -Force -Path $outputFolder

# Extrae 1 captura por cada minuto 1/60 o cada 10 segundos 1/10
ffmpeg -i $video1 -vf fps=1/20 "$outputFolder\thumb_%04d_video1.png"
ffmpeg -i $video2 -vf fps=1/20 "$outputFolder\thumb_%04d_video2.png"

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
