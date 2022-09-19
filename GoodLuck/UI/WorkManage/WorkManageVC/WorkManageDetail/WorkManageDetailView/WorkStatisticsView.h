//
//  WorkStatisticsView.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/5.
//

#import <UIKit/UIKit.h>
#import "SeletedItemCompent.h"
NS_ASSUME_NONNULL_BEGIN

@interface WorkStatisticsView : UIView
@property (nonatomic, strong) RACSubject *subject;
@property (nonatomic, strong) SeletedItemCompent *itemCompent;
@end

NS_ASSUME_NONNULL_END
