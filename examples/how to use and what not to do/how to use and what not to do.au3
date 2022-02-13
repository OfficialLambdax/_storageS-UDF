#NoTrayIcon
#include "..\..\_storageS_UDF.au3"
#include <Array.au3>


; ===============================================================================================================================
; Assign/Eval method

Local $sGroup = 123

; how to write data
_storageG_Overwrite($sGroup, "Test_Integer", Random(1, 99, 1))
_storageG_Overwrite($sGroup, "Test_String", "Hello World")

Local $arTest[1][2] = [["hello","world"]]
_storageG_Overwrite($sGroup, "Test_Array", $arTest)


; how to read data
Local $nTestInteger = _storageG_Read($sGroup, "Test_Integer")
MsgBox(0, "", "Thats my Integer: " & $nTestInteger)

Local $sTestString = _storageG_Read($sGroup, "Test_String")
MsgBox(0, "", "Thats my String: " & $sTestString)

Local $arTestArray = _storageG_Read($sGroup, "Test_Array")
_ArrayDisplay($arTestArray, "Thats my Array")


; how to know which variables and data is stored
Local $arGetVariables = _storageG_GetGroupVars($sGroup)
_ArrayDisplay($arGetVariables, "Thats all storage Vars")


; how to clean the variables
_storageG_TidyGroupVars($sGroup)

; they are still present but overwritten with Null
Local $arGetVariables = _storageG_GetGroupVars($sGroup)
_ArrayDisplay($arGetVariables, "Thats the cleaned vars")


; what not to do
Local $bDidItWork = _storageG_Overwrite("test group", "test element", "test data")
MsgBox(0, "", "Did it work? " & $bDidItWork)

Local $bDidItWork = _storageG_Overwrite("test_group", "test_element", "test data")
MsgBox(0, "", "Did this work then? " & $bDidItWork)

; what happend? The group name and element names are part of the global variables.
; so any character that cannot be used to create a variable cannot be used.
; like "$test group" or "$test!"
; so do not use spaces or special characters. The $vElementData however be of any kind.


; ===============================================================================================================================
; Dictionary Object method

Local $sGroup = 123

; first create the group
_storageO_CreateGroup($sGroup)

; how to write data
_storageO_Overwrite($sGroup, "Test_Integer", Random(1, 99, 1))
_storageO_Overwrite($sGroup, "Test_String", "Hello World")

Local $arTest[1][2] = [["Hello", "World"]]
_storageO_Overwrite($sGroup, "Test_Array", $arTest)


; how to read data
Local $nTestInteger = _storageO_Read($sGroup, "Test_Integer")
MsgBox(0, "", "Thats my Integer: " & $nTestInteger)

Local $sTestString = _storageO_Read($sGroup, "Test_String")
MsgBox(0, "", "Thats my String: " & $sTestString)

Local $arTestArray = _storageO_Read($sGroup, "Test_Array")
_ArrayDisplay($arTestArray, "Thats my Array")

; how to know which variables and data is stored
Local $arGetVariables = _storageO_GetGroupVars($sGroup)
_ArrayDisplay($arGetVariables, "Thats all storage Vars")

; how to clean the variables
_storageO_TidyGroupVars($sGroup)

; they are no longer present
Local $arGetVariables = _storageO_GetGroupVars($sGroup)
MsgBox(0, "", "Are there Storage Variables Left? " & IsArray($arGetVariables))


; ===============================================================================================================================
; The Assign/Eval Method is not compatible with the DictObj method and vise versa


; write data with the Assign/Eval Method
_storageG_Overwrite(123, "Test_Var", "123456")

; try to read it with the DictObj method
Local $sTestString = _storageO_Read(123, "Test_Var")

; display the result
MsgBox(0, "", "What did we read? " & $sTestString & " | Error: " & @error)
