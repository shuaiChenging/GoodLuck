//
//  GLTableView.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GLTableView : UITableView
@property (nonatomic, strong) UILabel *emptyLb;
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style;
- (void)updataPostion;
@end

NS_ASSUME_NONNULL_END
