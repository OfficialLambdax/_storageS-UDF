#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
;~ #AutoIt3Wrapper_Version=Beta
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include "..\..\..\_storageS_UDF.au3"
#include <Array.au3>


; special characters do not work for Group- and Element names. If you do have them then use StringToBinary().
Local $sGroupName = "MyGroup"


; in _storageAO we need to create the group first
_storageAO_CreateGroup($sGroupName)

; how to write data
_storageAO_Overwrite($sGroupName, "MyElement", "Hello World. Whats up?")

; how to read data
Local $sRead = _storageAO_Read($sGroupName, "MyElement")

; log the data to console to proove its there
ConsoleWrite("Data of MyElement in Group " & $sGroupName & " : " & $sRead & @CRLF)

; how to see which elements my group has
Local $arGroupElements = _storageAO_GetGroupVars($sGroupName)

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


_storageAO_Overwrite($sGroupName, VarGetType($Array), $Array)
;~ _storageAO_Overwrite($sGroupName, VarGetType($Map), $Map)			; beta only
_storageAO_Overwrite($sGroupName, VarGetType($Int32), $Int32)
_storageAO_Overwrite($sGroupName, VarGetType($Int64), $Int64)
_storageAO_Overwrite($sGroupName, VarGetType($Double), $Double)
_storageAO_Overwrite($sGroupName, "Float", $Float)					; VarGetType returns "Double" on a Float
_storageAO_Overwrite($sGroupName, VarGetType($String), $String)
_storageAO_Overwrite($sGroupName, VarGetType($Binary), $Binary)
_storageAO_Overwrite($sGroupName, VarGetType($DLLStruct), $DLLStruct)
_storageAO_Overwrite($sGroupName, VarGetType($Pointer), $Pointer)
_storageAO_Overwrite($sGroupName, VarGetType($Object), $Object)
_storageAO_Overwrite($sGroupName, VarGetType($Bool), $Bool)
_storageAO_Overwrite($sGroupName, VarGetType($Keyword), $Keyword)
_storageAO_Overwrite($sGroupName, VarGetType($HWnd), $HWnd)
_storageAO_Overwrite($sGroupName, "Timer", $Timer)
_storageAO_Overwrite($sGroupName, VarGetType($Func), $Func)
_storageAO_Overwrite($sGroupName, VarGetType($UDF), $UDF)

; lets see
$arGroupElements = _storageAO_GetGroupVars($sGroupName)

; a few element will be shown as empty in the _ArrayDisplay() Gui, but they arent.
_ArrayDisplay($arGroupElements, "My Elements")


; how to remove individual elements.
; this will remove the element from the group, tidy it and make it free for a new storage
_storageAO_DestroyVar($sGroupName, "MyElement")


; We can also tidy the storages in a group like so
_storageAO_TidyGroupVars($sGroupName)


; lets see how it looks now
$arGroupElements = _storageAO_GetGroupVars($sGroupName)

; if the gui doesnt pop up then thats because the _Array.au3 version from the Beta has a bug where it cannot show the Keyword Null
_ArrayDisplay($arGroupElements, "Tidied")


; we can also go ahead and destroy the entire group
; that will tidy the variables, remove the group object and free the storages for new storages
_storageAO_DestroyGroup($sGroupName)


; _storageAO also has a special set of functions that can help you to optimise your script

; _storageAO_GetClaimedVars() will return any currently used storage
; lets claim one first
_storageAO_CreateGroup($sGroupName)
_storageAO_Overwrite($sGroupName, "Test", 123456)

; and see
Local $arClaimesVars = _storageAO_GetClaimedVars()
_ArrayDisplay($arClaimesVars, "Claimed Vars")

; then there is _storageAO_GetInfo()
ConsoleWrite("Thats how many storages currently exists" & @TAB & @TAB & _storageAO_GetInfo(1) & @CRLF)
ConsoleWrite("Thats how many of these storages are free" & @TAB & @TAB & _storageAO_GetInfo(2) & @CRLF)
ConsoleWrite("Thats how many of these storages are claimed" & @TAB & @TAB & _storageAO_GetInfo(3) & @CRLF)
ConsoleWrite("Thats how many bytes these storages currently take" & @TAB & _storageAO_GetInfo(4) & " b (CPU Intensive and not accurate)" & @CRLF)


; general advice.
;
; the _storageAO_GetInfo() and _storageAO_GetClaimedVars() functions are ment to help in the prevention of memory leaks.
; whenever you no longer need a storage of a group, or the group itself, then destroy them with _storageAO_DestroyVar() or
; _storageAO_DestroyGroup(). Doing so will free these storages, and because of it there are more that new storages can then
; reuse, aka less storages need to be created when there are no for reuse left.
;
; you could also setup a HotKey where the callback then displays all claimed variables.
; that way you can see whats currently going on in the _storageAO storage and if you forgot to remove something.



Func _WhatIsThis()
EndFunc