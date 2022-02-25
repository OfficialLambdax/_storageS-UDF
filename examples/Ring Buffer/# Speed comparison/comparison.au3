#NoTrayIcon
#include "..\..\..\_storageS_UDF.au3"


Local $hTimer = 0, $nTime = 0, $nRingSize = 1e4


; create Ring buffers
_storageRBs_CreateGroup(123, $nRingSize)
_storageRBx_Init($nRingSize)
Local $arRingBuffer = _storageRBr_CreateGroup(123)


; RB add all elements
$hTimer = TimerInit()
For $i = 1 To $nRingSize
	_storageRBs_Add(123, $i)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("RBs Add took: " & $nTime & " ms (" & $nTime / $nRingSize & " ms/avg)" & @CRLF)

; RB read elements
$hTimer = TimerInit()
For $i = 1 To $nRingSize
	_storageRBs_Get(123)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("RBs Get took: " & $nTime & " ms (" & $nTime / $nRingSize & " ms/avg)" & @CRLF)


ConsoleWrite(@CRLF)


; RBx add
$hTimer = TimerInit()
For $i = 1 To $nRingSize
	_storageRBx_Add($i)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("RBx Add took: " & $nTime & " ms (" & $nTime / $nRingSize & " ms/avg)" & @CRLF)

; RBx read
$hTimer = TimerInit()
For $i = 1 To $nRingSize
	_storageRBx_Get()
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("RBx Get took: " & $nTime & " ms (" & $nTime / $nRingSize & " ms/avg)" & @CRLF)


ConsoleWrite(@CRLF)


; RBr add
$hTimer = TimerInit()
For $i = 1 To $nRingSize
	_storageRBr_Add($arRingBuffer, $i)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("RBr Add took: " & $nTime & " ms (" & $nTime / $nRingSize & " ms/avg)" & @CRLF)

; RBr read
$hTimer = TimerInit()
For $i = 1 To $nRingSize
	_storageRBr_Get($arRingBuffer)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("RBr Get took: " & $nTime & " ms (" & $nTime / $nRingSize & " ms/avg)" & @CRLF)

