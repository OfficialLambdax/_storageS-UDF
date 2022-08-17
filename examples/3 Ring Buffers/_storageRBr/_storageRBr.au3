#NoTrayIcon
#include "..\..\..\_storageS_UDF.au3"


; how to create a ring buffer with 1000 elements
Local $arMyRingBuffer = _storageRBr_CreateGroup(1000)

; how to add elements to it
_storageRBr_Add($arMyRingBuffer, 'My First Item')
_storageRBr_Add($arMyRingBuffer, 'My Second Item')
_storageRBr_Add($arMyRingBuffer, 'My Third Item')


; how to get the elements
Local $vElementData
While True
	$vElementData = _storageRBr_Get($arMyRingBuffer)
	if @error Then ExitLoop

	ConsoleWrite("We got the following data: " & $vElementData & @CRLF)
WEnd

; error 1 will indicate that the ring buffer is empty