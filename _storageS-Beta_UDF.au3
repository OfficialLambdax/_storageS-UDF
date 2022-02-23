#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Version=Beta
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include-once
#include "_storageS_UDF.au3"

#cs

	REQUIRES BETA

#ce

Global $__storageS_ML_Maps = False

__storageML_Startup()




; #FUNCTION# ====================================================================================================================
; Name ..........: _storageML_CreateGroup
; Description ...: Creates a group with the given group name
; Syntax ........: _storageML_CreateGroup($vElementGroup)
; Parameters ....: $vElementGroup       - Group name
; Return values .: True					= If success
;                : False				= If the group already exists
; Modified ......:
; Remarks .......:
; Example .......: No
; ===============================================================================================================================
Func _storageML_CreateGroup($vElementGroup)

	If MapExists($__storageS_ML_Maps, $vElementGroup) Then Return False

	Local $mElementGroup[]
	$__storageS_ML_Maps[$vElementGroup] = $mElementGroup

	Return True

EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageML_AddElement
; Description ...: Adds a Element to the given Group
; Syntax ........: _storageML_AddElement($vElementGroup, $sElementName)
; Parameters ....: $vElementGroup       - Group name
;                  $sElementName        - Element name
; Return values .: True					= If success
;                : False				= If the Group is unknown
; Modified ......:
; Remarks .......:
; Example .......: No
; ===============================================================================================================================
Func _storageML_AddElement($vElementGroup, $sElementName)

	If Not MapExists($__storageS_ML_Maps, $vElementGroup) Then Return False
	Local $mElementGroup = $__storageS_ML_Maps[$vElementGroup]

	; do not use MapAppend() it produces bugs.
	$mElementGroup[$sElementName] = Null
	$__storageS_ML_Maps[$vElementGroup] = $mElementGroup

	Return True

EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageML_GetElements
; Description ...: Returns all Elements of the given Group in a 1D Array
; Syntax ........: _storageML_GetElements($vElementGroup)
; Parameters ....: $vElementGroup       - Group name
; Return values .: Array				= Containing all Elements of the Group, starting at [0]
;                : False				= The Group is unknown
; Modified ......:
; Remarks .......:
; Example .......: No
; ===============================================================================================================================
Func _storageML_GetElements($vElementGroup)

	If Not MapExists($__storageS_ML_Maps, $vElementGroup) Then Return False
	Local $mElementGroup = $__storageS_ML_Maps[$vElementGroup]

	Return MapKeys($mElementGroup)

EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageML_Exists
; Description ...: Checks if the Element exists in the given group
; Syntax ........: _storageML_Exists($vElementGroup, $sElementName)
; Parameters ....: $vElementGroup       - Group name
;                  $sElementName        - Element name
; Return values .: True					= Element exists
;                : False				= Element does not exists
; Errors ........: 1					- Group is unknown
; Modified ......:
; Remarks .......:
; Example .......: No
; ===============================================================================================================================
Func _storageML_Exists($vElementGroup, $sElementName)

	If Not MapExists($__storageS_ML_Maps, $vElementGroup) Then Return SetError(1, 0, False)
	Local $mElementGroup = $__storageS_ML_Maps[$vElementGroup]

	Return MapExists($mElementGroup, $sElementName)

EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageML_RemoveElement
; Description ...: Removes a element from the given group
; Syntax ........: _storageML_RemoveElement($vElementGroup, $sElementName)
; Parameters ....: $vElementGroup       - Group name
;                  $sElementName        - Element name
; Return values .: True					= If success
;                : False				= Group is unknown
; Modified ......:
; Remarks .......:
; Example .......: No
; ===============================================================================================================================
Func _storageML_RemoveElement($vElementGroup, $sElementName)

	If Not MapExists($__storageS_ML_Maps, $vElementGroup) Then Return False
	Local $mElementGroup = $__storageS_ML_Maps[$vElementGroup]

	MapRemove($mElementGroup, $sElementName)
	$__storageS_ML_Maps[$vElementGroup] = $mElementGroup

	Return True

EndFunc


; #FUNCTION# ====================================================================================================================
; Name ..........: _storageML_DestroyGroup
; Description ...: Destroys the entire group
; Syntax ........: _storageML_DestroyGroup($vElementGroup)
; Parameters ....: $vElementGroup       - Group name
; Return values .: True					= If success
;                : False				= If the group is unknown
; Modified ......:
; Remarks .......:
; Example .......: No
; ===============================================================================================================================
Func _storageML_DestroyGroup($vElementGroup)

	If Not MapExists($__storageS_ML_Maps, $vElementGroup) Then Return False
	Return MapRemove($__storageS_ML_Maps, $vElementGroup)

EndFunc


; internal
Func __storageML_Startup()
	If $__storageS_ML_Maps == False Then
		Local $mGlobal[]
		$__storageS_ML_Maps = $mGlobal

		Return True
	EndIf

	Return False
EndFunc