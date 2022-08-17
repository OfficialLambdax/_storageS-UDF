# _storageS-UDF
_storageSimpel is a UDF meant to provide fast memory databases for different kind of usages.

Support for X32/64 Latest Autoit Stable/Beta. Windows XP to 10. 11 and Wine not tested.

Latest Version: 0.2.3 17.08.2022 (DD.MM.YYYY)

============================== Intro ==============================

_storageS provides Data storages, listing storages, ring buffers and setting storages.

All 4 variants come with a similiar syntax and are in most cases interchangable.

_storageGO_CreateGroup($sElementGroup)
Lets you create a GO data storage. GO in this case means Global Object. The data is stored in dynamic globals and managed with a dictionary object.

_storageGO_Overwrite($sElementGroup, $sElementname, $vElementData)
Will write data to that element in the group. Think of a object
$oObject("Element") = $vElementData
but instead of storing the data in a object, map, array etc. and carying it everywhere, the data is stored to memory and kept there until needed or changed.

_storageGO_Read($sElementGroup, $sElementName)
Will Return the data in the storage

_storageGO_DestroyGroup($sElementGroup)
Will destroy the storage and everything what was stored in it.


_storageMLi_CreateGroup($sElementGroup)
Lets you create a MLi listing storage. MLi in this case means Map Listing improved. The elements are stored in a map. i means that this method is a improvement to a earlier method called ML.

_storageMLi_AddElement($sElementGroup, $sElementName)
Adds a Element to this elementgroup

_storageMLi_RemoveElement($sElementGroup, $sElementName)
Will remove that element from the group

_storageMLi_Exists($sElementGroup, $sElementName)
Will check if that element in the list exists

_storageMLi_GetElements($sElementGroup)
Will return all Elements of that Group in a 1D Array.

_storageMLi_DestroyGroup($sElementGroup)
Will destroy the storage and everything what was stored in it.



If a group does not exists, then data can not be written and read from it (Not true for all methods). _storageS provides a solid amount of methods for each storage type. The idea is to have a storage method available for any kind of need. _storageGLx for example is specificly made to provide the ability to make insanely large static lists. Lists that can be so big as the ram has space, while not loosing time when checking if a Element in it exists. The data storage _storageGx comes with a similiar aim.

_storageX_ByRef()
Might fixes your performance issues with _storageS if you are manipulating stored data, like arrays, objects, maps..


============================== Wiki ===============================

Working on it. The UDF itself is structured and described. Each method has its own short describtion.
But you can get a better overview what each method can in the examples. Especially in the speed comparisons.


============================ Credits ==============================

Big thanks to AspirinJunkie@Autoit.de for introducing me to the Dictionary Object. It helped me improve the UDF by alot.
