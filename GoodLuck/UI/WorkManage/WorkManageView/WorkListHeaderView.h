//
//  WorkListHeaderView.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/4.
//

#import <UIKit/UIKit.h>
#import "WorkAddView.h"
#import "WorkListResponse.h"
NS_ASSUME_NONNULL_BEGIN

@interface WorkListHeaderView : UIView
@property (nonatomic, strong) WorkAddView *workAddView;
@property (nonatomic, strong) UILabel *detailLb;
@property (nonatomic, copy) NSString *dateStr;
@property (nonatomic, strong) RACSubject *subject;
- (void)loadViewWithModel:(WorkListResponse *)model;
@end

NS_ASSUME_NONNULL_END
