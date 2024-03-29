#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
;~ #AutoIt3Wrapper_Version=Beta
#AutoIt3Wrapper_UseX64=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include "..\..\..\_storageS_UDF.au3"

#cs
	CAUTION !

	THIS TEST IS MEMORY INTENSIVE (Up to 10 GB of RAM will be used)

	X64 Advised
#ce


; Set to True if you dont want to run the Memory intensive test. Atleast 2 GB of RAM are still going to be used.
Local $bDoNotRunTheMBTest = False


Local $nTime = 0, $sText = "", $sData = ""


; redimming AO storage Array
_storageAO_ReDim(1e5)

; creating groups
_storageGO_CreateGroup(123)
_storageGM_CreateGroup(123)
_storageAO_CreateGroup(123)
_storageO_CreateGroup(123)
_storageGi_CreateGroup(123)


; ===============================================================================================================================
; Single Byte Test
ConsoleWrite("Single Byte Test Start __________________________________________" & @CRLF)
ConsoleWrite("Creating 1e4 Storages" & @CRLF & @CRLF)

$nTime = _Test_Write_Assign_Method("1", 1e4)
ConsoleWrite("G          " & @TAB & "Single Byte Write Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @CRLF)

$nTime = _Test_Read_Assign_Method(1e4)
ConsoleWrite("G          " & @TAB & "Single Byte Read Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @CRLF)

ConsoleWrite(@CRLF)

$nTime = _Test_Write_Gi_Method("1", 1e4)
ConsoleWrite("Gi         " & @TAB & "Single Byte Write Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @CRLF)

$nTime = _Test_Read_Gi_Method(1e4)
ConsoleWrite("Gi         " & @TAB & "Single Byte Read Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @CRLF)

ConsoleWrite(@CRLF)

$nTime = _Test_Write_Gx_Method("1", 1e4)
ConsoleWrite("Gx         " & @TAB & "Single Byte Write Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @CRLF)

$nTime = _Test_Read_Gx_Method(1e4)
ConsoleWrite("Gx         " & @TAB & "Single Byte Read Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @CRLF)

ConsoleWrite(@CRLF)

$nTime = _Test_Write_GO_Method("1", 1e4)
ConsoleWrite("GO         " & @TAB & "Single Byte Write Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @CRLF)

$nTime = _Test_Read_GO_Method(1e4)
ConsoleWrite("GO         " & @TAB & "Single Byte Read Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @CRLF)

ConsoleWrite(@CRLF)

$nTime = _Test_Write_AO_Method("1", 1e4)
ConsoleWrite("AO         " & @TAB & "Single Byte Write Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @CRLF)

$nTime = _Test_Read_AO_Method(1e4)
ConsoleWrite("AO         " & @TAB & "Single Byte Read Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @CRLF)

ConsoleWrite(@CRLF)

$nTime = _Test_Write_GM_Method("1", 1e4)
ConsoleWrite("GM         " & @TAB & "Single Byte Write Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @TAB & "(Has issues with large storage counts per group)" & @CRLF)

$nTime = _Test_Read_GM_Method(1e4)
ConsoleWrite("GM         " & @TAB & "Single Byte Read Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @CRLF)

ConsoleWrite(@CRLF)

$nTime = _Test_Write_DictObj_Method("1", 1e4)
ConsoleWrite("O          " & @TAB & "Single Byte Write Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @TAB & "(Fastest when creating new)" & @CRLF)

$nTime = _Test_Read_DictObj_Method(1e4)
ConsoleWrite("O          " & @TAB & "Single Byte Read Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @CRLF)

ConsoleWrite(@CRLF)

ConsoleWrite("Single Byte Test Start __________________________________________" & @CRLF)
ConsoleWrite("Writing and Reading to and from all 1e4 Storages" & @CRLF & @CRLF)


$nTime = _Test_Write_Assign_Method("1", 1e4)
ConsoleWrite("G          " & @TAB & "Single Byte Write Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @TAB & "(Faster once variables already exist)" & @CRLF)

$nTime = _Test_Read_Assign_Method(1e4)
ConsoleWrite("G          " & @TAB & "Single Byte Read Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @CRLF)
_storageG_TidyGroupVars(123)

ConsoleWrite(@CRLF)

$nTime = _Test_Write_Gi_Method("1", 1e4)
ConsoleWrite("Gi          " & @TAB & "Single Byte Write Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @TAB & "(Faster once variables already exist)" & @CRLF)

$nTime = _Test_Read_Gi_Method(1e4)
ConsoleWrite("Gi          " & @TAB & "Single Byte Read Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @CRLF)
_storageGi_TidyGroupVars(123)

ConsoleWrite(@CRLF)

$nTime = _Test_Write_Gx_Method("1", 1e4)
ConsoleWrite("Gx         " & @TAB & "Single Byte Write Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @CRLF)

$nTime = _Test_Read_Gx_Method(1e4)
ConsoleWrite("Gx         " & @TAB & "Single Byte Read Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @CRLF)

ConsoleWrite(@CRLF)

$nTime = _Test_Write_GO_Method("1", 1e4)
ConsoleWrite("GO         " & @TAB & "Single Byte Write Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @TAB & "(Faster once variables already exist)" & @CRLF)

$nTime = _Test_Read_GO_Method(1e4)
ConsoleWrite("GO         " & @TAB & "Single Byte Read Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @CRLF)
_storageGO_TidyGroupVars(123)

ConsoleWrite(@CRLF)

$nTime = _Test_Write_AO_Method("1", 1e4)
ConsoleWrite("AO         " & @TAB & "Single Byte Write Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @TAB & "(Faster once variables already exist)" & @CRLF)

$nTime = _Test_Read_AO_Method(1e4)
ConsoleWrite("AO         " & @TAB & "Single Byte Read Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @CRLF)
_storageAO_TidyGroupVars(123)

ConsoleWrite(@CRLF)

$nTime = _Test_Write_GM_Method("1", 1e4)
ConsoleWrite("GM         " & @TAB & "Single Byte Write Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @TAB & "(Faster once variables already exist)" & @CRLF)

$nTime = _Test_Read_GM_Method(1e4)
ConsoleWrite("GM         " & @TAB & "Single Byte Read Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @CRLF)
_storageGM_TidyGroupVars(123)

ConsoleWrite(@CRLF)

$nTime = _Test_Write_DictObj_Method("1", 1e4)
ConsoleWrite("O          " & @TAB & "Single Byte Write Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)"& @TAB & "(Speed keeps the same)" & @CRLF)

$nTime = _Test_Read_DictObj_Method(1e4)
ConsoleWrite("O          " & @TAB & "Single Byte Read Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @CRLF)
;~ _storageO_DestroyGroup(123)

ConsoleWrite(@CRLF)



; ===============================================================================================================================
; 10 to 100 KB test
ConsoleWrite("Kilo Byte Test Start __________________________________________" & @CRLF)
ConsoleWrite("Writing to 1e4 Storages" & @CRLF & @CRLF)

Local $nTestIterations = 1e4

For $i = 1024 * 10 To 1024 * 100 Step 1024 * 10

	$sData = _CreateDataSet($i)

	$sText = Round($i / 1024, 2) & " KB "

	$nTime = _Test_Write_Assign_Method($sData, $nTestIterations)
	ConsoleWrite("G          " & @TAB & $sText & " Write Test" & @TAB & "took: " & @extended & " ms" & @TAB & "(" & $nTime & " ms/avg)" & @CRLF)

	$nTime = _Test_Read_Assign_Method($nTestIterations)
	ConsoleWrite("G          " & @TAB & $sText & " Read Test " & @TAB & "took: " & @extended & " ms" & @TAB & "(" & $nTime & " ms/avg)" & @CRLF)
	_storageG_TidyGroupVars(123)

	ConsoleWrite(@CRLF)

	$nTime = _Test_Write_Gi_Method($sData, $nTestIterations)
	ConsoleWrite("Gi          " & @TAB & $sText & " Write Test" & @TAB & "took: " & @extended & " ms" & @TAB & "(" & $nTime & " ms/avg)" & @CRLF)

	$nTime = _Test_Read_Gi_Method($nTestIterations)
	ConsoleWrite("Gi          " & @TAB & $sText & " Read Test " & @TAB & "took: " & @extended & " ms" & @TAB & "(" & $nTime & " ms/avg)" & @CRLF)
	_storageGi_TidyGroupVars(123)

	ConsoleWrite(@CRLF)

	$nTime = _Test_Write_Gx_Method($sData, $nTestIterations)
	ConsoleWrite("Gx         " & @TAB & $sText & " Write Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @CRLF)

	$nTime = _Test_Read_Gx_Method($nTestIterations)
	ConsoleWrite("Gx         " & @TAB & $sText & " Write Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @CRLF)

	ConsoleWrite(@CRLF)

	$nTime = _Test_Write_GO_Method($sData, $nTestIterations)
	ConsoleWrite("GO         " & @TAB & $sText & " Write Test" & @TAB & "took: " & @extended & " ms" & @TAB & "(" & $nTime & " ms/avg)" & @CRLF)

	$nTime = _Test_Read_GO_Method($nTestIterations)
	ConsoleWrite("GO         " & @TAB & $sText & " Read Test " & @TAB & "took: " & @extended & " ms" & @TAB & "(" & $nTime & " ms/avg)" & @CRLF)
	_storageGO_TidyGroupVars(123)

	ConsoleWrite(@CRLF)

	$nTime = _Test_Write_AO_Method($sData, $nTestIterations)
	ConsoleWrite("AO         " & @TAB & $sText & " Write Test" & @TAB & "took: " & @extended & " ms" & @TAB & "(" & $nTime & " ms/avg)" & @CRLF)

	$nTime = _Test_Read_AO_Method($nTestIterations)
	ConsoleWrite("AO         " & @TAB & $sText & " Read Test " & @TAB & "took: " & @extended & " ms" & @TAB & "(" & $nTime & " ms/avg)" & @CRLF)
	_storageAO_TidyGroupVars(123)

	ConsoleWrite(@CRLF)

	$nTime = _Test_Write_GM_Method($sData, $nTestIterations)
	ConsoleWrite("GM         " & @TAB & $sText & " Write Test" & @TAB & "took: " & @extended & " ms" & @TAB & "(" & $nTime & " ms/avg)" & @CRLF)

	$nTime = _Test_Read_GM_Method($nTestIterations)
	ConsoleWrite("GM         " & @TAB & $sText & " Read Test " & @TAB & "took: " & @extended & " ms" & @TAB & "(" & $nTime & " ms/avg)" & @CRLF)
	_storageGM_TidyGroupVars(123)

	ConsoleWrite(@CRLF)

;~ 	_storageO_CreateGroup(123)
	$nTime = _Test_Write_DictObj_Method($sData, $nTestIterations)
	ConsoleWrite("O          " & @TAB & $sText & " Write Test" & @TAB & "took: " & @extended & " ms" & @TAB & "(" & $nTime & " ms/avg)" & @CRLF)

	$nTime = _Test_Read_DictObj_Method($nTestIterations)
	ConsoleWrite("O          " & @TAB & $sText & " Read Test " & @TAB & "took: " & @extended & " ms" & @TAB & "(" & $nTime & " ms/avg)" & @CRLF)
;~ 	_storageO_DestroyGroup(123)

	ConsoleWrite(@CRLF)

Next

; ===============================================================================================================================
; 1 to 5 MB Test
if $bDoNotRunTheMBTest Then Exit

ConsoleWrite("Mega Byte Test Start __________________________________________" & @CRLF)
ConsoleWrite("Writing to 1000 Storages" & @CRLF & @CRLF)

Local $nTestIterations = 1000

For $i = 1048576 To 1048576 * 4 Step 1048576

	$sData = _CreateDataSet($i)

	$sText = Round($i / 1048576, 2) & " MB "

	$nTime = _Test_Write_Assign_Method($sData, $nTestIterations)
	ConsoleWrite("G          " & @TAB & $sText & " Write Test" & @TAB & "took: " & @extended & " ms" & @TAB & "(" & $nTime & " ms/avg)" & @CRLF)

	$nTime = _Test_Read_Assign_Method($nTestIterations)
	ConsoleWrite("G          " & @TAB & $sText & " Read Test " & @TAB & "took: " & @extended & " ms" & @TAB & "(" & $nTime & " ms/avg)" & @CRLF)
	_storageG_TidyGroupVars(123)

	ConsoleWrite(@CRLF)

	$nTime = _Test_Write_Gi_Method($sData, $nTestIterations)
	ConsoleWrite("Gi          " & @TAB & $sText & " Write Test" & @TAB & "took: " & @extended & " ms" & @TAB & "(" & $nTime & " ms/avg)" & @CRLF)

	$nTime = _Test_Read_Gi_Method($nTestIterations)
	ConsoleWrite("Gi          " & @TAB & $sText & " Read Test " & @TAB & "took: " & @extended & " ms" & @TAB & "(" & $nTime & " ms/avg)" & @CRLF)
	_storageGi_TidyGroupVars(123)

	ConsoleWrite(@CRLF)

	$nTime = _Test_Write_Gx_Method($sData, $nTestIterations)
	ConsoleWrite("Gx         " & @TAB & $sText & " Write Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @CRLF)

	$nTime = _Test_Read_Gx_Method($nTestIterations)
	ConsoleWrite("Gx         " & @TAB & $sText & " Write Test" & @TAB & "took: " & @extended & " ms (" & $nTime & " ms/avg)" & @CRLF)

	ConsoleWrite(@CRLF)

	$nTime = _Test_Write_GO_Method($sData, $nTestIterations)
	ConsoleWrite("GO         " & @TAB & $sText & " Write Test" & @TAB & "took: " & @extended & " ms" & @TAB & "(" & $nTime & " ms/avg)" & @CRLF)

	$nTime = _Test_Read_GO_Method($nTestIterations)
	ConsoleWrite("GO         " & @TAB & $sText & " Read Test " & @TAB & "took: " & @extended & " ms" & @TAB & "(" & $nTime & " ms/avg)" & @CRLF)
	_storageGO_TidyGroupVars(123)

	ConsoleWrite(@CRLF)

	$nTime = _Test_Write_AO_Method($sData, $nTestIterations)
	ConsoleWrite("AO         " & @TAB & $sText & " Write Test" & @TAB & "took: " & @extended & " ms" & @TAB & "(" & $nTime & " ms/avg)" & @CRLF)

	$nTime = _Test_Read_AO_Method($nTestIterations)
	ConsoleWrite("AO         " & @TAB & $sText & " Read Test " & @TAB & "took: " & @extended & " ms" & @TAB & "(" & $nTime & " ms/avg)" & @CRLF)
	_storageAO_TidyGroupVars(123)

	ConsoleWrite(@CRLF)

	$nTime = _Test_Write_GM_Method($sData, $nTestIterations)
	ConsoleWrite("GM         " & @TAB & $sText & " Write Test" & @TAB & "took: " & @extended & " ms" & @TAB & "(" & $nTime & " ms/avg)" & @CRLF)

	$nTime = _Test_Read_GM_Method($nTestIterations)
	ConsoleWrite("GM         " & @TAB & $sText & " Read Test " & @TAB & "took: " & @extended & " ms" & @TAB & "(" & $nTime & " ms/avg)" & @CRLF)
	_storageGM_TidyGroupVars(123)

	ConsoleWrite(@CRLF)

	_storageO_CreateGroup(123)
	$nTime = _Test_Write_DictObj_Method($sData, $nTestIterations)
	ConsoleWrite("O          " & @TAB & $sText & " Write Test" & @TAB & "took: " & @extended & " ms" & @TAB & "(" & $nTime & " ms/avg)" & @CRLF)

	$nTime = _Test_Read_DictObj_Method($nTestIterations)
	ConsoleWrite("O          " & @TAB & $sText & " Read Test " & @TAB & "took: " & @extended & " ms" & @TAB & "(" & $nTime & " ms/avg)" & @CRLF)
	_storageO_DestroyGroup(123)

	ConsoleWrite(@CRLF)

Next






; ===============================================================================================================================
; Test functions

Func _Test_Write_Assign_Method($sData, $nTestIterations)
	Local $hTimer = 0, $nTime = 0
	$hTimer = TimerInit()
	For $i = 1 To $nTestIterations
		_storageG_Overwrite(123, $i, $sData & $i)
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
		_storageO_Overwrite(123, $i, $sData & $i)
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
		_storageGO_Overwrite(123, $i, $sData & $i)
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

Func _Test_Write_AO_Method($sData, $nTestIterations)
	Local $hTimer = 0, $nTime = 0
	$hTimer = TimerInit()
	For $i = 1 To $nTestIterations
		_storageAO_Overwrite(123, $i, $sData & $i)
	Next
	$nTime = TimerDiff($hTimer)
	Return SetExtended($nTime, $nTime / $nTestIterations)
EndFunc

Func _Test_Read_AO_Method($nTestIterations)
	Local $hTimer = 0, $nTime = 0
	$hTimer = TimerInit()
	For $i = 1 To $nTestIterations
		_storageAO_Read(123, $i)
	Next
	$nTime = TimerDiff($hTimer)
	Return SetExtended($nTime, $nTime / $nTestIterations)
EndFunc

Func _Test_Write_GM_Method($sData, $nTestIterations)
	Local $hTimer = 0, $nTime = 0
	$hTimer = TimerInit()
	For $i = 1 To $nTestIterations
		_storageGM_Overwrite(123, $i, $sData & $i)
	Next
	$nTime = TimerDiff($hTimer)
	Return SetExtended($nTime, $nTime / $nTestIterations)
EndFunc

Func _Test_Read_GM_Method($nTestIterations)
	Local $hTimer = 0, $nTime = 0
	$hTimer = TimerInit()
	For $i = 1 To $nTestIterations
		_storageGM_Read(123, $i)
	Next
	$nTime = TimerDiff($hTimer)
	Return SetExtended($nTime, $nTime / $nTestIterations)
EndFunc

Func _Test_Write_Gi_Method($sData, $nTestIterations)
	Local $hTimer = 0, $nTime = 0
	$hTimer = TimerInit()
	For $i = 1 To $nTestIterations
		_storageGi_Overwrite(123, $i, $sData & $i)
	Next
	$nTime = TimerDiff($hTimer)
	Return SetExtended($nTime, $nTime / $nTestIterations)
EndFunc

Func _Test_Read_GI_Method($nTestIterations)
	Local $hTimer = 0, $nTime = 0
	$hTimer = TimerInit()
	For $i = 1 To $nTestIterations
		_storageGi_Read(123, $i)
	Next
	$nTime = TimerDiff($hTimer)
	Return SetExtended($nTime, $nTime / $nTestIterations)
EndFunc

Func _Test_Write_Gx_Method($sData, $nTestIterations)
	Local $hTimer = 0, $nTime = 0
	$hTimer = TimerInit()
	For $i = 1 To $nTestIterations
		_storageGx_Overwrite(123, $i, $sData & $i)
	Next
	$nTime = TimerDiff($hTimer)
	Return SetExtended($nTime, $nTime / $nTestIterations)
EndFunc

Func _Test_Read_Gx_Method($nTestIterations)
	Local $hTimer = 0, $nTime = 0
	$hTimer = TimerInit()
	For $i = 1 To $nTestIterations
		_storageGx_Read(123, $i)
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