# _storageS-UDF
_storageSimpel is a UDF meant for fast data read's and write's.

The UDF aims to provide multiple methods to make access to data and lists easy and AS FAST AS POSSIBLE for different kinds of usages.
Support for X32/64 Latest Autoit Stable/Beta. Windows XP to 10. 11 and Wine not tested.

As of Version 0.2 there are five data storage methods, eight listing storage methods and three ring buffer methods.

============================== Intro ==============================

Storages are Memory allocations of your given data or lists. When it comes to optimization of your scripts you might find that alot of time gets often lost because data is send through alot of functions that dont even need that data. Think of a IP black/whitelist. You dont need the ip list anywhere but in the function that checks if a given ip is black/whitelisted. It would be resource intensive to bring these lists everywhere. Thats why such a list is stored in memory and taken from there when required. Often it is enough to just have a single global that contains the data or the list. But, based on the what your script does, that might not work.

Within _netcode (a TCP libary) each socket has its own settings, rules and data sets, like the bytes per second that it receives or sends or its own events. All of that needs to be stored somewhere, a few globals on top of the script dont fit it.

Thats what this UDF is trying to solve, to make it possible to write and read data to memory easiely and fast.

_storageS comes with a vast amount of storage types. Those that are standartiest work well in many cases, but some more specialised are better in specific cases. You will, for example, likely not iterate through a IP Black/Whitelist, because thats slow, no you want to use associative array's to make an Exist check quick, so the listing storage type doesnt need to support a high dynamic but rather a fast "exist x element" check time. Or maybe you are looking to create a huge, drillion sized, list and none of the availabe data types or objects, you know of, in autoit can hold such a huge list. _storageGLx can do that. _storageS is ment to offer different variants to archive such different needs. Thats the idea of all of this.

Im literraly bending autoit in any possible way, that comes up in my mind, to squeeze every ms out thats possible. So you might discover some weird solutions and ask yourself, if thats an insult.

============================== Wiki ===============================

Working on it. The UDF itself is structured and described. Each method has its own short describtion.
But you can get a better overview what each method can in the examples. Especially in the speed comparisons.


============================ Credits ==============================

Big thanks to AspirinJunkie@Autoit.de for introducing me to the Dictionary Object. It helped me improve the UDF by alot.
