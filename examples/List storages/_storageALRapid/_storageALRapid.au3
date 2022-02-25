#NoTrayIcon
#include "..\..\..\_storageS_UDF.au3"
#include <Array.au3>


Local $sMyGroup = "MyGroup"

; _storageALRapid is not a listing method, but function array to assist in the creation of large arrays very quickly.
; so it can not be used like any of the listing methods.


; lets create an array of size 1e6 and measure how long that takes
Local $hTimer = 0, $nTime = 0
$hTimer = TimerInit()
For $i = 1 To 1e6
	_storageALR_AddElement($i)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("ALRapid Add took: " & $nTime & " ms (" & $nTime / 1e6 & " ms/avg per element)" & @CRLF)


; to use this array with the _storageAL method we now need to convert it
$hTimer = TimerInit()
_storageALR_ConvertToAL($sMyGroup)
$nTime = TimerDiff($hTimer)
ConsoleWrite("Conversion to AL took: " & $nTime & " ms" & @CRLF)

; and destroy the ALRapid storage
_storageALR_Destroy()


; now we have a AL storage under the $sMyGroup group.

; lets check that
Local $arList = _storageAL_GetElements($sMyGroup)
ConsoleWrite($sMyGroup & " Group has: " & UBound($arList) & " elements" & @CRLF)

; lets remove that list
_storageAL_DestroyGroup($sMyGroup)

; and see how long that would have taken without ALRapid. Caution: a long long time.
_storageAL_CreateGroup($sMyGroup)

$hTimer = TimerInit()
For $i = 1 To 1e6
	_storageAL_AddElement($sMyGroup, $i)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("Regular AL Add took: " & $nTime & " ms (" & $nTime / 1e6 & " ms/avg per element)" & @CRLF)


; ALRapid is good when it comes to create large arrays at once.
; it can not be used to add elements to a existing Array List.
