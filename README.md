# windows-dotfiles

## Softwares

### Browser

- [Chrome](https://www.google.com/intl/fr_ca/chrome/next-steps.html?statcb=1&installdataindex=empty&defaultbrowser=0#)

### Chrome extensions

- [Dashlane](https://chromewebstore.google.com/detail/dashlane-%E2%80%94-gestionnaire-d/fdjamakpfbbddfjaooikfcpapjohcfmg?hl=fr&pli=1)
- [UBlock Origin](https://chromewebstore.google.com/detail/ublock-origin-lite/ddkjiahejlhfcafbddmgiahcphecmpfh)
- [Privacy Possum](https://chromewebstore.google.com/detail/privacy-badger/pkehgijcmpdhfbdbbnkijodmdjhbjlgp?hl=fr)

### Multimedia

- [Creative cloud](https://creativecloud.adobe.com/apps/download/creative-cloud?locale=fr#)
- [VLC](https://get.videolan.org/vlc/3.0.21/win64/vlc-3.0.21-win64.exe)

### Development

- [Visual studio code](https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user)
- [Atom](https://github.com/atom/atom/releases/latest)
- [Heynote](https://github.com/heyman/heynote/releases/download/v2.1.1/Heynote_2.1.1.exe)

## WSL

Install WSL 2 with debian

```shell
# In PowerShell as Administrator

# Enable WSL and VirtualMachinePlatform features
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# Download and install the Linux kernel update package
$wslUpdateInstallerUrl = "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi"
$downloadFolderPath = (New-Object -ComObject Shell.Application).NameSpace('shell:Downloads').Self.Path
$wslUpdateInstallerFilePath = "$downloadFolderPath/wsl_update_x64.msi"
$wc = New-Object System.Net.WebClient
$wc.DownloadFile($wslUpdateInstallerUrl, $wslUpdateInstallerFilePath)

# Restart your system
Start-Process -Filepath "$wslUpdateInstallerFilePath"

# Set WSL default version to 2
wsl --set-default-version 2
```

[Install Debian from Microsoft Store](https://apps.microsoft.com/detail/9msvkqc78pk6)