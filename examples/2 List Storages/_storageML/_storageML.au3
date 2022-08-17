#NoTrayIcon
#include "..\..\..\_storageS_UDF.au3"
#include <Array.au3>


Local $sMyGroup = "MyGroup"

; first we create the group
_storageML_CreateGroup($sMyGroup)


; then we add elements to it
_storageML_AddElement($sMyGroup, "A Element")
_storageML_AddElement($sMyGroup, 12)

Local $arTestArray[12]
_storageML_AddElement($sMyGroup, $arTestArray)

Local $oTestObject = ObjCreate("Scripting.Dictionary")
_storageML_AddElement($sMyGroup, $oTestObject)



; this is how you can check if a element in the list exists
ConsoleWrite("Does Element '12' exists?: " & _storageML_Exists($sMyGroup, 12) & @CRLF)

; this is how you can get all elements in the lists
Local $arList = _storageML_GetElements($sMyGroup)
_ArrayDisplay($arList, "all my elements")

; this is how you can remove a elements
_storageML_RemoveElement($sMyGroup, 12)

; this is how you can destroy the entire list
_storageML_DestroyGroup($sMyGroup)



; the Map list method is exceptional good for checking if a element exists in a list. But it is exceptional bad for large lists.
; 1e4 items take ~90sec to add. Generally the adding and removing of elements is slow.
