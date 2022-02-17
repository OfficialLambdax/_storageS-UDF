# _storageS-UDF
_storageSimpel is a UDF meant for fast data read's and write's.

The UDF aims to provide multiple methods to make access to data easy and as fast as possible.
Support for X32/64 Autoit Stable/Beta. Windows XP to 10. Wine not tested.


As of Version 0.1.2 there are three methods

The Assign/Eval Method. Functions that begin with _storageG are tied to this method.
	
Pros
- Very fast when writing or reading small and large Data sets.
- The method does not get slower with the increase of storages

Cons
- Global variables cannot be removed but rather just be overwritten with Null to make them as small as possible. Aka the Method leaks to memory.
- Doesnt provide the ability for a long runtime, when variables are consistently created, because of the previous mentioned con.


The Reuse Assign/Eval Method. Functions that begin with _storageGO are tied to this method.
Its a combination of the Assign/Eval and Object method to counter the Memory leak.

Pros
- Fast when writing or reading small and Very fast on large Data sets.
- The method does not get slower with the increase of storages
- Storages that get destroyed are reused by new storages. Aka new storages are only created when no other can currently be reused.

Cons
- Slower then the Original Assign/Eval Method
- Leaks to memory, but only if a storage is created when no other can be reused.


The Dictionary Object Method. Functions that begin with _storageO are tied to this method.

Pros
- Very fast when writing or reading small Data sets
- Storages can be fully removed
	
Cons
- Very slow when writing or reading large Data sets. Everything above 100 KBytes should be avoided if performance is the focus.
- The method gets slower the more storages exist and the more data is stored in it.



You can check out the Examples Directory to see which method suits you better.

Big thanks to AspirinJunkie@Autoit.de for introducing me to the Dictionary Object. It helped me improve the UDF by alot.
