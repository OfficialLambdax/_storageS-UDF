#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
;~ #AutoIt3Wrapper_Version=Beta
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include "..\..\..\_storageS_UDF.au3"
#include <Array.au3>


; special characters do not work for Group- and Element names. If you do have them then use StringToBinary().
Local $sGroupName = "MyGroup"


; in _storageO we need to create the group first
_storageO_CreateGroup($sGroupName)

; how to write data
_storageO_Overwrite($sGroupName, "MyElement", "Hello World. Whats up?")

; how to read data
Local $sRead = _storageO_Read($sGroupName, "MyElement")

; log the data to console to proove its there
ConsoleWrite("Data of MyElement in Group " & $sGroupName & " : " & $sRead & @CRLF)

; how to see which elements my group has
Local $arGroupElements = _storageO_GetGroupVars($sGroupName)

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


_storageO_Overwrite($sGroupName, VarGetType($Array), $Array)
;~ _storageGO_Overwrite($sGroupName, VarGetType($Map), $Map)			; beta only
_storageO_Overwrite($sGroupName, VarGetType($Int32), $Int32)
_storageO_Overwrite($sGroupName, VarGetType($Int64), $Int64)
_storageO_Overwrite($sGroupName, VarGetType($Double), $Double)
_storageO_Overwrite($sGroupName, "Float", $Float)					; VarGetType returns "Double" on a Float
_storageO_Overwrite($sGroupName, VarGetType($String), $String)
_storageO_Overwrite($sGroupName, VarGetType($Binary), $Binary)
_storageO_Overwrite($sGroupName, VarGetType($DLLStruct), $DLLStruct)
_storageO_Overwrite($sGroupName, VarGetType($Pointer), $Pointer)
_storageO_Overwrite($sGroupName, VarGetType($Object), $Object)
_storageO_Overwrite($sGroupName, VarGetType($Bool), $Bool)
_storageO_Overwrite($sGroupName, VarGetType($Keyword), $Keyword)
_storageO_Overwrite($sGroupName, VarGetType($HWnd), $HWnd)
_storageO_Overwrite($sGroupName, "Timer", $Timer)
_storageO_Overwrite($sGroupName, VarGetType($Func), $Func)
_storageO_Overwrite($sGroupName, VarGetType($UDF), $UDF)

; lets see
$arGroupElements = _storageO_GetGroupVars($sGroupName)

; a few element will be shown as empty in the _ArrayDisplay() Gui, but they arent.
_ArrayDisplay($arGroupElements, "My Elements")


; we can also go ahead and destroy the entire group
; that will remove the entire group object
_storageO_DestroyGroup($sGroupName)






Func _WhatIsThis()
EndFunc