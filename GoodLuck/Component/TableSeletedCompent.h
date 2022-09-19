//
//  TableSeletedCompent.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/8/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TableSeletedCompent : UIView
@property (nonatomic, strong) RACSubject *subject;
- (instancetype)initWithArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
