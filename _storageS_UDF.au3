#include-once
#include <Array.au3> ; for development of this UDF

Global $__storageS_sVersion = "0.1.5"
Global $__storageS_O_Dictionaries = ObjCreate("Scripting.Dictionary")
Global $__storageS_OL_Dictionaries = ObjCreate("Scripting.Dictionary")
Global $__storageS_ALR_Array[1e6]
Global $__storageS_ALR_Index = 0
Global $__storageS_GO_PosObject = ObjCreate("Scripting.Dictionary")
Global $__storageS_GO_IndexObject = ObjCreate("Scripting.Dictionary")
Global $__storageS_GO_GroupObject = ObjCreate("Scripting.Dictionary")
Global $__storageS_GO_Size = 0
Global $__storageS_RBx_Array = False
Global $__storageS_RBx_WritePos = False
Global $__storageS_RBx_ReadPos = False

__storageGO_Startup()
__storageAL_Startup()


#Region _storageG 		Assign / Eval Method
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


#Region _storageGO		Reuse Assign / Eval Method
; ===============================================================================================================================
; ===============================================================================================================================
; #FUNCTION# ====================================================================================================================
; Name ..........: _storageGO_CreateGroup
; Description ...: Creates the Group. Needs to be called.
; Syntax ........: _storageGO_CreateGroup($vElementGroup)
; Parameters ....: $vElementGroup       - a variant value.
; Return values .: True					= If Success
;                : False				= If the group is already present
; Modified ......:
; Remarks .......: If the Group is not present then no storage for it can be created.
; Example .......: No
; ===============================================================================================================================
Func _storageGO_CreateGroup($vElementGroup)
	If $__storageS_GO_GroupObject.Exists('g' & $vElementGroup) Then Return False

	$oGroupVars = ObjCreate("Scripting.Dictionary")
	$__storageS_GO_GroupObject('g' & $vElementGroup) = $oGroupVars

	Return True
EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageGO_Overwrite
; Description ...: Writes data to the Elementname of the Element group
; Syntax ........: _storageGO_Overwrite($vElementGroup, $sElementName, $vElementData)
; Parameters ....: $vElementGroup           - Element Group
;                  $sElementName            - (String) Element Name
;                  $vElementData            - (Variable) Element Data
; Return values .: True						= If success
;                : False					= If not
; Errors ........: 1						- $vElementGroup is not created or got destroyed.
;                : 2						- $vElementData is False. Not an issue because _storageGO_Read() will return False anyway.
;                :							  This is a feature to reduce globals use.
; Modified ......:
; Remarks .......:
; Example .......: No
; ===============================================================================================================================
Func _storageGO_Overwrite($vElementGroup, $sElementName, $vElementData)

	Local $sVarName = 'g' & $vElementGroup & $sElementName

	; if the var is not known then claim one
	If Not $__storageS_GO_PosObject.Exists($sVarName) Then

		; if the element data is False then we wont claim a storage
		If $vElementData == False Then Return SetError(2, 0, False)

		; if the group addition fails then return False
		If Not __storageGO_AddGroupVar($vElementGroup, $sElementName) Then Return SetError(1, 0, False)

		; if no free storage is available then create a new storage
		If $__storageS_GO_IndexObject.Count == 0 Then

			; increase size
			$__storageS_GO_Size += 1

			; claim it
			$__storageS_GO_PosObject($sVarName) = $__storageS_GO_Size

			; assign and return
			Return Assign('__storageGO_' & $__storageS_GO_Size, $vElementData, 2)

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

	Else ; if its known then assign the data

		Return Assign('__storageGO_' & $__storageS_GO_PosObject($sVarName), $vElementData, 2)

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

	Local $sVarName = 'g' & $vElementGroup & $sElementName

	If Not $__storageS_GO_PosObject.Exists($sVarName) Then Return _storageGO_Overwrite($vElementGroup, $sElementName, $vElementData)

	Local $nPos = $__storageS_GO_PosObject($sVarName)
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

	Local $sVarName = 'g' & $vElementGroup & $sElementName

	; check if the storage exists
	If Not $__storageS_GO_PosObject.Exists($sVarName) Then Return SetError(1, 0, False)

	Return Eval('__storageGO_' & $__storageS_GO_PosObject($sVarName))

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

	If Not $__storageS_GO_GroupObject.Exists('g' & $vElementGroup) Then Return False
	Local $oElementGroup = $__storageS_GO_GroupObject('g' & $vElementGroup)

	$vElementGroup = 'g' & $vElementGroup

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

	If Not $__storageS_GO_GroupObject.Exists('g' & $vElementGroup) Then Return False
	Local $oElementGroup = $__storageS_GO_GroupObject('g' & $vElementGroup)

	$vElementGroup = 'g' & $vElementGroup

	For $i In $oElementGroup
		Assign('__storageGO_' & $__storageS_GO_PosObject($vElementGroup & $i), Null, 2)
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

	If Not $__storageS_GO_GroupObject.Exists('g' & $vElementGroup) Then Return False
	Local $oElementGroup = $__storageS_GO_GroupObject('g' & $vElementGroup)

	Local $nPos = 0
	For $i In $oElementGroup

		; get pos
		$nPos = $__storageS_GO_PosObject('g' & $vElementGroup & $i)

		; tidy storage
		Assign('__storageGO_' & $nPos, Null, 2)

		; add as free storage to the index object
		$__storageS_GO_IndexObject($nPos)

		; remove element from group
		$oElementGroup.Remove($i)

		; remove element from pos object
		$__storageS_GO_PosObject.Remove('g' & $vElementGroup & $i)
	Next

	; remove group
	$__storageS_GO_GroupObject.Remove('g' & $vElementGroup)

EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageGO_DestroyVar
; Description ...: Tidies and frees the given var from the given group
; Syntax ........: _storageGO_DestroyVar($vElementGroup, $sElementName)
; Parameters ....: $vElementGroup           - Element Group
;                  $sElementName            - (String) Element Name
; Return values .: None
; Modified ......:
; Remarks .......:
; Example .......: No
; ===============================================================================================================================
Func _storageGO_DestroyVar($vElementGroup, $sElementName)

	If Not $__storageS_GO_GroupObject.Exists('g' & $vElementGroup) Then Return False
	Local $oElementGroup = $__storageS_GO_GroupObject('g' & $vElementGroup)

	Local $sVarName = 'g' & $vElementGroup & $sElementName

	If Not $__storageS_GO_PosObject.Exists($sVarName) Then Return False
	Local $nPos = $__storageS_GO_PosObject($sVarName)

	Assign('__storageGO_' & $nPos, Null, 2)

	$__storageS_GO_PosObject.Remove($sVarName)
	$__storageS_GO_IndexObject($nPos)

	$oElementGroup.Remove(String($sElementName))
	$__storageS_GO_GroupObject('g' & $vElementGroup) = $oElementGroup

	Return True

EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageGO_GetClaimedVars
; Description ...: Returns all claimed variables in a 2D array
; Syntax ........: _storageGO_GetClaimedVars()
; Parameters ....: None
; Return values .: 2D array					= If success
;                : False					= If none
; Modified ......:
; Remarks .......: Array looks like this
;                : [n][0]					= Element name
;                : [n][1]					= Element Variable Type
;                : [n][2]					= Element Variable Data
;                :
;                : This is a debug feature to find memory leaks
; Example .......: No
; ===============================================================================================================================
Func _storageGO_GetClaimedVars()

	Local $arGroupVars2D[$__storageS_GO_PosObject.Count][3], $nCount = 0, $nPos = 0
	If UBound($arGroupVars2D) == 0 Then Return False

	For $i In $__storageS_GO_PosObject
		$arGroupVars2D[$nCount][0] = StringTrimLeft($i, 1)

		$nPos = $__storageS_GO_PosObject($i)

		$arGroupVars2D[$nCount][1] = VarGetType(Eval('__storageGO_' & $nPos))
		$arGroupVars2D[$nCount][2] = Eval('__storageGO_' & $nPos)

		$nCount += 1
	Next

	Return $arGroupVars2D

EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageGO_GetInfo
; Description ...: Returns various informations of the GO method.
; Syntax ........: _storageGO_GetInfo($nMode)
; Parameters ....: $nMode               - (Int) the Mode
;                : 1					- Returns the amount of existing storages
;                : 2					- Returns the amount of free storages
;                : 3					- Returns the amount of claimed storages
;                : 4					- Returns the Size in Bytes of all claimed storages (CPU intensive)
; Return values .: The Result			= as Int
;                : False				= If an invalid option got used
; Modified ......:
; Remarks .......:
; Example .......: No
; ===============================================================================================================================
; note: i should take into consideration that repeated data isnt put into memory again
Func _storageGO_GetInfo($nMode)

	Switch $nMode

		Case 1 ; amount of existing storage vars
			Return $__storageS_GO_Size

		Case 2 ; free storage vars
			Return $__storageS_GO_IndexObject.Count

		Case 3 ; claimed storage vars
			Return $__storageS_GO_PosObject.Count

		Case 4 ; size of claimes storage vars
			Local $nSize = 0
			For $i In $__storageS_GO_PosObject
				$nSize += _storageS_GetVarSize(Eval('__storageGO_' & $__storageS_GO_PosObject($i)))
			Next

			Return $nSize

	EndSwitch

EndFunc
#EndRegion


#Region _storageO		DictObj method
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
	$__storageS_O_Dictionaries($vElementGroup) = $oElementGroup

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

	If Not $__storageS_O_Dictionaries.Exists($vElementGroup) Then Return SetError(1, 0, False)
;~ 	If Not $__storageS_O_Dictionaries.Exists($vElementGroup) Then _storageO_CreateGroup($vElementGroup) ; doesnt work ? Object keeps inaccessible

	Local $oElementGroup = $__storageS_O_Dictionaries($vElementGroup)
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

	Local $oElementGroup = $__storageS_O_Dictionaries($vElementGroup)
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

	Local $oElementGroup = $__storageS_O_Dictionaries($vElementGroup)
	if Not IsObj($oElementGroup) Then Return SetError(1, 0, False)

	If Not $oElementGroup.Exists($sElementName) Then Return SetError(2, 0, False)

	Return $oElementGroup($sElementName)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageO_DestroyGroup
; Description ...: Tidies and destroys all Variables of the given element group, including the element group.
; Syntax ........: _storageO_DestroyGroup($vElementGroup)
; Parameters ....: $vElementGroup           - Element Group
; Return values .: None
; Modified ......:
; Remarks .......:
; Example .......: _storageO_DestroyGroup(123)
; ===============================================================================================================================
Func _storageO_DestroyGroup($vElementGroup)
	$vElementGroup = '_storageS_' & $vElementGroup

	Local $oElementGroup = $__storageS_O_Dictionaries($vElementGroup)

	For $i In $oElementGroup
		$oElementGroup.Remove($i)
	Next

	$__storageS_O_Dictionaries.Remove($vElementGroup)
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

	Local $oElementGroup = $__storageS_O_Dictionaries($vElementGroup)
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


#Region _storageOL		DictObj List method
; ===============================================================================================================================
; ===============================================================================================================================
; #FUNCTION# ====================================================================================================================
; Name ..........: _storageOL_CreateGroup
; Description ...: Creates a dictobj list under the given groupname
; Syntax ........: _storageOL_CreateGroup($vElementGroup)
; Parameters ....: $vElementGroup       - Element Group
; Return values .: True					= If success
;                : False				= If the group already exists
; Modified ......:
; Remarks .......:
; Example .......: No
; ===============================================================================================================================
Func _storageOL_CreateGroup($vElementGroup)

	; numbers dont work and converting the numer to String() often doesnt too.
	; so we add a char in front to make sure that the dict wont have any issues with the name
	$vElementGroup = 'g' & $vElementGroup

	; if the group already exists then return False
	if $__storageS_OL_Dictionaries.Exists($vElementGroup) Then Return False

	Local $oElementGroup = ObjCreate("Scripting.Dictionary")
	$__storageS_OL_Dictionaries($vElementGroup) = $oElementGroup

	Return True
EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageOL_AddElement
; Description ...: Adds a element to the dictobj
; Syntax ........: _storageOL_AddElement($vElementGroup, $sElementName)
; Parameters ....: $vElementGroup       - Element Group
;                  $sElementName        - Element Name
; Return values .: True					= If success
;                : False				= If not
; Errors ........: 1					- The elementgroup is unknown
;                : 2					- The elementname is already added to the list
; Modified ......:
; Remarks .......:
; Example .......: No
; ===============================================================================================================================
Func _storageOL_AddElement($vElementGroup, $sElementName)
	$vElementGroup = 'g' & $vElementGroup

	; if the elementgroup is unknown then return false
	If Not $__storageS_OL_Dictionaries.Exists($vElementGroup) Then Return SetError(1, 0, False)
	Local $oElementGroup = $__storageS_OL_Dictionaries($vElementGroup)

	$sElementName = 'g' & $sElementName

	; if the element is already present then return false
	if $oElementGroup.Exists($sElementName) Then Return SetError(2, 0, False)

	; add the element
	$oElementGroup($sElementName)
	$__storageS_OL_Dictionaries($vElementGroup) = $oElementGroup

	Return True
EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageOL_GetElements
; Description ...: Returns all existing elements in the given groupname in a 1D Array
; Syntax ........: _storageOL_GetElements($vElementGroup)
; Parameters ....: $vElementGroup       - Element Group
; Return values .: False				= If the elementgroup is unknown
;                : 1D Array				= Containing all elements, starting at [0]
; Modified ......:
; Remarks .......:
; Example .......: No
; ===============================================================================================================================
Func _storageOL_GetElements($vElementGroup)
	$vElementGroup = 'g' & $vElementGroup

	; if the elementgroup is unknown then return false
	If Not $__storageS_OL_Dictionaries.Exists($vElementGroup) Then Return False
	Local $oElementGroup = $__storageS_OL_Dictionaries($vElementGroup)

	Local $arGroupVars[$oElementGroup.Count], $nCount = 0
	For $i In $oElementGroup
		$arGroupVars[$nCount] = StringTrimLeft($i, 1)
		$nCount += 1
	Next

	Return $arGroupVars
EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageOL_Exists
; Description ...: Checks if the given element exists in the given element group
; Syntax ........: _storageOL_Exists($vElementGroup, $sElementName)
; Parameters ....: $vElementGroup       - Element Group
;                  $sElementName        - Element Name
; Return values .: True					= Element exists
;                : False				= Element does not exists
; Modified ......:
; Remarks .......:
; Example .......: No
; ===============================================================================================================================
Func _storageOL_Exists($vElementGroup, $sElementName)
	$vElementGroup = 'g' & $vElementGroup

	; if the elementgroup is unknown then return false
	If Not $__storageS_OL_Dictionaries.Exists($vElementGroup) Then Return SetError(1, 0, False)
	Local $oElementGroup = $__storageS_OL_Dictionaries($vElementGroup)

	$sElementName = 'g' & $sElementName

	Return $oElementGroup.Exists($sElementName)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageOL_RemoveElement
; Description ...: Removes the given element from the given element group
; Syntax ........: _storageOL_RemoveElement($vElementGroup, $sElementName)
; Parameters ....: $vElementGroup       - Element Group
;                  $sElementName        - Element Name
; Return values .: True					= If success
;                : False				= If not
; Errors ........: 1					- elementgroup is unknown
;                : 2					- element not part of the group
; Modified ......:
; Remarks .......:
; Example .......: No
; ===============================================================================================================================
Func _storageOL_RemoveElement($vElementGroup, $sElementName)
	$vElementGroup = 'g' & $vElementGroup

	; if the elementgroup is unknown then return false
	If Not $__storageS_OL_Dictionaries.Exists($vElementGroup) Then Return SetError(1, 0, False)
	Local $oElementGroup = $__storageS_OL_Dictionaries($vElementGroup)

	$sElementName = 'g' & $sElementName

	If Not $oElementGroup.Exists($sElementName) Then Return SetError(2, 0, False)

	$oElementGroup.Remove($sElementName)
	$__storageS_OL_Dictionaries($vElementGroup) = $oElementGroup

	Return True
EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageOL_DestroyGroup
; Description ...: Destroys the whole group and its contents
; Syntax ........: _storageOL_DestroyGroup($vElementGroup)
; Parameters ....: $vElementGroup       - Element Group
; Return values .: True					= If success
;                : False				= If the elementgroup is unknown
; Modified ......:
; Remarks .......:
; Example .......: No
; ===============================================================================================================================
Func _storageOL_DestroyGroup($vElementGroup)
	$vElementGroup = 'g' & $vElementGroup

	If Not $__storageS_OL_Dictionaries.Exists($vElementGroup) Then Return False

	$__storageS_OL_Dictionaries.Remove($vElementGroup)
	Return True
EndFunc
#EndRegion


#Region _storageAL		Array List method
; ===============================================================================================================================
; ===============================================================================================================================
; #FUNCTION# ====================================================================================================================
; Name ..........: _storageAL_CreateGroup
; Description ...: Creates a Element Group
; Syntax ........: _storageAL_CreateGroup($vElementGroup)
; Parameters ....: $vElementGroup       - a variant value.
; Return values .: True					= If success
;                : False				= If the group already exists
; Modified ......:
; Remarks .......:
; Example .......: No
; ===============================================================================================================================
Func _storageAL_CreateGroup($vElementGroup)

	If IsArray(_storageGO_Read('_storageAL', $vElementGroup)) Then Return False

	Local $arElemenGroup[0]
	Return _storageGO_Overwrite('_storageAL', $vElementGroup, $arElemenGroup)

EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageAL_AddElement
; Description ...: Adds a Element to the given Group
; Syntax ........: _storageAL_AddElement($vElementGroup, $sElementName)
; Parameters ....: $vElementGroup       - a variant value.
;                  $sElementName        - a string value.
; Return values .: True					= If success
;                : False				= If the Group is unknown
; Modified ......:
; Remarks .......:
; Example .......: No
; ===============================================================================================================================
Func _storageAL_AddElement($vElementGroup, $sElementName)

	Local $arElementGroup = _storageGO_Read('_storageAL', $vElementGroup)
	If Not IsArray($arElementGroup) Then Return False

	Local $nArSize = UBound($arElementGroup)

	ReDim $arElementGroup[$nArSize + 1]
	$arElementGroup[$nArSize] = $sElementName

	Return _storageGO_Overwrite('_storageAL', $vElementGroup, $arElementGroup)

EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageAL_GetElements
; Description ...: Returns all Elements of the given group in a 1D Array
; Syntax ........: _storageAL_GetElements($vElementGroup)
; Parameters ....: $vElementGroup       - a variant value.
; Return values .: Array				= Containing all Elements of the group, starting at [0]
;                : False				= If the Group is unknown
; Modified ......:
; Remarks .......:
; Example .......: No
; ===============================================================================================================================
Func _storageAL_GetElements($vElementGroup)

	Return _storageGO_Read('_storageAL', $vElementGroup)

EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageAL_Exists
; Description ...: Checks if the given Element exists for the given group
; Syntax ........: _storageAL_Exists($vElementGroup, $sElementName)
; Parameters ....: $vElementGroup       - a variant value.
;                  $sElementName        - a string value.
; Return values .: True					= Element exists
;                : False				= Element does not exists
; Errors ........: 1					= Group is unknown
; Modified ......:
; Remarks .......:
; Example .......: No
; ===============================================================================================================================
Func _storageAL_Exists($vElementGroup, $sElementName)

	Local $arElemenGroup = _storageGO_Read('_storageAL', $vElementGroup)
	If Not IsArray($arElemenGroup) Then Return SetError(1, 0, False)

	For $i = 0 To UBound($arElemenGroup) - 1
		if $arElemenGroup[$i] == $sElementName Then Return True
	Next

	Return False

EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageAL_RemoveElement
; Description ...: Removes the given Element from the given Group
; Syntax ........: _storageAL_RemoveElement($vElementGroup, $sElementName)
; Parameters ....: $vElementGroup       - a variant value.
;                  $sElementName        - a string value.
; Return values .: True					= If success
;                : False				= If not
; Errors ........: 1					= Group is unknown
;                : 2					= Element is unknown
; Modified ......:
; Remarks .......:
; ===============================================================================================================================
Func _storageAL_RemoveElement($vElementGroup, $sElementName)

	Local $arElemenGroup = _storageGO_Read('_storageAL', $vElementGroup)
	If Not IsArray($arElemenGroup) Then Return SetError(1, 0, False)

	Local $nArSize = UBound($arElemenGroup) - 1, $nIndex = -1
	For $i = 0 To $nArSize
		If $arElemenGroup[$i] == $sElementName Then
			$nIndex = $i
			ExitLoop
		EndIf
	Next

	If $nIndex == -1 Then Return SetError(2, 9, False)

	$arElemenGroup[$nIndex] = $arElemenGroup[$nArSize]
	ReDim $arElemenGroup[$nArSize]

	Return _storageGO_Overwrite('_storageAL', $vElementGroup, $arElemenGroup)

EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageAL_DestroyGroup
; Description ...: Destroys the entire Group and its elements.
; Syntax ........: _storageAL_DestroyGroup($vElementGroup)
; Parameters ....: $vElementGroup       - a variant value.
; Return values .: True					= If success
;                : False				= Group is unknown
; Modified ......:
; Remarks .......:
; Example .......: No
; ===============================================================================================================================
Func _storageAL_DestroyGroup($vElementGroup)

	Local $arElemenGroup = _storageGO_Read('_storageAL', $vElementGroup)
	If Not IsArray($arElemenGroup) Then Return False

	Return _storageGO_DestroyVar('_storageAL', $vElementGroup)

EndFunc
#EndRegion


#Region _storageALR		Array List Rapid Add
; ===============================================================================================================================
; ===============================================================================================================================
; #FUNCTION# ====================================================================================================================
; Name ..........: _storageALR_AddElement
; Description ...: Adds a Element
; Syntax ........: _storageALR_AddElement($sElementName)
; Parameters ....: $sElementName        - a string value.
; Return values .: None
; Modified ......:
; Remarks .......: Works with a Single Global Array. So its not possible to write elements to a group. Thats what ALRapidX is for.
; Example .......: No
; ===============================================================================================================================
Func _storageALR_AddElement($sElementName)

	Local $nArSize = UBound($__storageS_ALR_Array)
	If $__storageS_ALR_Index = $nArSize Then ReDim $__storageS_ALR_Array[$nArSize + 1e6]

	$__storageS_ALR_Array[$__storageS_ALR_Index] = $sElementName
	$__storageS_ALR_Index += 1

EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageALR_ConvertToAL
; Description ...: Converts the ALR Array to a AL array
; Syntax ........: _storageALR_ConvertToAL($vElementGroup)
; Parameters ....: $vElementGroup       - a variant value.
; Return values .: True					= If success
;                : False				= The group already exists
; Modified ......:
; Remarks .......: Once you finished adding all the elements, you call this function to create the AL Group.
; Example .......: No
; ===============================================================================================================================
Func _storageALR_ConvertToAL($vElementGroup)

	If IsArray(_storageGO_Read('_storageAL', $vElementGroup)) Then Return False

	Local $arElemenGroup = $__storageS_ALR_Array
	ReDim $arElemenGroup[$__storageS_ALR_Index]

	Return _storageGO_Overwrite('_storageAL', $vElementGroup, $arElemenGroup)

EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageALR_Destroy
; Description ...: Resets the global array
; Syntax ........: _storageALR_Destroy()
; Parameters ....: None
; Return values .: None
; Modified ......:
; Remarks .......:
; Example .......: No
; ===============================================================================================================================
Func _storageALR_Destroy()

	Local $arElemenGroup[1e6]
	$__storageS_ALR_Array = $arElemenGroup
	$__storageS_ALR_Index = 0

EndFunc
#EndRegion


#Region _storageGL		Assign/Eval List
; ===============================================================================================================================
; ===============================================================================================================================
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


#Region _storageGLx		Assign/Eval List X
; ===============================================================================================================================
; ===============================================================================================================================
; #FUNCTION# ====================================================================================================================
; Name ..........: _storageGLx_AddElement
; Description ...: Adds an Element to the List
; Syntax ........: _storageGLx_AddElement($vElementGroup, $sElementName)
; Parameters ....: $vElementGroup       - a variant value.
;                  $sElementName        - a string value.
; Return values .: True
; Modified ......:
; Remarks .......:
; Example .......: No
; ===============================================================================================================================
Func _storageGLx_AddElement($vElementGroup, $sElementName)
	Return Assign(StringToBinary($vElementGroup & $sElementName), True, 2)
EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageGLx_Exists
; Description ...: Checks if an element exists in the list
; Syntax ........: _storageGLx_Exists($vElementGroup, $sElementName)
; Parameters ....: $vElementGroup       - a variant value.
;                  $sElementName        - a string value.
; Return values .: None
; Modified ......:
; Remarks .......:
; Example .......: No
; ===============================================================================================================================
Func _storageGLx_Exists($vElementGroup, $sElementName)
	Return Eval(StringToBinary($vElementGroup & $sElementName))
EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageGLx_RemoveElement
; Description ...: Removes an element from the list
; Syntax ........: _storageGLx_RemoveElement($vElementGroup, $sElementName)
; Parameters ....: $vElementGroup       - a variant value.
;                  $sElementName        - a string value.
; Return values .: None
; Modified ......:
; Remarks .......:
; Example .......: No
; ===============================================================================================================================
Func _storageGLx_RemoveElement($vElementGroup, $sElementName)
	Return Assign(StringToBinary($vElementGroup & $sElementName), False, 6)
EndFunc
#EndRegion


#Region _storageRBr		Multi Return Ring Buffer (lossy)
; #FUNCTION# ====================================================================================================================
; Name ..........: _storageRBr_CreateGroup
; Description ...: Creates a Ring buffer and returns it
; Syntax ........: _storageRBr_CreateGroup($nRingElementCount)
; Parameters ....: $nRingElementCount   - Element count
; Return values .: Array
; Modified ......:
; Remarks .......:
; Example .......: No
; ===============================================================================================================================
Func _storageRBr_CreateGroup($nRingElementCount)

	Local $arRingBuffer[$nRingElementCount + 2]
	$arRingBuffer[0] = 2 ; WritePos
	$arRingBuffer[1] = 2 ; ReadPos

	Return $arRingBuffer

EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageRBr_Add
; Description ...: Adds an Element to the given Ring Buffer
; Syntax ........: _storageRBr_Add(Byref $arRingBuffer, $vElementData)
; Parameters ....: $arRingBuffer        - [in/out] The Ring Buffer
;                  $vElementData        - Data of any kind
; Return values .: None
; Modified ......:
; Remarks .......:
; Example .......: No
; ===============================================================================================================================
Func _storageRBr_Add(ByRef $arRingBuffer, $vElementData)

	If UBound($arRingBuffer) == $arRingBuffer[0] Then $arRingBuffer[0] = 2

	$arRingBuffer[$arRingBuffer[0]] = $vElementData
	$arRingBuffer[0] += 1

EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageRBr_Get
; Description ...: Returns the oldest data of the given Ring Buffer
; Syntax ........: _storageRBr_Get(Byref $arRingBuffer)
; Parameters ....: $arRingBuffer        - [in/out] The Ring Buffer
; Return values .: The oldest data
; Modified ......:
; Remarks .......:
; Example .......: No
; ===============================================================================================================================
Func _storageRBr_Get(ByRef $arRingBuffer)

	If UBound($arRingBuffer) == $arRingBuffer[1] Then $arRingBuffer[1] = 2

	Local $vElementData = $arRingBuffer[$arRingBuffer[1]]
	if $vElementData == "" Then Return SetError(1, 0, False)

	$arRingBuffer[$arRingBuffer[1]] = ""
	$arRingBuffer[1] += 1

	Return $vElementData

EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageRBr_DestroyGroup
; Description ...: Destroys the given Ring Buffer
; Syntax ........: _storageRBr_DestroyGroup(Byref $arRingBuffer)
; Parameters ....: $arRingBuffer        - [in/out] The Ring Buffer
; Return values .: None
; Modified ......:
; Remarks .......:
; Example .......: No
; ===============================================================================================================================
Func _storageRBr_DestroyGroup(ByRef $arRingBuffer)
	$arRingBuffer = Null
EndFunc
#EndRegion


#Region _storageRBx		Single Storage Ring Buffer (lossy)
; #FUNCTION# ====================================================================================================================
; Name ..........: _storageRBx_Init
; Description ...: Initializes the Single Ring Buffer
; Syntax ........: _storageRBx_Init($nRingElementCount)
; Parameters ....: $nRingElementCount   - Element count
; Return values .: True					= If success
;                : False				= If the ring buffer is already initialized
; Modified ......:
; Remarks .......:
; Example .......: No
; ===============================================================================================================================
Func _storageRBx_Init($nRingElementCount)

	If IsArray($__storageS_RBx_Array) Then Return False

	Local $arRingBuffer[$nRingElementCount]
	$__storageS_RBx_Array = $arRingBuffer
	$__storageS_RBx_ReadPos = 0
	$__storageS_RBx_WritePos = 0

	Return True

EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageRBx_Add
; Description ...: Adds a Element to the Single Ring buffer
; Syntax ........: _storageRBx_Add($vElementData)
; Parameters ....: $vElementData        - Data of any kind
; Return values .: True					= If success
;                : False				= If the Single Buffer isnt initialized
; Modified ......:
; Remarks .......:
; Example .......: No
; ===============================================================================================================================
Func _storageRBx_Add($vElementData)

	If Not IsArray($__storageS_RBx_Array) Then Return False

	If UBound($__storageS_RBx_Array) == $__storageS_RBx_WritePos Then $__storageS_RBx_WritePos = 0

	$__storageS_RBx_Array[$__storageS_RBx_WritePos] = $vElementData
	$__storageS_RBx_WritePos += 1

	Return True

EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageRBx_Get
; Description ...: Returns the oldest data of the Single Ring buffer
; Syntax ........: _storageRBx_Get()
; Parameters ....: None
; Return values .: The oldest Data
;                : False				= if not possible
; Errors ........: 1					- If the Single Buffer isnt initialized
;                : 2					- If there is no Element in the Ring Buffer
; Modified ......:
; Remarks .......:
; Example .......: No
; ===============================================================================================================================
Func _storageRBx_Get()

	If Not IsArray($__storageS_RBx_Array) Then Return SetError(1, 0, False)

	If UBound($__storageS_RBx_Array) == $__storageS_RBx_ReadPos Then $__storageS_RBx_ReadPos = 0

	Local $vElementData = $__storageS_RBx_Array[$__storageS_RBx_ReadPos]
	If $vElementData == "" Then Return SetError(2, 0, False)

	$__storageS_RBx_Array[$__storageS_RBx_ReadPos] = ""
	$__storageS_RBx_ReadPos += 1

	Return $vElementData

EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageRBx_Destroy
; Description ...: Destroys the Single Ring buffer
; Syntax ........: _storageRBx_Destroy()
; Parameters ....: None
; Return values .: None
; Modified ......:
; Remarks .......: Ring buffer can be reinitialized
; Example .......: No
; ===============================================================================================================================
Func _storageRBx_Destroy()

	$__storageS_RBx_Array = False
	$__storageS_RBx_ReadPos = False
	$__storageS_RBx_WritePos = False

EndFunc
#EndRegion


#Region Miscellaneous Functions
; #FUNCTION# ====================================================================================================================
; Name ..........: _storageS_GetVarSize
; Description ...: Returns the Size of the given Variable
; Syntax ........: _storageS_GetVarSize($vData)
; Parameters ....: $vData               - Variable
; Return values .: None
; Modified ......:
; Remarks .......: Objects, Maps and functions are not supported. Array's 1D or 2D of any size.
;                : Function is recursive. Arrays in Arrays in Arrays ... a dozen times will crash Autoit.
; Example .......: No
; ===============================================================================================================================
Func _storageS_GetVarSize($vData)
	Switch VarGetType($vData)

		Case 'String', 'Binary'
			Return StringLen($vData)

		Case 'Int32', 'Int64', 'Double', 'Float'
			Return StringLen($vData)

		Case 'Ptr'
			Return StringLen($vData)

		Case 'Keyword'
			Return 1

		Case 'Bool'
			Return 1

		Case 'DLLStruct'
			Return DllStructGetSize($vData)

		Case 'Array'
			Local $nY = UBound($vData), $nX = UBound($vData, 2)

			If $nY == 0 Then Return 0
			Local $nLen = 0

			if $nX == 0 Then

				For $iY = 0 To $nY - 1
					$nLen += _storageS_GetVarSize($vData[$iY])
				Next

			ElseIf $nX > 0 Then

				For $iY = 0 To $nY - 1
					For $iX = 0 To $nX - 1
						$nLen += _storageS_GetVarSize($vData[$iY][$iX])
					Next
				Next

			EndIf

			Return $nLen

	EndSwitch
EndFunc
#EndRegion


; New Methods that require testing and optimization
; ===============================================================================================================================
; ===============================================================================================================================
; ===============================================================================================================================

#Region _storageRBs		WIP Multi Storage Ring Buffer (lossy) (needs optimization)
Func _storageRBs_CreateGroup($sRingName, $nRingElementCount)

	$sRingName = '_storageRBs' & $sRingName
	If Not _storageGO_CreateGroup($sRingName) Then Return False

	Local $arRingBuffer = _storageRBr_CreateGroup($nRingElementCount)

	Return _storageGO_Overwrite($sRingName, 'RingBuffer', $arRingBuffer)

EndFunc


Func _storageRBs_Add($sRingName, $vElementData)

	$sRingName = '_storageRBs' & $sRingName
	Local $arRingBuffer = _storageGO_Read($sRingName, 'RingBuffer')
	If Not IsArray($arRingBuffer) Then Return False

	_storageRBr_Add($arRingBuffer, $vElementData)

	Return _storageGO_Overwrite($sRingName, 'RingBuffer', $arRingBuffer)

EndFunc


Func _storageRBs_Get($sRingName)

	$sRingName = '_storageRBs' & $sRingName
	Local $arRingBuffer = _storageGO_Read($sRingName, 'RingBuffer')
	If Not IsArray($arRingBuffer) Then Return False

	Local $vElementData = _storageRBr_Get($arRingBuffer)
	if @error Then Return SetError(1, 0, False)
	_storageGO_Overwrite($sRingName, 'RingBuffer', $arRingBuffer)

	Return $vElementData

EndFunc


Func _storageRBs_DestroyGroup($sRingName)
	Return _storageGO_DestroyGroup('_storageRBs' & $sRingName)
EndFunc
#EndRegion


; Internal Barrier
; ===============================================================================================================================
; ===============================================================================================================================
; ===============================================================================================================================
; ===============================================================================================================================
; ===============================================================================================================================

; the add group var functions cannot be map based. That would render them incompatible with the Autoit Stable.

Func __storageG_AddGroupVar($vElementGroup, $sElementName)
	Local $oGroupVars = Eval("StorageS" & $vElementGroup)
	If IsObj($oGroupVars) == 0 Then
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
	$__storageS_GO_IndexObject(1)

EndFunc

Func __storageAL_Startup()
	_storageGO_CreateGroup('_storageAL')
EndFunc

Func __storageGO_AddGroupVar($vElementGroup, $sElementName)
	If Not $__storageS_GO_GroupObject.Exists('g' & $vElementGroup) Then Return False
	$oGroupVars = $__storageS_GO_GroupObject('g' & $vElementGroup)

	$oGroupVars(String($sElementName))
	$__storageS_GO_GroupObject('g' & $vElementGroup) = $oGroupVars
	Return True
EndFunc
