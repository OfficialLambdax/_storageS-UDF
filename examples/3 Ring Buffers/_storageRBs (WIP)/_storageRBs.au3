#NoTrayIcon
#include "..\..\..\_storageS_UDF.au3"


; how to create a ring buffer with 1000 elements
Local $sRingName = "MyRingBuffer"
_storageRBs_CreateGroup($sRingName, 1000)

; how to add elements to it
_storageRBs_Add($sRingName, 'My First Item')
_storageRBs_Add($sRingName, 'My Second Item')
_storageRBs_Add($sRingName, 'My Third Item')


; how to get the elements
Local $vElementData
While True
	$vElementData = _storageRBs_Get($sRingName)
	if @error Then ExitLoop

	ConsoleWrite("We got the following data: " & $vElementData & @CRLF)
WEnd

; error 1 will indicate that the ring buffer is empty