foreach ($ext in '.oga', '.ogg', '.opus') {
    Remove-Item "HKCU:\Software\Classes\SystemFileAssociations\$ext\shell\oga2mp3" -Recurse -Force -ErrorAction SilentlyContinue
}
Write-Host 'Removido do menu de contexto.'
