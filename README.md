# CategoryTest
Objective-c Category priority test 

Builder file,
	 creating generic Window instead


Dump the class with categories:

Found 4 methods on 'TestObj'
	[0x100001060] 'TestObj' has method named 'callMe' of encoding 'v16@0:8'
	[0x100001020] 'TestObj' has method named 'callMe' of encoding 'v16@0:8'
	[0x100000fe0] 'TestObj' has method named 'callMe' of encoding 'v16@0:8'
	[0x100001160] 'TestObj' has method named 'callMe' of encoding 'v16@0:8'


=== === Save this output === ===
callMe Category2
=== === end output === ===

Calling ordered methods from the Dispatch table:{
[0x100001060] callMe() => callMe Category2
[0x100001020] callMe() => callMe Category1
[0x100000fe0] callMe() => callMe Category3
[0x100001160] callMe() => 2018-03-30 19:45:16.769072+0300 CategoryTest[93380:13808641] callMe default
}



| Change the ordering of Categories in Target > Build Phases > Compile Sources
| and compare to the previously saved output




Dump the subclass of class with categories
Found 1 methods on 'TestObjSub'
	[0x1000010a0] 'TestObjSub' has method named 'callMe' of encoding 'v16@0:8'
callMe TestObjSub
