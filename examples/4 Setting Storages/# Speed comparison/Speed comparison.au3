#NoTrayIcon
#include "..\..\..\_storageS_UDF.au3"

#cs
	_storageOS is generally slower then _storageMS, but that is only true as long as the group amount of _storageGM is below 1e5 (thats 10.000).

	_storageMS is based on dynamic global variables managed with a map by _storageGM, while _storageOS is based on dynamic global variables managed with a DictObj by _storageGO.
	Maps are faster then DictObjects, but only until the map reaches a certain size, then the map performance stagnates quickly.
	That is why _storageOS exists, to fit higher group amount needs.

#ce


Local $hTimer = 0, $nTime = 0, $nIterations = 1e4, $nGroupCreationIterations = 1e5
Local $sData = "test", $sData2 = "Hello"

_storageOS_CreateGroup(123)
_storageMS_CreateGroup(123)


$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageOS_Set(123, $i, $sData)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("OS Create Setting took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)

$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageMS_Set(123, $i, $sData)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("MS Create Setting took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)


ConsoleWrite(@CRLF)


$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageOS_Set(123, $i, $sData2)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("OS Setting Change took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)

$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageMS_Set(123, $i, $sData2)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("MS Setting Change took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)


ConsoleWrite(@CRLF)


$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageOS_Get(123, $i)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("OS Get Setting took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)

$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageMS_Get(123, $i)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("MS Get Setting took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)


_storageOS_DestroyGroup(123)
_storageMS_DestroyGroup(123)
ConsoleWrite(@CRLF)

$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageOS_CreateGroup($i)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("OS Creating " & $nIterations & " Groups took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)

$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageMS_CreateGroup($i)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("MS Creating " & $nIterations & " Groups took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)


ConsoleWrite(@CRLF)


$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageOS_DestroyGroup($i)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("OS Destroying " & $nIterations & " Groups took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)

$hTimer = TimerInit()
For $i = 1 To $nIterations
	_storageMS_DestroyGroup($i)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("MS Destroying " & $nIterations & " Groups took: " & $nTime & " ms (" & $nTime / $nIterations & " ms/avg)" & @CRLF)



ConsoleWrite(@CRLF)



$hTimer = TimerInit()
For $i = 1 To $nGroupCreationIterations
	_storageOS_CreateGroup($i)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("OS Creating " & $nGroupCreationIterations & " Groups took: " & $nTime & " ms (" & $nTime / $nGroupCreationIterations & " ms/avg)" & @CRLF)

$hTimer = TimerInit()
For $i = 1 To $nGroupCreationIterations
	_storageMS_CreateGroup($i)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("MS Creating " & $nGroupCreationIterations & " Groups took: " & $nTime & " ms (" & $nTime / $nGroupCreationIterations & " ms/avg)" & @CRLF)


ConsoleWrite(@CRLF)


$hTimer = TimerInit()
For $i = 1 To $nGroupCreationIterations
	_storageOS_DestroyGroup($i)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("OS Destroying " & $nGroupCreationIterations & " Groups took: " & $nTime & " ms (" & $nTime / $nGroupCreationIterations & " ms/avg)" & @CRLF)

$hTimer = TimerInit()
For $i = 1 To $nGroupCreationIterations
	_storageMS_DestroyGroup($i)
Next
$nTime = TimerDiff($hTimer)
ConsoleWrite("MS Destroying " & $nGroupCreationIterations & " Groups took: " & $nTime & " ms (" & $nTime / $nGroupCreationIterations & " ms/avg)" & @CRLF)

