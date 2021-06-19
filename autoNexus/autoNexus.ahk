supportCustomResolutions = false

#Include resources/Eval.ahk
#MaxThreadsPerHotkey 2
!m::
toggle := !toggle
if (toggle) 
{

if(supportCustomResolutions = true) { ; If user wants custom resolution control

InputBox, UserRes, Custom Resolution, Custom Fullscreen Resolution? Enter your width or PRESS CANCEL IF PLAYING 1920x1080, , 300, 150
if ErrorLevel
{
  res := "1"
}
else
{
  res := Eval("%UserRes%/1920")[1]

}

} else { 
res := "1" 
} ; Else ignore custom resolutions

InputBox, UserInput, Nexus Percent, Please enter Health`% to Nexus at `(0-100`)`%, , 250, 150
if ErrorLevel
{
  MsgBox, Cancelled. Press Shift+M to reactivate.
  toggle := false
}
else
{
  ; Create custom res variables here
  startRes := Eval("1570*%res%")[1]
  barRes := Eval("340*%res%")[1]
  ypos := Eval("458*%res%")[1]

  len := "%startRes%+((%UserInput%/100)*%barRes%)"
  uinp := UserInput
  result := Eval(len)[1]

  if(result = null or uinp < 1 or uinp > 100)
  {
    len := "%startRes%+((0.33)*%barRes%)"
    result := Eval(len)[1]
    MsgBox Invalid Input. Defaulted at 33`% and enabled (Press Alt+M to disable)
  }
  else
  {
    MsgBox Auto-Nexus Enabled at %UserInput%`% (Press Alt+M to disable)
  }
  toggle := true
}

} else { ; End of If toggled on. This prompts when disabled
MsgBox Auto-Nexus Disabled. Press Shift+M to Enable.
}

Loop
{

if (not toggle) 
{
break
}

PixelGetColor, color, result, ypos

if (color = 0xFFFFFF or color = 0x6A6A6A) {
Send {r}
Sleep, 1500
PixelGetColor, colorTest, result, ypos ; Test if it is still reading to nexus
if (colorTest = 0xFFFFFF or color = 0x6A6A6A) {
  MsgBox, 4, , Attempting to AutoNexus several times. Disable script?
  {
    IfMsgBox, Yes
    {
    MsgBox Auto-Nexus Disabled. (Press Alt+M to enable)
    toggle := false
    break
    }
  }
} ; End of color Test

} ; End of AutoNexus

} ; End of loop
return

^!m::
MsgBox Script Closed. Thanks for using ManBobware AutoNexus`!
ExitApp