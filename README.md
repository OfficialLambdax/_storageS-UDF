# _storageS-UDF
_storageSimpel is a UDF meant for fast data read's and write's.

The UDF aims to provide multiple methods to make access to data and lists easy and as fast as possible for different kinds of usages.
Support for X32/64 Autoit Stable/Beta. Windows XP to 10. 11 and Wine not tested.


As of Version 0.1.3.2 there are three data storage methods and three listing storage methods.

============================== Tl;dr ==============================

Data storages
- _storageG is good for when you need the fastest data write and read speed while your script does not consistently create new storages.
- _storageGO is good for when you need fast data write and read speed for a script that does consistently create new storages.
- _storageO is good for when performance is not your goal and a long runtime is required.

Listing storages
- _storageOL is good for when your lists constantly change in size and its contents (Fastest Add, Remove Element method).
- _storageML is good for when you need to constantly iterate through somewhat static lists or for when you need to constantly check if a element exists (Fastest Exists method).
- _storageAL is only good for when you need to constantly iterate through somewhat static lists (Fastest GetElements method).
- _storageALRapid is a set of special functions to add elements extremly fast to a AL list (faster then _storageOL) to fasten the creation of large arrays.

Storage methods are not compatible with each other. But methods can easiely be changed to another with CTRL+H, to a degree.

======================= Data Storage methods ======================

The Assign/Eval Method. Functions that begin with _storageG are tied to this method.
	
Pros
- Very fast when writing or reading small and large Data sets
- The method does not get slower with the increase of storages
- Repeated Data is not written to memory. Aka less memory is required. CoW or something similiar seems to be present within Autoit which affects Global variables.

Cons
- Global variables cannot be removed but rather just be overwritten with Null to make them as small as possible. Aka the Method leaks to memory.
- Doesnt provide the ability for a long runtime, when variables are consistently created, because of the previous mentioned con.


The Reuse Assign/Eval Method. Functions that begin with _storageGO are tied to this method.
Its a combination of the Assign/Eval and Object method to counter the Memory leak.

Pros
- Fast when writing or reading small and Very fast on large Data sets
- The method does not get slower with the increase of storages
- Repeated Data is not written to memory. Aka less memory is required. CoW or something similiar seems to be present within Autoit which affects Global variables.
- Storages that get destroyed are reused by new storages. Aka new storages are only created when no other can currently be reused.

Cons
- Slower then the Original Assign/Eval Method.
- Leaks to memory, but only if a storage is created when no other can be reused.


The Dictionary Object Method. Functions that begin with _storageO are tied to this method.

Pros
- Very fast when writing or reading small Data sets
- Storages can be fully removed
	
Cons
- Very slow when writing or reading large Data sets. Everything above 100 KBytes should be avoided if performance is the focus.
- The method gets slower the more storages exist and the more data is stored in it.

===================== Listing Storage methods =====================

The Dictionary Object Method. Functions that begin with _storageOL are tied to this method.

Pros
- Very fast when adding elements (1e4 Elements take ~167 ms)
- Very fast when removing elements
- Fast when checking the existence of a element
- Fast when getting all elements of a group

Cons
- A Element can only be added a single time per group


The Map Method. Functions that begin with _storageML are tied to this method.

Pros
- Very fast when checking the existence of a element
- Very fast when getting all elements of a group
- Elements with the same name can be added multiple times

Cons
- Autoit Beta Only
- Experimental Autoit Feature
- Slow when adding elements
- Slow when removing elements
- Map interactions get slower the more Elements are stored within it (Adding 1e4 Elements took ~90sec)


The Array Method. Functions that begin with _storageAL are tied to this method.
Works on top of _storageGO.

Pros
- Fastest when getting all elements of a group
- Fastest when adding elements to a group if used in conjunction with _storageALRapid
- Elements with the same name can be added multiple times

Cons
- Slow when adding elements byitself
- Slow when removing elements
- Slow when checking the existence of a Element




You can check out the Examples Directory to see and test some performance tests.

Big thanks to AspirinJunkie@Autoit.de for introducing me to the Dictionary Object. It helped me improve the UDF by alot.
