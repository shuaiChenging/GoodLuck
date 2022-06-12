//
//  DDDataStorageManage.h
//  DDGameSDKDemo
//
//  Created by MHJZ on 2022/2/18.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface DDDataStorageManage : NSObject
/**
 偏好设置保存字段
 @param obeject 保存的对象
 @param key 保存的key值
 */
+ (void)userDefaultsSaveObject:(id)obeject forKey:(NSString *)key;

/**
 偏好设置获取字段
 @param key 取值的key值
 @return 要获取的对象
 */
+ (id)userDefaultsGetObjectWithKey:(NSString *)key;


/// 存储图片数据
/// @param path 路径
/// @param image 要存储的对象
+ (BOOL)saveDataWithPath:(NSString *)path wihtImg:(UIImage *)image;


/// 获取保存数据的保存路径
/// @param path 路径
+ (NSString *)getSaveDataPath:(NSString *)path;


/// 判断文件是否存在
/// @param filePath 文件路径
+ (BOOL)isFileExistWithFilePath:(NSString *)filePath;
@end

NS_ASSUME_NONNULL_END
