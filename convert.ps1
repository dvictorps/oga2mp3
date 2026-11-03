param([Parameter(Mandatory)][string]$Path)

# Explorer pode ter um PATH antigo; recarrega do registro
$env:Path = [Environment]::GetEnvironmentVariable('Path', 'Machine') + ';' + [Environment]::GetEnvironmentVariable('Path', 'User')

$ffmpeg = (Get-Command ffmpeg -ErrorAction SilentlyContinue).Source
if (-not $ffmpeg) {
    $links = Join-Path $env:LOCALAPPDATA 'Microsoft\WinGet\Links\ffmpeg.exe'
    if (Test-Path $links) { $ffmpeg = $links }
}
if (-not $ffmpeg) {
    Add-Type -AssemblyName PresentationFramework
    [System.Windows.MessageBox]::Show('ffmpeg nao encontrado. Rode o install.ps1 de novo.', 'oga2mp3') | Out-Null
    exit 1
}

$dir  = Split-Path $Path -Parent
$base = [IO.Path]::GetFileNameWithoutExtension($Path)
$out  = Join-Path $dir "$base.mp3"
$i = 1
while (Test-Path -LiteralPath $out) { $out = Join-Path $dir "$base ($i).mp3"; $i++ }

& $ffmpeg -hide_banner -loglevel error -n -i $Path -vn -codec:a libmp3lame -q:a 2 $out
if ($LASTEXITCODE -ne 0) {
    Add-Type -AssemblyName PresentationFramework
    [System.Windows.MessageBox]::Show("Falha ao converter:`n$Path", 'oga2mp3') | Out-Null
    exit 1
}
