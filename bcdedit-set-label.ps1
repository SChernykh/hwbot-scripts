If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" $PSCommandArgs" -WorkingDirectory $pwd -Verb RunAs
	Exit
}

$volume = Get-WmiObject Win32_Volume | ? { $_.DriveLetter -eq "C:" }

bcdedit /set "{current}" description $volume.Label

cmd /c Pause | Out-Null