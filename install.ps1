# Adiciona "Converter para MP3" no menu de clique direito (so pro usuario atual, sem admin)
$exts   = '.oga', '.ogg', '.opus'
$script = Join-Path $PSScriptRoot 'convert.ps1'

if (-not (Get-Command ffmpeg -ErrorAction SilentlyContinue) -and
    -not (Test-Path (Join-Path $env:LOCALAPPDATA 'Microsoft\WinGet\Links\ffmpeg.exe'))) {
    Write-Host 'Instalando ffmpeg via winget...'
    winget install --id Gyan.FFmpeg -e --accept-source-agreements --accept-package-agreements --silent
}

$cmd = "powershell.exe -NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -File `"$script`" `"%1`""

foreach ($ext in $exts) {
    $key = "HKCU:\Software\Classes\SystemFileAssociations\$ext\shell\oga2mp3"
    New-Item -Path "$key\command" -Force | Out-Null
    Set-ItemProperty -Path $key -Name '(default)' -Value 'Converter para MP3'
    Set-ItemProperty -Path $key -Name 'Icon' -Value 'imageres.dll,-1026'
    Set-ItemProperty -Path "$key\command" -Name '(default)' -Value $cmd
}

Write-Host "Pronto. Clique direito num arquivo $($exts -join '/') -> Converter para MP3"
Write-Host '(No Windows 11 a opcao pode ficar em "Mostrar mais opcoes" / Shift+clique direito)'
