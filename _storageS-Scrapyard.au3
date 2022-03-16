#include <_storageS_UDF.au3>

#cs

	Methods that got removed from the main UDF, duo to inefficiency or because they are outdated
	get put here.

#ce

#Region _storageGL		Assign/Eval List
; ===============================================================================================================================
; ===============================================================================================================================
#cs
	_storageGL describtion

	Works on top of _storageG. Has the same drawbacks. Aka it leaks every remove element to memory.
	Very fast element adds, removes and exists checks.

	There is usually no gain from using this method with its drawbacks. Which is why it is likely going to be removed.
#ce
; #FUNCTION# ====================================================================================================================
; Name ..........: _storageGL_AddElement
; Description ...: Adds an Element to the List
; Syntax ........: _storageGL_AddElement($vElementGroup, $sElementName)
; Parameters ....: $vElementGroup       - a variant value.
;                  $sElementName        - a string value.
; Return values .: True
; Modified ......:
; Remarks .......:
; Example .......: No
; ===============================================================================================================================
Func _storageGL_AddElement($vElementGroup, $sElementName)
	Return _storageG_Overwrite($vElementGroup, StringToBinary($sElementName), True)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageGL_GetElements
; Description ...: Returns all Elements of the List
; Syntax ........: _storageGL_GetElements($vElementGroup)
; Parameters ....: $vElementGroup       - a variant value.
; Return values .: None
; Modified ......:
; Remarks .......:
; Example .......: No
; ===============================================================================================================================
Func _storageGL_GetElements($vElementGroup)
	Local $oElementGroup = Eval("StorageS" & $vElementGroup)
	If Not IsObj($oElementGroup) Then Return False

	$vElementGroup = '__storageS_' & $vElementGroup

	Local $arGroupVars2D[$oElementGroup.Count], $nCount = 0
	For $i In $oElementGroup
		$arGroupVars2D[$nCount] = BinaryToString($i)
		$nCount += 1
	Next

	Return $arGroupVars2D
EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageGL_Exists
; Description ...: Checks if an element exists in the list
; Syntax ........: _storageGL_Exists($vElementGroup, $sElementName)
; Parameters ....: $vElementGroup       - a variant value.
;                  $sElementName        - a string value.
; Return values .: None
; Modified ......:
; Remarks .......:
; Example .......: No
; ===============================================================================================================================
Func _storageGL_Exists($vElementGroup, $sElementName)
	Return _storageG_Read($vElementGroup, StringToBinary($sElementName))
EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageGL_RemoveElement
; Description ...: Removes an element from the list
; Syntax ........: _storageGL_RemoveElement($vElementGroup, $sElementName)
; Parameters ....: $vElementGroup       - a variant value.
;                  $sElementName        - a string value.
; Return values .: None
; Modified ......:
; Remarks .......: Leaks to memory
; Example .......: No
; ===============================================================================================================================
Func _storageGL_RemoveElement($vElementGroup, $sElementName)
	Return _storageG_Overwrite($vElementGroup, StringToBinary($sElementName), False)
EndFunc


Func _storageGL_TidyGroupVars($vElementGroup)
	Return _storageG_TidyGroupVars($vElementGroup)
EndFunc


Func _storageGL_DestroyGroup($vElementGroup)
	Return _storageG_DestroyGroup($vElementGroup)
EndFunc
#EndRegion
