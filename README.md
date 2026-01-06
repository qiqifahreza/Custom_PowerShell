# **Setup-PowerShell**
Buat Profil Ps1 di PowerShell
```
New-Item -Type File -Path $PROFILE -Force 
```
Uji PROFILE apakah aktif
```
Test-Path $PROFILE
```
Atur UTF-8 agar Support Unicode
```
Select_Encoding UTF-8 -> UTF-8 with BOM && Use Cascadia, JetBrains, Fira Code Font
```
# **Instalasi**
Open PwerShell

Clone Repository
```
git clone https://github.com/qiqifahreza/Custom_PowerShell.git $HOME\Documents\WindowsPowerShell
```
Run PowerShell
```
. $PROFILE
```
