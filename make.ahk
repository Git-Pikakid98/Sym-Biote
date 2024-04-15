#Requires AutoHotkey v2.0
#Include intro.scriptlet

FileAppend "mkdir ", A_Temp "\Sym-Biote\symtemp.bat"

IB := InputBox("Select a directory to link from (This is the folder where the Symlink will be created. Please make sure to move your folder or file beforehand)", TitleRun, "w400 h130")
if IB.Result = "Cancel"
{
    FileDelete A_Temp "\Sym-Biote\symtemp.bat"
    ExitApp
} else {
    if FileExist(IB.Value) {
        MsgBox "Error. Please move this directory or file beforehand continuing"
        Reload
    } else {
        FileAppend '"' IB.Value '"' " ", A_Temp "\Sym-Biote\symtemp.bat"
    }
}

IB := InputBox("Select the directory that the symlink will lead to (This is where you moved the folder)", TitleRun, "w400 h130")
if IB.Result = "Cancel"
{
    FileDelete A_Temp "\Sym-Biote\symtemp.bat"
    ExitApp
} else {
    FileAppend '"' IB.Value '"' " ", A_Temp "\Sym-Biote\symtemp.bat"
}

MyGui.Title := TitleRun

MyGui.OnEvent("Close", MyGui_Close)
MyGui_Close(thisGui) {
	if FileExist(A_Temp "\Sym-Biote\symtemp.bat")
	{
		FileDelete A_Temp "\Sym-Biote\symtemp.bat"
	}
	ExitApp
}

FakeLink := MyGui.Add("Text", "", "Please choose what type of symlink you'd like to create (Please be aware that creating an incorrect symlink may result in system instability or errors in your program)")

FakeLink := MyGui.Add("Text", "", "")

FakeLink := MyGui.Add("Text", "", "Single File")
FakeLink.SetFont("underline cBlue")
FakeLink.OnEvent("Click", Launch1)

FakeLink := MyGui.Add("Text", "", "Directory")
FakeLink.SetFont("underline cBlue")
FakeLink.OnEvent("Click", Launch2)

MyGui.Show("w300")

Launch1(*) {
    MyGui.Hide()
    RunWait A_Temp "\Sym-Biote\make2.exe"
    ExitApp
}

Launch2(*) {
    MyGui.Hide()
    RunWait A_Temp "\Sym-Biote\make2.exe"
    ExitApp
}