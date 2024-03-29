//
//  NSArray+Safe.m
//  DDGameSDKDemo
//
//  Created by MHJZ on 2022/4/21.
//

#import "NSArray+Safe.h"

@implementation NSArray (Safe)
+ (void)load
{
    Method originalMethod = class_getClassMethod(self, @selector(arrayWithObjects:count:));
    Method swizzledMethod = class_getClassMethod(self, @selector(na_arrayWithObjects:count:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}
 
+ (instancetype)na_arrayWithObjects:(const id [])objects count:(NSUInteger)cnt
{
    id nObjects[cnt];
    int i=0, j=0;
    for (; i<cnt && j<cnt; i++)
    {
        if (objects[i])
        {
            nObjects[j] = objects[i];
            j++;
        }
    }
    
    return [self na_arrayWithObjects:nObjects count:j];
}
@end

@implementation NSMutableArray (Safe)

+ (void)load
{
    Class arrayCls = NSClassFromString(@"__NSArrayM");
    
    Method originalMethod1 = class_getInstanceMethod(arrayCls, @selector(insertObject:atIndex:));
    Method swizzledMethod1 = class_getInstanceMethod(arrayCls, @selector(na_insertObject:atIndex:));
    method_exchangeImplementations(originalMethod1, swizzledMethod1);
    
    Method originalMethod2 = class_getInstanceMethod(arrayCls, @selector(setObject:atIndex:));
    Method swizzledMethod2 = class_getInstanceMethod(arrayCls, @selector(na_setObject:atIndex:));
    method_exchangeImplementations(originalMethod2, swizzledMethod2);
}
 
- (void)na_insertObject:(id)anObject atIndex:(NSUInteger)index
{
    if (!anObject)
    {
        return;
    }
    [self na_insertObject:anObject atIndex:index];
}
 
- (void)na_setObject:(id)anObject atIndex:(NSUInteger)index
{
    if (!anObject)
    {
        return;
    }
    [self na_setObject:anObject atIndex:index];
}

@end
