#Persistent
SetTimer, CheckGames, 1 ; Check every 50 ms
Return

CheckGames:
IfWinActive, ahk_exe osu!.exe
{
    DisableCapsLock := true
    SetCapsLockState, AlwaysOff
}
Else IfWinActive, ahk_exe Quaver.exe
{
    DisableCapsLock := true
    SetCapsLockState, AlwaysOff
}
Else
{
    if (DisableCapsLock) ; If osu! or Quaver was active but is now closed
    {
        DisableCapsLock := false
        if (CapsLockToggled)
        {
            SetCapsLockState, On
        }
        else
        {
            SetCapsLockState, Off
        }
    }
}
Return

~CapsLock::
if (DisableCapsLock)
{
    return ; Ignore Caps Lock when osu! or Quaver is active
}
CapsLockToggled := !CapsLockToggled
Return

$*CapsLock::
if (DisableCapsLock)
{
    SetCapsLockState, Off ; Ensure Caps Lock stays off when held down in osu! or Quaver
    KeyWait, CapsLock ; Wait until Caps Lock is released
    return
}
else
{
    if (GetKeyState("CapsLock", "P"))
    {
        SetCapsLockState, Off
        KeyWait, CapsLock
        if (CapsLockToggled)
        {
            SetCapsLockState, On
        }
        else
        {
            SetCapsLockState, Off
        }
        return
    }
    else
    {
        Send {CapsLock}
    }
}
return
