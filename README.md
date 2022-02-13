# _storageS-UDF
_storageSimpel is a UDF meant for fast data read's and write's.

The UDF aims to provide multiple methods to make access to data easy and as fast as possible.
Support for X32/64 Autoit Stable/Beta. Windows XP to 10. Wine not tested.


As of Version 0.1 there are two methods

The Assign/Eval Method
Functions that begin with _storageG are tied to this method.
	
Pros
	- Very fast when writing or reading small and large Data sets.
	- The functions cannot by itself crash the script.

Cons
	- Global variables cannot be removed but rather just be Overwritten with Null to make them as small as possible. Creating multiple milliards(Ger) / billions(US) of variables will fill the RAM and sooner or later crash the script. There can nothing be done about it yet.
	- Doesnt provide the ability for a long runtime because of the previous mentioned con.


The Dictionary Object Method
Functions that begin with _storageO are tied to this method.

Pros
	- Very fast when writing or reading small Data sets.
	- Variables can be fully removed.
	
Cons
	- Very slow when writing or reading large Data sets. Everything above 100 KBytes should be avoided if performance is the focus.
	- The functions can lead to a crash if misused or duo to a bug where i or you deal with the DictObj in the wrong way.



You can check out the Examples Directory to see which method suits you better.

Big thanks to AspirinJunkie@Autoit.de for introducing me to the Dictionary Object.
