All methods got sorted within Regions that can easiely be closed and opened.

<p align="center">
    <img src="images/sort.png" width="1000" />
</p>


General Syntax used in most storage methods

Most data and list storage methods require the creation of the group first

_storageX_CreateGroup(Element Group)
e.g. _storageX_CreateGroup("Socket_123")

and provide the ability to destroy them

_storageX_DestroyGroup(Element Group)
e.g. _storageX_DestroyGroup("Socket_123")

or a single element of them, in one case.

_storageX_DestroyVar(Element Group, Element Name)
e.g. _storageX_DestroyVar("Socket_123", "Socket_IP")



Typical Data storage syntax

_storageX_Overwrite(Element Group, Element Name, Element Data)
e.g. _storageX_Overwrite("Socket_123", "Socket_IP", "127.0.0.1")

_storageX_Read(Element Group, Element Name)
e.g. _storageX_Read("Socket_123", "Socket_IP")


Typical List storage syntax

_storageX_AddElement(Element Group, Element)
e.g. _storageX_AddElement("IPBlacklist", "127.0.0.1")

_storageX_Exists(Element Group, Element)
e.g. _storageX_Exists("IPBlacklist", "127.0.0.1")

_storageX_GetElements(Element Group)
e.g. _storageX_GetElements("IPBlacklist")

_storageX_RemoveElement(Element Group, Element)
e.g. _storageX_RemoveElement("IPBlacklist", "127.0.0.1")


The Syntax for Ring Buffer varies between each method.

