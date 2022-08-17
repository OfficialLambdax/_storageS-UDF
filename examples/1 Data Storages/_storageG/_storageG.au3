#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
;~ #AutoIt3Wrapper_Version=Beta
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include "..\..\..\_storageS_UDF.au3"
#include <Array.au3>


; any character thet would not work in the creation of a variable, do not work. If you do have them then use StringToBinary().
Local $sGroupName = "MyGroup"


; how to write data
_storageG_Overwrite($sGroupName, "MyElement", "Hello World. Whats up?")

; how to read data
Local $sRead = _storageG_Read($sGroupName, "MyElement")

; log the data to console to proove its there
ConsoleWrite("Data of MyElement in Group " & $sGroupName & " : " & $sRead & @CRLF)

; how to see which elements my group has
Local $arGroupElements = _storageG_GetGroupVars($sGroupName)

; show them
; you will see a 2D array with size [1][3]
; [n][0] = The name of the element
; [n][1] = The Variable Type of the element
; [n][2] = The Data
_ArrayDisplay($arGroupElements, "My Element")


; lets see which types of data we can store. Tl;dr : any
Local $Array[100][100]
;~ Local $Map[]					<-				<-					; beta only
Local $Int32 = Int(100, 1)
Local $Int64 = Int(100, 2)
Local $Double = Number(100.1, 3)
Local $Float = 3.14159
Local $String = "A String"
Local $Binary = StringToBinary("A Binary")
Local $DLLStruct = DllStructCreate("struct;")
Local $Pointer = Ptr(0)
Local $Object = ObjCreate("Scripting.Dictionary")
Local $Bool = True
Local $Keyword = Default
Local $HWnd = HWnd(0)
Local $Timer = TimerInit()
Local $Func = MsgBox
Local $UDF = _WhatIsThis


_storageG_Overwrite($sGroupName, VarGetType($Array), $Array)
;~ _storageG_Overwrite($sGroupName, VarGetType($Map), $Map)			; beta only
_storageG_Overwrite($sGroupName, VarGetType($Int32), $Int32)
_storageG_Overwrite($sGroupName, VarGetType($Int64), $Int64)
_storageG_Overwrite($sGroupName, VarGetType($Double), $Double)
_storageG_Overwrite($sGroupName, "Float", $Float)					; VarGetType returns "Double" on a Float
_storageG_Overwrite($sGroupName, VarGetType($String), $String)
_storageG_Overwrite($sGroupName, VarGetType($Binary), $Binary)
_storageG_Overwrite($sGroupName, VarGetType($DLLStruct), $DLLStruct)
_storageG_Overwrite($sGroupName, VarGetType($Pointer), $Pointer)
_storageG_Overwrite($sGroupName, VarGetType($Object), $Object)
_storageG_Overwrite($sGroupName, VarGetType($Bool), $Bool)
_storageG_Overwrite($sGroupName, VarGetType($Keyword), $Keyword)
_storageG_Overwrite($sGroupName, VarGetType($HWnd), $HWnd)
_storageG_Overwrite($sGroupName, "Timer", $Timer)
_storageG_Overwrite($sGroupName, VarGetType($Func), $Func)
_storageG_Overwrite($sGroupName, VarGetType($UDF), $UDF)

; lets see
$arGroupElements = _storageG_GetGroupVars($sGroupName)

; a few element will be shown as empty in the _ArrayDisplay() Gui, but they arent.
_ArrayDisplay($arGroupElements, "My Elements")


; how to remove elements.
; thats actually not possible with the _storageG method, thats the mayor downside of this method.
; we rather just can overwrite the storages with the smallest type of data available -> Null

; Lets go ahead and clean the storage
_storageG_TidyGroupVars($sGroupName)


; lets see how it looks now
$arGroupElements = _storageG_GetGroupVars($sGroupName)

; if the gui doesnt pop up then thats because the _Array.au3 version from the Beta has a bug where it cannot show the Keyword Null
_ArrayDisplay($arGroupElements, "Tidied")


; we can also go ahead and destroy the entire group
; that will tidy the variables and remove the group object
; but the storages are still there, because its no possible to remove them in Autoit
_storageG_DestroyGroup($sGroupName)





Func _WhatIsThis()
EndFunc