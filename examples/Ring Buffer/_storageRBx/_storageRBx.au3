#NoTrayIcon
#include "..\..\..\_storageS_UDF.au3"


; how to create a ring buffer with 1000 elements
_storageRBx_Init(1000)

; how to add elements to it
_storageRBx_Add('My First Item')
_storageRBx_Add('My Second Item')
_storageRBx_Add('My Third Item')


; how to get the elements
Local $vElementData
While True
	$vElementData = _storageRBx_Get()
	if @error Then ExitLoop

	ConsoleWrite("We got the following data: " & $vElementData & @CRLF)
WEnd

; error 2 will indicate that the ring buffer is empty