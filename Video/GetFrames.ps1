$video01 = "C:\Users\FTW3\OneDrive\Animee\[df68] One Piece Season 01 [v2][1080p][x264][JPN][SUB]\One Piece - 0001 - I'm Luffy! The Man Who's Gonna Be King of the Pirates! [v2][1080p][x264][AC3][SUB]-df68.mkv"
$video02 = "D:\Torrents\One Piece\01. Romance Dawn 1-3 [RLSP]\[RedLineSP] One Piece 1 [DVD 480p] [987092E4].avi"
$outputFolder = "screenshots"
Remove-Item -Path "$outputFolder\*" -Recurse -Force
pause
New-Item -ItemType Directory -Force -Path $outputFolder



# Extrae 1 captura por cada minuto 1/60 o cada 10 segundos 1/10
# ffmpeg -i $video01 -vf "fps=1/100,scale=-1:2160" "$outputFolder\thumb_%04d_video01.png" -y
# ffmpeg -i $video02 -vf "fps=1/100,scale=-1:2160" "$outputFolder\thumb_%04d_video02.png" -y


# cada 30 segundos ($_ * 30) hasta 10 minutos 0..20
$timestamps = 0..20 | ForEach-Object {
    [TimeSpan]::FromSeconds($_ * 30).ToString("hh\:mm\:ss")
}


foreach ($t in $timestamps) {
    # Reemplazar ":" por "-"
    $safeName = $t.Replace(":", "-")

    # Mostrar la ruta en consola
    Write-Host "$outputFolder\$safeName`_Video01.png" -ForegroundColor Green

    # Ejecutar ffmpeg para ambos videos
    ffmpeg -ss $t -i $video01 -frames:v 1 -vf "scale=-1:2160" "$outputFolder\$safeName`_Video01.png" -y
    ffmpeg -ss $t -i $video02 -frames:v 1 -vf "scale=-1:2160" "$outputFolder\$safeName`_Video02.png" -y
}
