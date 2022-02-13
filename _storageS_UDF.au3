
Global $__storageS_sVersion = "0.1"
Global $__storageS_oDictionaries = ObjCreate("Scripting.Dictionary")


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageG_Overwrite
; Description ...: Writes data to the Elementname of the Element group
; Syntax ........: _storageS_Overwrite($vElementGroup, $sElementName, $vElementData)
; Parameters ....: $vElementGroup           - Element Group
;                  $sElementName            - (String) Element Name
;                  $vElementData            - (Variable) Element Data
; Return values .: True						= If success
;                : False					= If not
; Modified ......:
; Remarks .......: If $vElementData is == False then the Variable is not declared because _storageS_Read() would
;                : return False then anyway. This is done to prevent the declaration of to many global variables.
; Example .......: _storageG_Overwrite(123, 'testdata', "hello world")
; ===============================================================================================================================
Func _storageG_Overwrite($vElementGroup, $sElementName, $vElementData)
    Local $sVarName = "__storageS_" & $vElementGroup & $sElementName

    ; we wont declare vars if $vElementData is False because _storageS_Read() always returns False and @error 1 on undeclared vars
    If $vElementData == False And Not IsDeclared($sVarName) Then Return True
    If Not IsDeclared($sVarName) Then __storageG_AddGroupVar($vElementGroup, $sElementName)

    Return Assign($sVarName, $vElementData, 2)
EndFunc   ;==>_storageS_Overwrite


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageG_Append
; Description ...: Appends data
; Syntax ........: _storageS_Append($vElementGroup, $sElementName, $vElementData)
; Parameters ....: $vElementGroup           - Element Group
;                  $sElementName            - (String) Element Name
;                  $vElementData            - (Variable) Element Data
; Return values .: True						= If success
;                : False					= If not
; Modified ......:
; Remarks .......:
; Example .......: _storageG_Append(123, 'testdata', "hello world again")
; ===============================================================================================================================
Func _storageG_Append($vElementGroup, $sElementName, $vElementData)
    Local $sVarName = "__storageS_" & $vElementGroup & $sElementName

    If Not IsDeclared($sVarName) Then Return _storageG_Overwrite($vElementGroup, $sElementName, $vElementData)

    Return Assign($sVarName, Eval($sVarName) & $vElementData, 2)
EndFunc   ;==>_storageS_Append


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageG_Read
; Description ...: Returns the data for the element name of the element group
; Syntax ........: _storageS_Read($vElementGroup, $sElementName)
; Parameters ....: $vElementGroup           - Element Group
;                  $sElementName            - (String) Element Name
; Return values .: The data					= If success
; Errors ........: 1						- If the variable isnt present.
; Modified ......:
; Remarks .......: If _storageS_Overwrite() was called with data that was Bool False then the variable wasnt declared.
; Example .......: _storageG_Read(123, 'testdata')
; ===============================================================================================================================
Func _storageG_Read($vElementGroup, $sElementName)
    Local $sVarName = "__storageS_" & $vElementGroup & $sElementName

    If Not IsDeclared($sVarName) Then Return SetError(1, 0, False)
    Return Eval($sVarName)
EndFunc   ;==>_storageS_Read


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageG_TidyGroupVars
; Description ...: Tidies all Variables of the given element group
; Syntax ........: _storageS_TidyGroupVars($vElementGroup)
; Parameters ....: $vElementGroup           - Element Group
; Return values .: None
; Modified ......:
; Remarks .......: The global variables keep existent, but they are overwritten with Null.
;                : Because there is no way to delete Global variables.
; Example .......: _storageG_TidyGroupVars(123)
; ===============================================================================================================================
Func _storageG_TidyGroupVars($vElementGroup)
    Local $oGroupVars = Eval("StorageS" & $vElementGroup)
    If Not IsObj($oGroupVars) Then Return

	Local $sVarName = "__storageS_" & $vElementGroup

	For $i In $oGroupVars
		Assign($sVarName & $i, Null, 2)
;~ 		$oGroupVars.Remove($i)
	Next

;~ 	Assign("StorageS" & $vElementGroup, Null, 2)
EndFunc   ;==>_storageS_TidyGroupVars


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageG_GetGroupVars
; Description ...: Returns a 2D array of size [n][3] containing the elements stored for the Element group
; Syntax ........: _storageG_GetGroupVars($vElementGroup)
; Parameters ....: $vElementGroup           - Element Group
; Return values .: 2D array					= If success
;                : False					= If not
; Modified ......:
; Remarks .......: Array looks like this
;                : [n][0]					= Element name
;                : [n][1]					= Element Variable Type
;                : [n][2]					= Element Variable Data
; Example .......: _storageG_GetGroupVars(123)
; ===============================================================================================================================
Func _storageG_GetGroupVars($vElementGroup)

	Local $oElementGroup = Eval("StorageS" & $vElementGroup)
	If Not IsObj($oElementGroup) Then Return False

	$vElementGroup = '__storageS_' & $vElementGroup

	Local $arGroupVars2D[$oElementGroup.Count][3], $nCount = 0
	For $i In $oElementGroup
		$arGroupVars2D[$nCount][0] = $i
		$arGroupVars2D[$nCount][1] = VarGetType(Eval($vElementGroup & $i))
		$arGroupVars2D[$nCount][2] = Eval($vElementGroup & $i)
		$nCount += 1
	Next

	Return $arGroupVars2D
EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageO_CreateGroup
; Description ...: Initializes a Storage for the Object variant. Needs to be called for each Element Group
; Syntax ........: _storageO_CreateGroup($vElementGroup)
; Parameters ....: $vElementGroup           - Element Group
; Return values .: True						= If success
;                : False					= If not
; Modified ......:
; Remarks .......:
; Example .......: _storageO_CreateGroup(123)
; ===============================================================================================================================
Func _storageO_CreateGroup($vElementGroup)
	$vElementGroup = '_storageS_' & $vElementGroup

	Local $oElementGroup = ObjCreate("Scripting.Dictionary")
	If @error Then Return False
	$__storageS_oDictionaries($vElementGroup) = $oElementGroup

	Return True
EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageO_Overwrite
; Description ...: Writes data to the Elementname of the Element group
; Syntax ........: _storageO_Overwrite($vElementGroup, $sElementName, $vElementData)
; Parameters ....: $vElementGroup           - Element Group
;                  $sElementName            - (String) Element Name
;                  $vElementData            - (Variable) Element Data
; Return values .: True						= If success
;                : False					= If not
; Errors ........: 1						- The Element group Object doesnt exist.
;                : 2						- The Element group Object is not a Object (Storage is not known).
; Modified ......:
; Remarks .......:
; Example .......: No
; ===============================================================================================================================
Func _storageO_Overwrite($vElementGroup, $sElementName, $vElementData)
	$vElementGroup = '_storageS_' & $vElementGroup

	If Not $__storageS_oDictionaries.Exists($vElementGroup) Then Return SetError(1, 0, False)

	Local $oElementGroup = $__storageS_oDictionaries($vElementGroup)
	if Not IsObj($oElementGroup) Then Return SetError(2, 0, False)

	$oElementGroup($sElementName) = $vElementData
	Return True
EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageO_Append
; Description ...: Appends data
; Syntax ........: _storageO_Append($vElementGroup, $sElementName, $vElementData)
; Parameters ....: $vElementGroup           - Element Group
;                  $sElementName            - (String) Element Name
;                  $vElementData            - (Variable) Element Data
; Return values .: True						= If success
;                : False					= If not
; Modified ......:
; Remarks .......:
; Example .......: _storageO_Append(123, 'testdata', "hello world again")
; ===============================================================================================================================
Func _storageO_Append($vElementGroup, $sElementName, $vElementData)
	$vElementGroup = '_storageS_' & $vElementGroup

	Local $oElementGroup = $__storageS_oDictionaries($vElementGroup)
	if Not IsObj($oElementGroup) Then Return _storageO_Overwrite($vElementGroup, $sElementName, $vElementData)

	$oElementGroup($sElementName) &= $vElementData
	Return True
EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageO_Read
; Description ...: Returns the data for the element name of the element group
; Syntax ........: _storageO_Read($vElementGroup, $sElementName)
; Parameters ....: $vElementGroup           - Element Group
;                  $sElementName            - (String) Element Name
; Return values .: The data					= If success
; Errors ........: 1						- The Element group Object is not a Object (Storage is known).
;                : 2						- If the Element name isnt present.
; Modified ......:
; Remarks .......:
; Example .......: _storageO_Read(123, 'testdata')
; ===============================================================================================================================
Func _storageO_Read($vElementGroup, $sElementName)
	$vElementGroup = '_storageS_' & $vElementGroup

	Local $oElementGroup = $__storageS_oDictionaries($vElementGroup)
	if Not IsObj($oElementGroup) Then Return SetError(1, 0, False)

	If Not $oElementGroup.Exists($sElementName) Then Return SetError(2, 0, False)

	Return $oElementGroup($sElementName)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageO_TidyGroupVars
; Description ...: Tidies all Variables of the given element group
; Syntax ........: _storageO_TidyGroupVars($vElementGroup)
; Parameters ....: $vElementGroup           - Element Group
; Return values .: None
; Modified ......:
; Remarks .......:
; Example .......: _storageO_TidyGroupVars(123)
; ===============================================================================================================================
Func _storageO_TidyGroupVars($vElementGroup)
	$vElementGroup = '_storageS_' & $vElementGroup

	Local $oElementGroup = $__storageS_oDictionaries($vElementGroup)

	For $i In $oElementGroup
		$oElementGroup.Remove($i)
	Next

	$__storageS_oDictionaries.Remove($vElementGroup)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageO_GetGroupVars
; Description ...: Returns a 2D array of size [n][3] containing the elements stored for the Element group
; Syntax ........: _storageO_GetGroupVars($vElementGroup)
; Parameters ....: $vElementGroup           - Element Group
; Return values .: 2D array					= If success
;                : False					= If not
; Modified ......:
; Remarks .......: Array looks like this
;                : [n][0]					= Element name
;                : [n][1]					= Element Variable Type
;                : [n][2]					= Element Variable Data
; Example .......: _storageO_GetGroupVars(123)
; ===============================================================================================================================
Func _storageO_GetGroupVars($vElementGroup)
	$vElementGroup = '_storageS_' & $vElementGroup

	Local $oElementGroup = $__storageS_oDictionaries($vElementGroup)
	If Not IsObj($oElementGroup) Then Return False

	Local $arGroupVars2D[$oElementGroup.Count][3], $nCount = 0
	For $i In $oElementGroup
		$arGroupVars2D[$nCount][0] = $i
		$arGroupVars2D[$nCount][1] = VarGetType($oElementGroup($i))
		$arGroupVars2D[$nCount][2] = $oElementGroup($i)
		$nCount += 1
	Next

	Return $arGroupVars2D
EndFunc


; internal
Func __storageG_AddGroupVar($vElementGroup, $sElementName)
	Local $oGroupVars = Eval("StorageS" & $vElementGroup)
	If Not IsObj($oGroupVars) Then
		$oGroupVars = ObjCreate("Scripting.Dictionary")
	EndIf

	$oGroupVars($sElementName)
	Assign("StorageS" & $vElementGroup, $oGroupVars, 2)
EndFunc
