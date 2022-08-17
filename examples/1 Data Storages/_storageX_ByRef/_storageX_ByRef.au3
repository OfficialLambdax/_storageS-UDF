#NoTrayIcon
#include "..\..\..\_storageS_UDF.au3"


#cs
	_storageX_ByRef() functions only increase performance if the data stored inside a data storage is
	going to be manipulated. If the data is just read or overwritten then these functions will be slower.

#ce


Local $hTimer = 0, $nTime = 0, $nIterations = 1e4

; Array Manipulation test
Local $arTestArray[100], $arChange[0]

; String append test
Local $sTestString = ""



_storageGO_CreateGroup(123)
_storageGO_Overwrite(123, "test", $arTestArray)

$hTimer = TimerInit()
For $i = 1 TO $nIterations
	$arChange = _storageGO_Read(123, "test")
	$arChange[Random(0, 99, 1)] = Random(0, 9, 1)
	_storageGO_Overwrite(123, "test", $arChange)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("Array Manipulation test took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)

$hTimer = TimerInit()
For $i = 1 TO $nIterations
	_storageGO_ByRef(123, "test", "_ByRef_Array")
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("ByRef Array Manipulation test took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @TAB & "(FASTER)" & @CRLF)

Func _ByRef_Array(Byref $vStorageData, $vElementGroup, $Void)
	$vStorageData[Random(0, 99, 1)] = Random(0, 9, 1)
EndFunc

_storageGO_DestroyGroup(123)


ConsoleWrite(@CRLF)


_storageGO_CreateGroup(123)
_storageGO_Overwrite(123, "test", $sTestString)


$hTimer = TimerInit()
For $i = 1 TO $nIterations
	_storageGO_Overwrite(123, "test", _storageGO_Read(123, "test") & "a")
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("String append test took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)

_storageGO_Overwrite(123, "test", $sTestString)

$hTimer = TimerInit()
For $i = 1 TO $nIterations
	_storageGO_Append(123, "test", "a")
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("Append String append test took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)

_storageGO_Overwrite(123, "test", $sTestString)
$hTimer = TimerInit()
For $i = 1 TO $nIterations
	_storageGO_ByRef(123, "test", "_ByRef_String")
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("ByRef String append test took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @TAB & "(SLOWER)" & @CRLF)

Func _ByRef_String(Byref $vStorageData, $vElementGroup, $Void)
	$vStorageData &= "a"
EndFunc

_storageGO_DestroyGroup(123)


ConsoleWrite(@CRLF)


_storageGO_CreateGroup(123)
_storageGO_Overwrite(123, "test", "")


$hTimer = TimerInit()
For $i = 1 TO $nIterations
	_storageGO_Overwrite(123, "test", Random(0, 9, 1))
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("Random Number Overwrite test took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)

$hTimer = TimerInit()
For $i = 1 TO $nIterations
	_storageGO_ByRef(123, "test", "_ByRef_RandomNumber")
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("ByRef Random Number Overwrite test took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @TAB & "(SLOWER)" & @CRLF)

Func _ByRef_RandomNumber(Byref $vStorageData, $vElementGroup, $Void)
	$vStorageData = Random(0, 9, 1)
EndFunc

_storageGO_DestroyGroup(123)


ConsoleWrite(@CRLF)

_storageGO_CreateGroup(123)
_storageGO_Overwrite(123, "test", 0)


$hTimer = TimerInit()
For $i = 1 TO $nIterations
	_storageGO_Overwrite(123, "test", _storageGO_Read(123, "test") + 1)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("Add 1 test took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)

_storageGO_Overwrite(123, "test", 0)
$hTimer = TimerInit()
For $i = 1 TO $nIterations
	_storageGO_ByRef(123, "test", "_ByRef_PlusOne")
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("ByRef Add 1 test took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @TAB & "(FASTER)" & @CRLF)

Func _ByRef_PlusOne(Byref $vStorageData, $vElementGroup, $Void)
	$vStorageData += 1
EndFunc

_storageGO_DestroyGroup(123)

