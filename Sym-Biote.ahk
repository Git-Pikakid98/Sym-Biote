#Requires AutoHotkey v2.0
DirCreate A_Temp "\Sym-Biote"
IniWrite A_ScriptDir, A_Temp "\Sym-Biote\wd.ini", "Working", "Dir"

#Include intro.scriptlet

MyGui.Title := TitleRun

FileInstall ".Cmpl8r\main.exe", A_Temp "\Sym-Biote\main.exe", 1
FileInstall ".Cmpl8r\archive.exe", A_Temp "\Sym-Biote\archive.exe", 1
FileInstall ".Cmpl8r\make.exe", A_Temp "\Sym-Biote\make.exe", 1
FileInstall ".Cmpl8r\make2.exe", A_Temp "\Sym-Biote\make2.exe", 1

myGui.OnEvent("Close", myGui_Close)
myGui_Close(thisGui) {
	DirDelete A_Temp "\Sym-Biote", 1
	ExitApp
}

FakeLink := MyGui.Add("Text", "", "Load Symlink")
FakeLink.SetFont("underline cBlue")
FakeLink.OnEvent("Click", Launch1)

FakeLink := MyGui.Add("Text", "", "Archives")
FakeLink.SetFont("underline cBlue")
FakeLink.OnEvent("Click", Launch2)

FakeLink := MyGui.Add("Text", "", "Make New Symlink")
FakeLink.SetFont("underline cBlue")
FakeLink.OnEvent("Click", Launch3)

MyGui.Show("w300")

Launch1(*) {
    MyGui.Hide()
    RunWait A_Temp "\Sym-Biote\main.exe"
    
    PID := ProcessWaitClose("main.exe", 1000)
    MyGui.Show()
}

Launch2(*) {
    MyGui.Hide()
    RunWait A_Temp "\Sym-Biote\archive.exe"
    
    PID := ProcessWaitClose("archive.exe", 1000)
    MyGui.Show()
}

Launch3(*) {
    MyGui.Hide()
    RunWait A_Temp "\Sym-Biote\make.exe"
    
    PID := ProcessWaitClose("make.exe", 1000)
    MyGui.Show()
}