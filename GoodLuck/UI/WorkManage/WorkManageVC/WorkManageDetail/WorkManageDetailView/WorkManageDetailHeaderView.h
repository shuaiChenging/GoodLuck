//
//  WorkManageDetailHeaderView.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/5.
//

#import <UIKit/UIKit.h>
#import "WorkManageHandleView.h"
#import "WorkManageDetalAdmiView.h"
NS_ASSUME_NONNULL_BEGIN

@interface WorkManageDetailHeaderView : UIView
@property (nonatomic, strong) WorkManageHandleView *handleView;
@property (nonatomic, strong) WorkManageDetalAdmiView *admiView;
@end

NS_ASSUME_NONNULL_END
