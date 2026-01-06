Start-Sleep -Seconds 0.5

#   New-Item -Type File -Path $PROFILE -Force 
#       (jika profile path belum dibuat)
#   Test-Path $PROFILE
#       (tes apakah profile telah aktif)
#   Select_Encoding UTF-8 -> UTF-8 with BOM && Use Cascadia, JetBrains, Fira Code Font
#       (Support Unicode di PowerShell)

Clear-Host
chcp 65001 | Out-Null
[Console]::InputEncoding  = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding           = [System.Text.Encoding]::UTF8

Import-Module PSReadLine
$Administrator = ([Security.Principal.WindowsPrincipal] `
        [Security.Principal.WindowsIdentity]::GetCurrent()
        ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
$waktu = Get-Date -Format HH:mm:ss
$tanggal = Get-Date -Format dd/MM/yyyy
$lebar = $Host.UI.RawUI.WindowSize.Width
$pesan = @(
    "┌────────────────────────────────┐",
    " ",
    "Hello, $env:USERNAME",
    "────────────────────────────────",
    "$waktu            $tanggal",
    " ",
    "└────────────────────────────────┘")

foreach ($line in $pesan) {
    $spaces = " " * [int](($lebar - $line.Length)/2)
    Write-Host "$spaces$line" -ForegroundColor White
}

Start-Sleep -Seconds 1
Clear-Host

if (Get-Command neofetch -ErrorAction SilentlyContinue) {
    neofetch
} else {
    Clear-Host
    Write-Host "[x] Neofetch belum terinstall. lanjutkan untuk instalasi? (y/n)" -ForegroundColor Yellow
    $ns = Read-Host "[?] Input"
    if ($ns -eq "y") {
        Write-Host "Instalasi neofetch..."
        winget install nepnep.neofetch-win
        Clear-Host
        neofetch
    }
    else {
        Write-Host "Skipping..."
    }
}

function prompt {

    Write-Host "`n" -NoNewline
    Write-Host "┌[" -NoNewline -ForegroundColor White
    Write-Host "$waktu" -NoNewline -ForegroundColor Green
    Write-Host "]─" -NoNewline -ForegroundColor White
    Write-Host "[" -NoNewline -ForegroundColor White
    Write-Host "$env:USERNAME" -NoNewline -ForegroundColor Blue
    Write-Host "@" -NoNewline -ForegroundColor White
    Write-Host "$env:COMPUTERNAME" -NoNewline -ForegroundColor Blue
    Write-Host "]─" -NoNewline -ForegroundColor White
    Write-Host "[" -NoNewline -ForegroundColor White
    Write-Host "$(Get-Location)" -NoNewline -ForegroundColor Cyan
    Write-Host "]" -NoNewline -ForegroundColor White
    Write-Host "`n└──" -NoNewline -ForegroundColor White
    $symbol = if ($Administrator) { Write-Host "#" -NoNewline -ForegroundColor Red } else { Write-Host "$" -NoNewline -ForegroundColor Green }
    return " $symbol"
}
