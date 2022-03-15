#NoTrayIcon
#include "..\..\..\_storageS_UDF.au3"

Local $hTimer = 0, $nTime = 0, $nIterations = 1e4

_storageOL_CreateGroup(123)
_storageOLx_CreateGroup(123)
_storageML_CreateGroup(123)
_storageMLx_CreateGroup(123)
_storageAL_CreateGroup(123)



$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageOL_AddElement(123, $i)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("OL Add took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)

$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageOL_Exists(123, $i)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("OL Exists took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)

$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageOL_GetElements(123, True)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("OL Dict GetElements took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)

$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageOL_GetElements(123)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("OL Array GetElements took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)

$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageOL_RemoveElement(123, $i)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("OL Remove took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)


ConsoleWrite(@CRLF)


$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageOLx_AddElement(123, $i)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("OLx Add took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)

$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageOLx_Exists(123, $i)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("OLx Exists took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)

$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageOLx_GetElements(123)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("OLx GetElements took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)

$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageOLx_RemoveElement(123, $i)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("OLx Remove took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)

$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageOLxRapid_AddElement(123, $i)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("OLx Rapid Add took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)
_storageOLx_DestroyGroup(123)


ConsoleWrite(@CRLF)


$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageML_AddElement(123, $i)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("ML Add took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)

$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageML_Exists(123, $i)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("ML Exists took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)

$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageML_GetElements(123, True)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("ML Map GetElements took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)

$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageML_GetElements(123)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("ML Array GetElements took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)

$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageML_RemoveElement(123, $i)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("ML Remove took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)


ConsoleWrite(@CRLF)


$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageMLx_AddElement(123, $i)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("MLx Add took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)

$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageMLx_Exists(123, $i)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("MLx Exists took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)

$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageMLx_GetElements(123, True)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("MLx Map GetElements took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)

$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageMLx_GetElements(123)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("MLx Array GetElements took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)

$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageMLx_RemoveElement(123, $i)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("MLx Remove took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)

$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageMLxRapid_AddElement(123, $i)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("MLx Rapid Add took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)
_storageMLx_DestroyGroup(123)


ConsoleWrite(@CRLF)


$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageAL_AddElement(123, $i)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("AL Add took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)

$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageAL_Exists(123, $i)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("AL Exists took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)

$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageAL_GetElements(123)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("AL GetElements took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)

$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageAL_RemoveElement(123, $i)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("AL Remove took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)


ConsoleWrite(@CRLF)


$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageALR_AddElement($i)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("ALRapid Add took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)

$hTimer = TimerInit()
_storageALR_ConvertToAL(456)
$nTime = TimerDiff($hTimer)
ConsoleWrite("ALRapid to AL Conversion took: " & $nTime & " ms" & @CRLF)
_storageAL_DestroyGroup(456)


ConsoleWrite(@CRLF)


$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageGL_AddElement(123, $i)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("GL Add took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)

$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageGL_Exists(123, $i)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("GL Exists took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)

$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageGL_GetElements(123)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("GL GetElements took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)

$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageGL_RemoveElement(123, $i)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("GL Remove took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)


ConsoleWrite(@CRLF)


$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageGLx_AddElement(123, $i)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("GLx Add took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)

$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageGLx_Exists(123, $i)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("GLx Exists took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)

ConsoleWrite("GLx GetElements not available" & @CRLF)

$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageGLx_RemoveElement(123, $i)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("GLx Remove took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)


ConsoleWrite(@CRLF)


