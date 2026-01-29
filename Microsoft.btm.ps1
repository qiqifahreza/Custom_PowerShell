if (Get-Process btm -ErrorAction SilentlyContinue) {
    return
}

Start-Process btm

Start-Sleep -Milliseconds 800

Add-Type @"
using System;
using System.Runtime.InteropServices;
public class Win {
  [DllImport("user32.dll")]
  public static extern IntPtr GetForegroundWindow();

  [DllImport("user32.dll")]
  public static extern bool MoveWindow(
    IntPtr hWnd, int X, int Y, int nWidth, int nHeight, bool bRepaint);
}
"@

$hWnd = [Win]::GetForegroundWindow()

$width  = 700
$height = 450

Add-Type -AssemblyName System.Windows.Forms
$screen = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds

$x = $screen.Width - $width
$y = 0

[Win]::MoveWindow($hWnd, $x, $y, $width, $height, $true)