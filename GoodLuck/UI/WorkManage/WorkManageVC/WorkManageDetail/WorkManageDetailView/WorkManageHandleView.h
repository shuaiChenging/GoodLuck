//
//  WorkManageHandleView.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/5.
//

#import <UIKit/UIKit.h>
#import "IconNameView.h"
NS_ASSUME_NONNULL_BEGIN

@interface WorkManageHandleView : UIView
@property (nonatomic, strong) IconNameView *infoView;
@property (nonatomic, strong) IconNameView *memberView;
@property (nonatomic, strong) IconNameView *roleView;
@property (nonatomic, strong) IconNameView *workOrderView;
@end

NS_ASSUME_NONNULL_END
