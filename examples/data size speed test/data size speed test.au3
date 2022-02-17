#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Version=Beta
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include "..\..\_storageS_UDF.au3"

#cs
	CAUTION !

	THIS TEST IS MEMORY INTENSIVE (Up to 10 GB of RAM will be used)

	X64 Advised
#ce


; Set to True if you dont want to run the Memory intensive test. Atleast 2 GB of RAM are still going to be used.
Local $bDoNotRunTheMBTest = False


Local $nTime = 0, $sText = ""



; ===============================================================================================================================
; Single Byte Test
ConsoleWrite("Single Byte Test Start __________________________________________" & @CRLF)
ConsoleWrite("Calling each function 1e5 Times to create all storages" & @CRLF & @CRLF)

$nTime = _Test_Write_Assign_Method("1", 1e5)
ConsoleWrite("Assign/Eval" & @TAB & "Single Byte Write Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @CRLF)

$nTime = _Test_Read_Assign_Method(1e5)
ConsoleWrite("Assign/Eval" & @TAB & "Single Byte Read Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @CRLF)

ConsoleWrite(@CRLF)

$nTime = _Test_Write_GO_Method("1", 1e5)
ConsoleWrite("GO         " & @TAB & "Single Byte Write Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @CRLF)

$nTime = _Test_Read_GO_Method(1e5)
ConsoleWrite("GO         " & @TAB & "Single Byte Read Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @CRLF)

ConsoleWrite(@CRLF)

_storageO_CreateGroup(123)
$nTime = _Test_Write_DictObj_Method("1", 1e5)
ConsoleWrite("DictObj  " & @TAB & "Single Byte Write Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @CRLF)

$nTime = _Test_Read_DictObj_Method(1e5)
ConsoleWrite("DictObj  " & @TAB & "Single Byte Read Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @CRLF)

ConsoleWrite(@CRLF)

ConsoleWrite("Single Byte Test Start __________________________________________" & @CRLF)
ConsoleWrite("Calling each function 1e5 Times again on the already existing storages" & @CRLF & @CRLF)


$nTime = _Test_Write_Assign_Method("1", 1e5)
ConsoleWrite("Assign/Eval" & @TAB & "Single Byte Write Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @TAB & "(Faster once variables already exist)" & @CRLF)

$nTime = _Test_Read_Assign_Method(1e5)
ConsoleWrite("Assign/Eval" & @TAB & "Single Byte Read Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @CRLF)
_storageG_TidyGroupVars(123)

ConsoleWrite(@CRLF)

$nTime = _Test_Write_GO_Method("1", 1e5)
ConsoleWrite("GO         " & @TAB & "Single Byte Write Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @TAB & "(Faster once variables already exist)" & @CRLF)

$nTime = _Test_Read_GO_Method(1e5)
ConsoleWrite("GO         " & @TAB & "Single Byte Read Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @CRLF)

_storageGO_TidyGroupVars(123)

ConsoleWrite(@CRLF)

$nTime = _Test_Write_DictObj_Method("1", 1e5)
ConsoleWrite("DictObj  " & @TAB & "Single Byte Write Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)"& @TAB & "(Not true for the DictObj)" & @CRLF)

$nTime = _Test_Read_DictObj_Method(1e5)
ConsoleWrite("DictObj  " & @TAB & "Single Byte Read Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @CRLF)

_storageO_TidyGroupVars(123)

ConsoleWrite(@CRLF)



; ===============================================================================================================================
; 10 to 100 KB test
ConsoleWrite("Kilo Byte Test Start __________________________________________" & @CRLF)
ConsoleWrite("Calling each function 1e4 Times" & @CRLF & @CRLF)

Local $nTestIterations = 1e4

For $i = 1024 * 10 To 1024 * 100 Step 1024 * 10

	$sText = Round($i / 1024, 2) & " KB "

	$nTime = _Test_Write_Assign_Method(_CreateDataSet($i), $nTestIterations)
	ConsoleWrite("Assign/Eval" & @TAB & $sText & " Write Test" & @TAB & "took: " & @extended & " ms" & @TAB & "(" & $nTime & " ms/avg)" & @CRLF)

	$nTime = _Test_Read_Assign_Method($nTestIterations)
	ConsoleWrite("Assign/Eval" & @TAB & $sText & " Read Test " & @TAB & "took: " & @extended & " ms" & @TAB & "(" & $nTime & " ms/avg)" & @CRLF)
	_storageG_TidyGroupVars(123)

	ConsoleWrite(@CRLF)

	$nTime = _Test_Write_GO_Method(_CreateDataSet($i), $nTestIterations)
	ConsoleWrite("GO         " & @TAB & $sText & " Write Test" & @TAB & "took: " & @extended & " ms" & @TAB & "(" & $nTime & " ms/avg)" & @CRLF)

	$nTime = _Test_Read_GO_Method($nTestIterations)
	ConsoleWrite("GO         " & @TAB & $sText & " Read Test " & @TAB & "took: " & @extended & " ms" & @TAB & "(" & $nTime & " ms/avg)" & @CRLF)
	_storageGO_TidyGroupVars(123)

	ConsoleWrite(@CRLF)

	_storageO_CreateGroup(123)
	$nTime = _Test_Write_DictObj_Method(_CreateDataSet($i), $nTestIterations)
	ConsoleWrite("DictObj  " & @TAB & $sText & " Write Test" & @TAB & "took: " & @extended & " ms" & @TAB & "(" & $nTime & " ms/avg)" & @CRLF)

	$nTime = _Test_Read_DictObj_Method($nTestIterations)
	ConsoleWrite("DictObj  " & @TAB & $sText & " Read Test " & @TAB & "took: " & @extended & " ms" & @TAB & "(" & $nTime & " ms/avg)" & @CRLF)

	_storageO_TidyGroupVars(123)

	ConsoleWrite(@CRLF)

Next

; ===============================================================================================================================
; 1 to 5 MB Test
if $bDoNotRunTheMBTest Then Exit

ConsoleWrite("Mega Byte Test Start __________________________________________" & @CRLF)
ConsoleWrite("Calling each function 1000 Times" & @CRLF & @CRLF)

Local $nTestIterations = 1000

For $i = 1048576 To 1048576 * 5 Step 1048576

	$sText = Round($i / 1048576, 2) & " MB "

	$nTime = _Test_Write_Assign_Method(_CreateDataSet($i), $nTestIterations)
	ConsoleWrite("Assign/Eval" & @TAB & $sText & " Write Test" & @TAB & "took: " & @extended & " ms" & @TAB & "(" & $nTime & " ms/avg)" & @CRLF)

	$nTime = _Test_Read_Assign_Method($nTestIterations)
	ConsoleWrite("Assign/Eval" & @TAB & $sText & " Read Test " & @TAB & "took: " & @extended & " ms" & @TAB & "(" & $nTime & " ms/avg)" & @CRLF)
	_storageG_TidyGroupVars(123)

	ConsoleWrite(@CRLF)

	$nTime = _Test_Write_GO_Method(_CreateDataSet($i), $nTestIterations)
	ConsoleWrite("GO         " & @TAB & $sText & " Write Test" & @TAB & "took: " & @extended & " ms" & @TAB & "(" & $nTime & " ms/avg)" & @CRLF)

	$nTime = _Test_Read_GO_Method($nTestIterations)
	ConsoleWrite("GO         " & @TAB & $sText & " Read Test " & @TAB & "took: " & @extended & " ms" & @TAB & "(" & $nTime & " ms/avg)" & @CRLF)
	_storageGO_TidyGroupVars(123)

	ConsoleWrite(@CRLF)

	_storageO_CreateGroup(123)
	$nTime = _Test_Write_DictObj_Method(_CreateDataSet($i), $nTestIterations)
	ConsoleWrite("DictObj  " & @TAB & $sText & " Write Test" & @TAB & "took: " & @extended & " ms" & @TAB & "(" & $nTime & " ms/avg)" & @CRLF)

	$nTime = _Test_Read_DictObj_Method($nTestIterations)
	ConsoleWrite("DictObj  " & @TAB & $sText & " Read Test " & @TAB & "took: " & @extended & " ms" & @TAB & "(" & $nTime & " ms/avg)" & @CRLF)

	_storageO_TidyGroupVars(123)

	ConsoleWrite(@CRLF)

Next






; ===============================================================================================================================
; Test functions

Func _Test_Write_Assign_Method($sData, $nTestIterations)
	Local $hTimer = 0, $nTime = 0
	$hTimer = TimerInit()
	For $i = 1 To $nTestIterations
		_storageG_Overwrite(123, $i, $sData)
	Next
	$nTime = TimerDiff($hTimer)
	Return SetExtended($nTime, $nTime / $nTestIterations)
EndFunc

Func _Test_Read_Assign_Method($nTestIterations)
	Local $hTimer = 0, $nTime = 0
	$hTimer = TimerInit()
	For $i = 1 To $nTestIterations
		_storageG_Read(123, $i)
	Next
	$nTime = TimerDiff($hTimer)
	Return SetExtended($nTime, $nTime / $nTestIterations)
EndFunc

Func _Test_Write_DictObj_Method($sData, $nTestIterations)
	Local $hTimer = 0, $nTime = 0
	$hTimer = TimerInit()
	For $i = 1 To $nTestIterations
		_storageO_Overwrite(123, $i, $sData)
	Next
	$nTime = TimerDiff($hTimer)
	Return SetExtended($nTime, $nTime / $nTestIterations)
EndFunc

Func _Test_Read_DictObj_Method($nTestIterations)
	Local $hTimer = 0, $nTime = 0
	$hTimer = TimerInit()
	For $i = 1 To $nTestIterations
		_storageO_Read(123, $i)
	Next
	$nTime = TimerDiff($hTimer)
	Return SetExtended($nTime, $nTime / $nTestIterations)
EndFunc

Func _Test_Write_GO_Method($sData, $nTestIterations)
	Local $hTimer = 0, $nTime = 0
	$hTimer = TimerInit()
	For $i = 1 To $nTestIterations
		_storageGO_Overwrite(123, $i, $sData)
	Next
	$nTime = TimerDiff($hTimer)
	Return SetExtended($nTime, $nTime / $nTestIterations)
EndFunc

Func _Test_Read_GO_Method($nTestIterations)
	Local $hTimer = 0, $nTime = 0
	$hTimer = TimerInit()
	For $i = 1 To $nTestIterations
		_storageGO_Read(123, $i)
	Next
	$nTime = TimerDiff($hTimer)
	Return SetExtended($nTime, $nTime / $nTestIterations)
EndFunc

Func _CreateDataSet($nSize)
	Local $sData = ""
	For $i = 1 To $nSize
		$sData &= "1"
	Next
	Return $sData
EndFunc