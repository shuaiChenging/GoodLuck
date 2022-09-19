//
//  NSDictionary+Safe.m
//  DDGameSDKDemo
//
//  Created by MHJZ on 2022/4/21.
//

#import "NSDictionary+Safe.h"

@implementation NSDictionary (Safe)
+ (void)load
{
    Method originalMethod = class_getClassMethod(self, @selector(dictionaryWithObjects:forKeys:count:));
    Method swizzledMethod = class_getClassMethod(self, @selector(na_dictionaryWithObjects:forKeys:count:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}
 
+ (instancetype)na_dictionaryWithObjects:(const id [])objects forKeys:(const id <NSCopying> [])keys count:(NSUInteger)cnt
{
    id nObjects[cnt];
    id nKeys[cnt];
    int i=0, j=0;
    for (; i<cnt && j<cnt; i++)
    {
        if (objects[i] && keys[i])
        {
            nObjects[j] = objects[i];
            nKeys[j] = keys[i];
            j++;
        }
    }
    
    return [self na_dictionaryWithObjects:nObjects forKeys:nKeys count:j];
}
@end

@implementation NSMutableDictionary (Safe)
+ (void)load
{
    Class dictCls = NSClassFromString(@"__NSDictionaryM");
    Method originalMethod = class_getInstanceMethod(dictCls, @selector(setObject:forKey:));
    Method swizzledMethod = class_getInstanceMethod(dictCls, @selector(na_setObject:forKey:));
    method_exchangeImplementations(originalMethod, swizzledMethod);
}
 
- (void)na_setObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (!anObject || !aKey)
    {
        return;
    }
    [self na_setObject:anObject forKey:aKey];
}
@end
