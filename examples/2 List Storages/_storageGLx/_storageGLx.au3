#NoTrayIcon
#include "..\..\..\_storageS_UDF.au3"
#include <Array.au3>


Local $sMyGroup = "MyGroup"


; this is how you add elements
_storageGLx_AddElement($sMyGroup, "A Element")
_storageGLx_AddElement($sMyGroup, 12)

Local $arTestArray[12]
_storageGLx_AddElement($sMyGroup, $arTestArray)

Local $oTestObject = ObjCreate("Scripting.Dictionary")
_storageGLx_AddElement($sMyGroup, $oTestObject)


; this is how you can check if a element in the list exists
ConsoleWrite("Does Element '12' exists?: " & _storageGLx_Exists($sMyGroup, 12) & @CRLF)

; this is how you can get all elements in the lists.
; well you cant. GLx doesnt keep track of the list contents.

; this is how you can remove a element
_storageGLx_RemoveElement($sMyGroup, 12)

; this is how you can destroy the entire list
; you cant. GLx doesnt know its contents.



; the Assign/Eval X list is made for a single purpose. For exceptional large lists where it is required to often check if a
; element in it exists. The Size of the list doesnt matter for the speed of this method. So you could have a list as big
; as your Memory and the GLx method would still be as fast as if the list had zero elements.
