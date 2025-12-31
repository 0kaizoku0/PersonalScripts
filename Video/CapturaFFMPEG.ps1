$video = "video.mp4"
$outputFolder = "screenshots"

New-Item -ItemType Directory -Force -Path $outputFolder

# Extrae 1 captura por cada minuto
ffmpeg -i $video -vf fps=1/60 "$outputFolder\thumb_%04d.png"
