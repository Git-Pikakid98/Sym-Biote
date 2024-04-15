#Requires AutoHotkey v2.0
#Include intro.scriptlet

MyGui.Title := TitleRun

myGui.OnEvent("Close", myGui_Close)
myGui_Close(thisGui) {
	if FileExist(A_Temp "\Sym-Biote\sym.ini")
	{
		FileDelete A_Temp "\Sym-Biote\sym.ini"
	}
	ExitApp
}

; Create the ListView with two columns, Name and Size:
LV := MyGui.Add("ListView", "r20 w300", ["Name", "Path"])

; Notify the script whenever the user clicks a row:
LV.OnEvent("Click", LV_Click)

; Gather a list of file names from a folder and put them into the ListView:
Loop Files, "Symlinks\*.bat", "F"
    LV.Add(, A_LoopFileName)

LV.ModifyCol  ; Auto-size each column to fit its contents.
LV.ModifyCol(1, "Integer")  ; For sorting purposes, indicate that column 2 is an integer.

MyBtn := MyGui.Add("Button", "x120 y376 Center w80", "Load selected Symlink")
MyBtn.OnEvent("Click", MyBtn_Click1)  ; Call MyBtn_Click when clicked.

FakeLink := MyGui.Add("Text", "x23 y415", "Delete")
FakeLink.SetFont("underline cRed")
FakeLink.OnEvent("Click", DelRun)

; Display the window:
MyGui.Show

LV_Click(LV, RowNumber)
{
    RowText := LV.GetText(RowNumber)  ; Get the text from the row's first field.
    FileAppend "", A_Temp "\Sym-Biote\sym.ini", "CP0"
    IniWrite RowText, A_Temp "\Sym-Biote\sym.ini", "Sym-Biote", "sym"
}

MyBtn_Click1(*)
{
    if FileExist(A_Temp "\Sym-Biote\sym.ini") {
        MyGui.Hide

        Value := IniRead(A_Temp "\Sym-Biote\sym.ini", "Sym-Biote", "sym")
		RunWait '"' "Symlinks\" Value '"', , "Hide"

        MyGui.Show
    } else {
        MyGui.Hide
        MsgBox "Please select a Sym-Biote Batch script"
        MyGui.Show
    }
}

DelRun(*) {
    if FileExist(A_Temp "\Sym-Biote\sym.ini") {
        MyGui.Hide

        Value := IniRead(A_Temp "\Sym-Biote\sym.ini", "Sym-Biote", "sym")
        
        If not DirExist("Symlinks\Archived") {
            DirCreate "Symlinks\Archived"
        }
        
		FileMove "Symlinks\" Value, "Symlinks\Archived"
		
		Reload
    } else {
        MyGui.Hide
        MsgBox "Please select a Sym-Biote Batch script"
        MyGui.Show
    }
}