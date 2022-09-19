//
//  WorkManageDetailFooterView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/8/30.
//

#import "WorkManageDetailFooterView.h"

@implementation WorkManageDetailFooterView

+ (instancetype)cellWithTableViewHeaderFooterView:(UITableView *)tableView
{
    WorkManageDetailFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass(self)];
    return footerView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        
    }
    return self;
}

@end
