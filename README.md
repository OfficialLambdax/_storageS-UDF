# _storageS-UDF
_storageSimpel is a UDF meant for fast data read's and write's.

The UDF aims to provide multiple methods to make access to data easy and as fast as possible.
Support for X32/64 Autoit Stable/Beta. Windows XP to 10. 11 and Wine not tested.


As of Version 0.1.3 there are three data storage methods and 1 listing storage method.

=========================================== Data Storage methods ===============================================

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


========================================= Listing Storage methods ==============================================


The Dictionary Object Method. Functions that begin with _storageOL are tied to this method.

Pros
- Very fast when adding elements
- Very fast when removing elements
- Very fast when checking the existens of a element

Cons
- A Element can only be added a single time per group


You can check out the Examples Directory to see which methods suits you better.

Big thanks to AspirinJunkie@Autoit.de for introducing me to the Dictionary Object. It helped me improve the UDF by alot.
