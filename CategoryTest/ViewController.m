//
//  ViewController.m
//  CategoryTest
//
//  Created by Andrii Tischenko on 3/30/18.
//  Copyright © 2018 Andrii Tischenko. All rights reserved.
//

#import "ViewController.h"
#import "TestObj.h"
#import "TestObjSub.h"
#import <objc/runtime.h>

//#import "TestObj+Category3.h"
//#import "TestObj+Category1.h"
//#import "TestObj+Category2.h"



@implementation ViewController


void DumpObjcMethods(Class clz) {
  
  unsigned int methodCount = 0;
  Method *methods = class_copyMethodList(clz, &methodCount);
  
  printf("Found %d methods on '%s'\n", methodCount, class_getName(clz));
  for (unsigned int i = 0; i < methodCount; i++) {
    Method method = methods[i];
    
    SEL sel = method_getName(method);
    IMP imp = method_getImplementation(method);
    
    void (*functionPointer)(id, SEL) = (void (*)(id, SEL))imp;

//      Stop here and look at the 'functionPointer'
    printf("\t[%p] '%s' has method named '%s' of encoding '%s'\n",
           functionPointer,
           class_getName(clz),
           sel_getName(sel),
           method_getTypeEncoding(method));
  }
  
  free(methods);
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  printf("%s","\n\nDump the class with categories:\n\n");
  
  DumpObjcMethods([TestObj class]);
  TestObj*t  = [TestObj new];
  
  printf("%s","\n\n=== === Save this output === ===\n");
  [t callMe]; // <- this method will be called from the latest implementation of category.
  printf("%s","=== === end output === ===\n");
  
  /*
   STOP HERE AND TRY
   replase 0x1000010c0 with adress from Dump
   
   (lldb) ex ((void(*)(id, SEL))0x1000010c0)(t, @selector(callMe))
   */
  
  //Lets call all available methods:
  printf("%s","\nCalling ordered methods from the Dispatch table:{\n");
  Class clz = object_getClass(t);
  unsigned int methodCount = 0;
  Method *methods = class_copyMethodList(clz, &methodCount);
  for (unsigned int i = 0; i < methodCount; i++) {
    Method method = methods[i];
    SEL sel = method_getName(method);
    IMP imp = method_getImplementation(method);
    void (*functionPointer)(id, SEL) = (void (*)(id, SEL))imp;
    printf("[%p] %s() => ",functionPointer,sel_getName(sel));
    functionPointer(t, sel);
  }
  
  free(methods);
  printf("%s","}\n\n");
  
  
  printf("%s","\n\n| Change the ordering of Categories in Target > Build Phases > Compile Sources");
  printf("%s","\n| and compare to the previously saved output\n\n\n");

  
  printf("%s","\n\nDump the subclass of class with categories\n");
  DumpObjcMethods([TestObjSub class]);
  TestObjSub*t2  = [TestObjSub new];
  [t2 callMe];
  

  
//  {
//      //lets do more calls:
//      void (*func)(id, SEL);
//      int i;
//      printf("%s","\n\n\n");
//      func = (void (*)(id, SEL))[t methodForSelector:@selector(callMe)];
//      for ( i = 0 ; i < 1000 ; i++ )
//        func(t, @selector(callMe));
//  }
}



- (void)setRepresentedObject:(id)representedObject {
  [super setRepresentedObject:representedObject];

  // Update the view, if already loaded.
}


@end
