#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Version=Beta
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include "..\..\..\_storageS_UDF.au3"
#include "..\..\..\_storageS-Beta_UDF.au3"
#include <Array.au3>


Local $sMyGroup = "MyGroup"

; first we create the group
_storageOL_CreateGroup($sMyGroup)


; then we add elements to it
_storageOL_AddElement($sMyGroup, "A Element")
_storageOL_AddElement($sMyGroup, 12)

Local $arTestArray[12]
_storageOL_AddElement($sMyGroup, $arTestArray)

Local $oTestObject = ObjCreate("Scripting.Dictionary")
_storageOL_AddElement($sMyGroup, $oTestObject)



; this is how you can check if a element in the list exists
ConsoleWrite("Does Element '12' exists?: " & _storageOL_Exists($sMyGroup, 12) & @CRLF)

; this is how you can get all elements in the lists
Local $arList = _storageOL_GetElements($sMyGroup)
_ArrayDisplay($arList, "all my elements")

; this is how you can remove a elements
_storageOL_RemoveElement($sMyGroup, 12)

; this is how you can destroy the entire list
_storageOL_DestroyGroup($sMyGroup)



; the Object List method is a good allrounder. It is the fastest method to add and remove elements. It has a got Exists and GetElements speed.
; You will likely go with this one if you are not looking for a specialized method that can do something, highly required, very fast.
