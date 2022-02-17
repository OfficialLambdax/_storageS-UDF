;~ #include <Array.au3>

Global $__storageS_sVersion = "0.1.2.3"
Global $__storageS_oDictionaries = ObjCreate("Scripting.Dictionary")
Global $__storageS_GO_PosObject = ObjCreate("Scripting.Dictionary")
Global $__storageS_GO_IndexObject = ObjCreate("Scripting.Dictionary")
Global $__storageS_GO_Size = 0

__storageGO_Startup()


#Region Assign / Eval Method
; ===============================================================================================================================
; ===============================================================================================================================
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
;                : return False then anyway. This is done to prevent the declaration of unnecessary global variables.
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
; Description ...: Appends data to the Elementname of the Element group
; Syntax ........: _storageS_Append($vElementGroup, $sElementName, $vElementData)
; Parameters ....: $vElementGroup           - Element Group
;                  $sElementName            - (String) Element Name
;                  $vElementData            - (Variable) Element Data
; Return values .: True						= If success
;                : False					= If not
; Modified ......:
; Remarks .......: Append as in "Hello " & "World" = "Hello World"
; Example .......: _storageG_Append(123, 'testdata', "hello world again")
; ===============================================================================================================================
Func _storageG_Append($vElementGroup, $sElementName, $vElementData)
    Local $sVarName = "__storageS_" & $vElementGroup & $sElementName

    If Not IsDeclared($sVarName) Then Return _storageG_Overwrite($vElementGroup, $sElementName, $vElementData)

    Return Assign($sVarName, Eval($sVarName) & $vElementData, 2)
EndFunc   ;==>_storageS_Append


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageG_Calc
; Description ...: X operator Y. Where X is what is already stored and Y the $vElementData
; Syntax ........: _storageG_Calc($vElementGroup, $sElementName, $vElementData, $Operator)
; Parameters ....: $vElementGroup       - Element Group
;                  $sElementName        - (String) Element Name
;                  $vElementData        - (Variable) Element Data aka Y
;                  $Operator            - (String) + - * / ^ etc.
;                  $bSwitch             - True / False. Switches X with Y if True.
;                  $bSave				- True / False. If True will store the result.
; Return values .: The Result of the Operation
;                : ""					= if the operation failed
;                : False				= If the Element is unknown
; Modified ......:
; Remarks .......:
; Example .......: _storageG_Overwrite(123, 'testinteger', 1)
;                : _storageG_Calc(123, 'testinteger', 2, '+')
; ===============================================================================================================================
Func _storageG_Calc($vElementGroup, $sElementName, $vElementData, $Operator, $bSwitch = False, $bSave = True)
	Local $sVarName = "__storageS_" & $vElementGroup & $sElementName

;~ 	If Not IsDeclared($sVarName) Then Return _storageG_Overwrite($vElementGroup, $sElementName, $vElementData)
	If Not IsDeclared($sVarName) Then Return False

	if $bSwitch Then
		Local $vCalc = Execute("$vElementData" & $Operator & Eval($sVarName))
	Else
		Local $vCalc = Execute(Eval($sVarName) & $Operator & "$vElementData")
	EndIf

	If $bSave Then Assign($sVarName, $vCalc, 2)
	Return $vCalc
EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageG_Math
; Description ...: Like Cosinos the stored element. Also works with other Functions.
; Syntax ........: _storageG_Math($vElementGroup, $sElementName, $Math)
; Parameters ....: $vElementGroup       - Element Group
;                  $sElementName        - (String) Element Name
;                  $Math                - (String) Cos Sin Mod Log Exp etc.
;                  $bSave				- True / False. If True will store the result.
; Return values .: The Result of the Operation
;                : ""					= if the operation failed
;                : False				= If the Element is unknown
; Modified ......:
; Remarks .......: Functions like Ceiling() or Floor() also work just like your own Functions.
; Example .......: _storageG_Overwrite(123, 'testinteger', 3)
;                : _storageG_Math(123, 'testinteger, "Cos")
;                : Or _storageG_Math(123, 'testinteger, "_MyMathFunc")
; ===============================================================================================================================
Func _storageG_Math($vElementGroup, $sElementName, $Math, $bSave = True)
	Local $sVarName = "__storageS_" & $vElementGroup & $sElementName

	If Not IsDeclared($sVarName) Then Return False

	Local $vCalc = Execute($Math & "(" & Eval($sVarName) & ")")

	If $bSave Then Assign($sVarName, $vCalc)
	Return $vCalc
EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageG_Read
; Description ...: Returns the data for the element name of the element group
; Syntax ........: _storageS_Read($vElementGroup, $sElementName)
; Parameters ....: $vElementGroup           - Element Group
;                  $sElementName            - (String) Element Name
; Return values .: The data					= If success
; Errors ........: 1						- If the variable isnt present.
; Modified ......:
; Remarks .......: If _storageG_Overwrite() was called with data that was Bool False then the variable wasnt declared.
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
	Next
EndFunc   ;==>_storageS_TidyGroupVars


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageG_DestroyGroup
; Description ...: Tidies the Group variables and then Destroys the Group Object
; Syntax ........: _storageG_DestroyGroup($vElementGroup)
; Parameters ....: $vElementGroup       - a variant value.
; Return values .: None
; Modified ......:
; Remarks .......: The Variables stay declared, but if they are to be never used again then you can also
;                : destroy the Object that they are stored in to free the ram.
;                : If you do however use them again then they will not be readded because only undeclared variables are added.
;                : Using IsDeclared() is simply much faster then using Eval().
; Example .......: No
; ===============================================================================================================================
Func _storageG_DestroyGroup($vElementGroup)

	_storageG_TidyGroupVars($vElementGroup)
	Assign("StorageS" & $vElementGroup, Null, 2)

EndFunc


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
#EndRegion




#Region Reuse Assign / Eval Method
; ===============================================================================================================================
; ===============================================================================================================================
; #FUNCTION# ====================================================================================================================
; Name ..........: _storageGO_Overwrite
; Description ...: Writes data to the Elementname of the Element group
; Syntax ........: _storageGO_Overwrite($vElementGroup, $sElementName, $vElementData)
; Parameters ....: $vElementGroup           - Element Group
;                  $sElementName            - (String) Element Name
;                  $vElementData            - (Variable) Element Data
; Return values .: True						= If success
;                : False					= If not
; Modified ......:
; Remarks .......:
; Example .......: No
; ===============================================================================================================================
Func _storageGO_Overwrite($vElementGroup, $sElementName, $vElementData)

	Local $sVarName = '__storageGO_' & $vElementGroup & $sElementName

	Local $nPos = $__storageS_GO_PosObject($sVarName)

	If $nPos == "" Then

		__storageGO_AddGroupVar($vElementGroup, $sElementName)

		; if not free storage if available then create a new storage
		If $__storageS_GO_IndexObject.Count == 0 Then

			Local $nPos = $__storageS_GO_Size + 1

			; claim it
			$__storageS_GO_PosObject($sVarName) = $nPos

			; increase size
			$__storageS_GO_Size += 1

			; assign and return
			Return Assign('__storageGO_' & $nPos, $vElementData, 2)

		Else ; pick a free storage

			; eh, how do i pick the first element in a dictobj
			For $i In $__storageS_GO_IndexObject
				Local $nPos = $i
				ExitLoop
			Next

			; claim it
			$__storageS_GO_IndexObject.Remove($nPos)
			$__storageS_GO_PosObject($sVarName) = $nPos

			; assign data and return
			Return Assign('__storageGO_' & $nPos, $vElementData, 2)

		EndIf



	Else

		Return Assign('__storageGO_' & $nPos, $vElementData, 2)

	EndIf

EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageGO_Append
; Description ...: Appends data to the Elementname of the Element group
; Syntax ........: _storageGO_Append($vElementGroup, $sElementName, $vElementData)
; Parameters ....: $vElementGroup           - Element Group
;                  $sElementName            - (String) Element Name
;                  $vElementData            - (Variable) Element Data
; Return values .: True						= If success
;                : False					= If not
; Modified ......:
; Remarks .......: Append as in "Hello " & "World" = "Hello World"
; Example .......: _storageGO_Overwrite(123, 'testdata', "Hello ")
;                : _storageGO_Append(123, 'testdata', "World")
; ===============================================================================================================================
Func _storageGO_Append($vElementGroup, $sElementName, $vElementData)

	Local $sVarName = '__storageGO_' & $vElementGroup & $sElementName

	Local $nPos = $__storageS_GO_PosObject($sVarName)

	If $nPos == "" Then Return _storageGO_Overwrite($vElementGroup, $sElementName, $vElementData)

	Return Assign('__storageGO_' & $nPos, Eval('__storageGO_' & $nPos) & $vElementData, 2)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageGO_Read
; Description ...: Returns the data for the element name of the element group
; Syntax ........: _storageGO_Read($vElementGroup, $sElementName)
; Parameters ....: $vElementGroup           - Element Group
;                  $sElementName            - (String) Element Name
; Return values .: The data					= If success
; Errors ........: 1						- If the variable isnt present.
; Modified ......:
; Remarks .......:
; Example .......: No
; ===============================================================================================================================
Func _storageGO_Read($vElementGroup, $sElementName)

	Local $sVarName = '__storageGO_' & $vElementGroup & $sElementName

	; check if the storage exists
	Local $nPos = $__storageS_GO_PosObject($sVarName)

	If $nPos == Null Then Return SetError(1, 0, False)

	Return Eval('__storageGO_' & $nPos)

EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageGO_GetGroupVars
; Description ...: Returns a 2D array of size [n][3] containing the elements stored for the Element group
; Syntax ........: _storageGO_GetGroupVars($vElementGroup)
; Parameters ....: $vElementGroup           - Element Group
; Return values .: 2D array					= If success
;                : False					= If not
; Modified ......:
; Remarks .......: Array looks like this
;                : [n][0]					= Element name
;                : [n][1]					= Element Variable Type
;                : [n][2]					= Element Variable Data
; Example .......: _storageGO_GetGroupVars(123)
; ===============================================================================================================================
Func _storageGO_GetGroupVars($vElementGroup)

	$vElementGroup = '__storageGO_' & $vElementGroup

	Local $oElementGroup = Eval('Group' & $vElementGroup)
	If Not IsObj($oElementGroup) Then Return False

	Local $arGroupVars2D[$oElementGroup.Count][3], $nCount = 0, $nPos = 0
	For $i In $oElementGroup
		$arGroupVars2D[$nCount][0] = $i

		$nPos = $__storageS_GO_PosObject($vElementGroup & $i)

		$arGroupVars2D[$nCount][1] = VarGetType(Eval('__storageGO_' & $nPos))
		$arGroupVars2D[$nCount][2] = Eval('__storageGO_' & $nPos)

		$nCount += 1
	Next

	Return $arGroupVars2D

EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageGO_TidyGroupVars
; Description ...: Tidies all storages of the given group
; Syntax ........: _storageGO_TidyGroupVars($vElementGroup)
; Parameters ....: $vElementGroup       - Element Group
; Return values .: None
; Modified ......:
; Remarks .......:
; Example .......: No
; ===============================================================================================================================
Func _storageGO_TidyGroupVars($vElementGroup)

	$vElementGroup = '__storageGO_' & $vElementGroup

	Local $oElementGroup = Eval('Group' & $vElementGroup)
	If Not IsObj($oElementGroup) Then Return False

	Local $nPos = 0
	For $i In $oElementGroup

		$nPos = $__storageS_GO_PosObject($vElementGroup & $i)

		Assign('__storageGO_' & $nPos, Null, 2)
	Next

EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageGO_DestroyGroup
; Description ...: Tidies and Frees all storages of the given group
; Syntax ........: _storageGO_DestroyGroup($vElementGroup)
; Parameters ....: $vElementGroup       - Element Group
; Return values .: None
; Modified ......:
; Remarks .......:
; Example .......: No
; ===============================================================================================================================
Func _storageGO_DestroyGroup($vElementGroup)

	$vElementGroup = '__storageGO_' & $vElementGroup

	Local $oElementGroup = Eval('Group' & $vElementGroup)
	If Not IsObj($oElementGroup) Then Return False


	Local $nPos = 0
	For $i In $oElementGroup

		; get pos
		$nPos = $__storageS_GO_PosObject($vElementGroup & $i)

		; tidy storage
		Assign('__storageGO_' & $nPos, Null, 2)

		; free storage
		$__storageS_GO_IndexObject($nPos) = Null

		; remove element from group
		$oElementGroup.Remove($i)

		; remove element from pos object
		$__storageS_GO_PosObject.Remove($vElementGroup & $i)
	Next

	; remove group
	Assign('Group' & $vElementGroup, Null, 2)

	; save changes

EndFunc
#EndRegion

#Region DictObj method
; ===============================================================================================================================
; ===============================================================================================================================
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
;~ 	$__storageS_oDictionaries.Add($vElementGroup, $oElementGroup)

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
;~ 	If Not $__storageS_oDictionaries.Exists($vElementGroup) Then _storageO_CreateGroup($vElementGroup) ; doesnt work ? Object keeps inaccessible

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
; Name ..........: _storageO_Calc
; Description ...: X operator Y. Where X is what is already stored and Y the $vElementData
; Syntax ........: _storageO_Calc($vElementGroup, $sElementName, $vElementData, $Operator)
; Parameters ....: $vElementGroup       - Element Group
;                  $sElementName        - (String) Element Name
;                  $vElementData        - (Variable) Element Data aka Y
;                  $Operator            - (String) + - * / ^ etc.
; Return values .: The Result of the Operation
;                : Or "" if the operation failed
; Modified ......:
; Remarks .......: Beaware that the result of the operation is also stored.
; Example .......: _storageO_Overwrite(123, 'testinteger', 1)
;                : _storageO_Calc(123, 'testinteger', 2, '+')
; ===============================================================================================================================
Func _storageO_Calc($vElementGroup, $sElementName, $vElementData, $Operator)
	; ~ todo
EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageO_Math
; Description ...: Like Cosinos the stored element. Also works with other Functions.
; Syntax ........: _storageO_Math($vElementGroup, $sElementName, $Math)
; Parameters ....: $vElementGroup       - Element Group
;                  $sElementName        - (String) Element Name
;                  $Math                - (String) Cos Sin Mod Log Exp etc.
; Return values .: The Result of the Operation
;                : ""					= if the operation failed
;                : False				= If the Element is unknown
; Modified ......:
; Remarks .......: Functions like Ceiling() or Floor() also work. Beaware that the result of the operation is also stored.
; Example .......: _storageO_Overwrite(123, 'testinteger', 3)
;                : _storageO_Math(123, 'testinteger, "Cos")
; ===============================================================================================================================
Func _storageO_Math($vElementGroup, $sElementName, $Math)
	; ~ todo
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
; Description ...: Tidies and destroys all Variables of the given element group, including the element group.
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
#EndRegion


; New Methods that require testing and optimization
; ===============================================================================================================================
; ===============================================================================================================================
; ===============================================================================================================================

; none

; Internal Barrier
; ===============================================================================================================================
; ===============================================================================================================================
; ===============================================================================================================================
; ===============================================================================================================================
; ===============================================================================================================================

; the add group var functions cannot be map based. That would render them incompatible with the Autoit Stable.

Func __storageG_AddGroupVar($vElementGroup, $sElementName)
	Local $oGroupVars = Eval("StorageS" & $vElementGroup)
	If Not IsObj($oGroupVars) Then
		$oGroupVars = ObjCreate("Scripting.Dictionary")
	EndIf

	$oGroupVars(String($sElementName))
	Assign("StorageS" & $vElementGroup, $oGroupVars, 2)
EndFunc

Func __storageGO_Startup()

	Local $sVarName = '__storageGO_'

	; check if already started
	Eval($sVarName & "1")

	; if already started then return
	If Not @error Then Return False

	; assign a single storage
	Assign($sVarName & "1", Null, 2)

	; set size and current index
	$__storageS_GO_Size = 1
	$__storageS_GO_Index = 1

	; add single storage to the index object
	$__storageS_GO_IndexObject(1) = Null

EndFunc

Func __storageGO_AddGroupVar($vElementGroup, $sElementName)
	Local $oGroupVars = Eval('Group__storageGO_' & $vElementGroup)
	If Not IsObj($oGroupVars) Then
		$oGroupVars = ObjCreate("Scripting.Dictionary")
	EndIf

	$oGroupVars(String($sElementName))
	Assign('Group__storageGO_' & $vElementGroup, $oGroupVars, 2)
EndFunc
