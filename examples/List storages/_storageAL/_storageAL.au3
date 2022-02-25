#NoTrayIcon
#include "..\..\..\_storageS_UDF.au3"
#include <Array.au3>


Local $sMyGroup = "MyGroup"

; first we create the group
_storageAL_CreateGroup($sMyGroup)


; then we add elements to it
_storageAL_AddElement($sMyGroup, "A Element")
_storageAL_AddElement($sMyGroup, 12)

Local $arTestArray[12]
_storageAL_AddElement($sMyGroup, $arTestArray)

Local $oTestObject = ObjCreate("Scripting.Dictionary")
_storageAL_AddElement($sMyGroup, $oTestObject)



; this is how you can check if a element in the list exists
ConsoleWrite("Does Element '12' exists?: " & _storageAL_Exists($sMyGroup, 12) & @CRLF)

; this is how you can get all elements in the lists
Local $arList = _storageAL_GetElements($sMyGroup)
_ArrayDisplay($arList, "all my elements")

; this is how you can remove a elements
_storageAL_RemoveElement($sMyGroup, 12)

; this is how you can destroy the entire list
_storageAL_DestroyGroup($sMyGroup)



; the Array List method is good when you constantly need to iterate through arrays, because _storageAL_GetElements() to fetch the list
; is very fast. Or when you often want to list the elements in a GUI. When it comes to check for the existence of a element or
; when the list is constantly changing then this listing method is not your goto.
