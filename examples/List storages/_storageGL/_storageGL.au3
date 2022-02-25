#NoTrayIcon
#include "..\..\..\_storageS_UDF.au3"
#include <Array.au3>


Local $sMyGroup = "MyGroup"


; this is how you add elements
_storageGL_AddElement($sMyGroup, "A Element")
_storageGL_AddElement($sMyGroup, 12)

Local $arTestArray[12]
_storageGL_AddElement($sMyGroup, $arTestArray)

Local $oTestObject = ObjCreate("Scripting.Dictionary")
_storageGL_AddElement($sMyGroup, $oTestObject)


; this is how you can check if a element in the list exists
ConsoleWrite("Does Element '12' exists?: " & _storageGL_Exists($sMyGroup, 12) & @CRLF)

; this is how you can get all elements in the lists
Local $arList = _storageGL_GetElements($sMyGroup)
_ArrayDisplay($arList, "all my elements")

; this is how you can remove a element
_storageGL_RemoveElement($sMyGroup, 12)

; this is how you can destroy the entire list
_storageGL_DestroyGroup($sMyGroup)



; the Assign/Eval list is good when it comes to create large lists and where you need to often check if a element in it exists.
; it is not good in cases where you constantly create GLists and remove them. Because this method leaks to memory.
; so its not a good choice for long runtime scripts.
