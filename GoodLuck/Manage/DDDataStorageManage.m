//
//  DDDataStorageManage.m
//  DDGameSDKDemo
//
//  Created by MHJZ on 2022/2/18.
//

#import "DDDataStorageManage.h"

@implementation DDDataStorageManage
+ (void)userDefaultsSaveObject:(id)obeject forKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:obeject forKey:key];
    [defaults synchronize];
}

+ (id)userDefaultsGetObjectWithKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    id object = [defaults objectForKey:key];
    return object;
}

+ (BOOL)saveDataWithPath:(NSString *)path wihtImg:(UIImage *)image
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [paths.firstObject stringByAppendingPathComponent:path];
    BOOL isSuccess = [UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES];
    return isSuccess;
}

+ (NSString *)getSaveDataPath:(NSString *)path
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *filePath = [paths.firstObject stringByAppendingPathComponent:path];
    return filePath;
}

+ (BOOL)isFileExistWithFilePath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    return [fileManager fileExistsAtPath:filePath isDirectory:&isDirectory];
}
@end
