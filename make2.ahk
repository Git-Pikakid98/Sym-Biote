#Requires AutoHotkey v2.0
#Include intro.scriptlet

MyGui.Title := TitleRun

IB := InputBox("Name your file", TitleRun, "w400 h130")
if IB.Result = "Cancel"
{
    ExitApp
} else {
    FileMove A_Temp "\Sym-Biote\symtemp.bat", "Symlinks\" IB.Value ".bat"
    IniWrite IB.Value ".bat", A_Temp "\Sym-Biote\sym.ini", "Last", "Last"
}

if FileExist(A_Temp "\Sym-Biote\symtemp.bat")
{
    FileDelete A_Temp "\Sym-Biote\symtemp.bat"
}
    
OriginalSymFile := IniRead(A_Temp "\Sym-Biote\sym.ini", "Last", "Last")

MyGui.Title := TitleRun

MyGui.OnEvent("Close", MyGui_Close)
MyGui_Close(thisGui) {

}

FakeLink := MyGui.Add("Text", "", "Add another line?")

FakeLink := MyGui.Add("Text", "", "")

FakeLink := MyGui.Add("Text", "", "Yes")
FakeLink.SetFont("underline cBlue")
FakeLink.OnEvent("Click", Launch1)

FakeLink := MyGui.Add("Text", "", "No")
FakeLink.SetFont("underline cBlue")
FakeLink.OnEvent("Click", Launch2)

MyGui.Show("w300")

Launch1(*) {
    FileAppend("`n", "Symlinks\" OriginalSymFile)
    FileMove "Symlinks\" OriginalSymFile, A_Temp "\Sym-Biote\symtemp.bat"
    Reload
}

Launch2(*) {
    FakeLink := MyGui.Add("Text", "", "Create another symlink? (Will use a seperate file)")

    FakeLink := MyGui.Add("Text", "", "")

    FakeLink := MyGui.Add("Text", "", "Yes")
    FakeLink.SetFont("underline cBlue")
    FakeLink.OnEvent("Click", Launch21)

    FakeLink := MyGui.Add("Text", "", "No")
    FakeLink.SetFont("underline cBlue")
    FakeLink.OnEvent("Click", Launch22)

     MyGui.Show("w300")

    Launch21(*) {
        Run A_Temp "\Sym-Biote\make.exe"
        ExitApp
        
    }

    Launch22(*) {
        ExitApp
    }
}