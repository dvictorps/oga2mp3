# oga2mp3

Clique direito num `.oga` / `.ogg` / `.opus` → **Converter para MP3**. Cria uma cópia `.mp3` na mesma pasta.

## Instalar

```powershell
powershell -ExecutionPolicy Bypass -File install.ps1
```

Instala o ffmpeg via winget se precisar e registra a opção no menu (só pro seu usuário, sem admin).

No Windows 11 a opção aparece em **Mostrar mais opções** (ou Shift + clique direito).

> Não mova a pasta depois de instalar — o menu aponta pro `convert.ps1` daqui. Se mover, rode o `install.ps1` de novo.

## Desinstalar

```powershell
powershell -ExecutionPolicy Bypass -File uninstall.ps1
```
