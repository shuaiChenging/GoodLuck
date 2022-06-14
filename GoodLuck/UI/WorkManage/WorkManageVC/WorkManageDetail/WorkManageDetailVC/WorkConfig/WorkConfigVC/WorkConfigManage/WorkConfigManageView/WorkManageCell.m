//
//  WorkManageCell.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/11.
//

#import "WorkManageCell.h"
#import "WorkConfigManageResponse.h"
@interface WorkManageCell ()
@property (nonatomic, strong) UILabel *leftLb;
@property (nonatomic, strong) UILabel *rightLb;
@property (nonatomic, strong) NSArray *dataArr;
@end
@implementation WorkManageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self customerUI];
    }
    
    return self;
}

- (UILabel *)leftLb
{
    if (!_leftLb)
    {
        _leftLb = [UILabel labelWithText:@""
                                    font:[UIFont systemFontOfSize:14]
                               textColor:[UIColor blackColor]
                               alignment:NSTextAlignmentCenter];
        _leftLb.userInteractionEnabled = YES;
        _leftLb.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    }
    return _leftLb;
}

- (UILabel *)rightLb
{
    if (!_rightLb)
    {
        _rightLb = [UILabel labelWithText:@""
                                     font:[UIFont systemFontOfSize:14]
                                textColor:[UIColor blackColor]
                                alignment:NSTextAlignmentCenter];
        _rightLb.userInteractionEnabled = YES;
        _rightLb.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    }
    return _rightLb;
}

+ (instancetype)cellWithCollectionView:(UITableView *)tableView
{
    WorkManageCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    return cell;
}

- (void)customerUI
{
    [self.contentView addSubview:self.leftLb];
    WeakSelf(self)
    [_leftLb jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself handleClick:0];
    }];
    [_leftLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView.mas_centerX).offset(-8);
        make.height.equalTo(40);
        make.top.equalTo(self.contentView).offset(6);
    }];
    
    [self.contentView addSubview:self.rightLb];
    [_rightLb jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself handleClick:1];
    }];
    [_rightLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_centerX).offset(8);
        make.top.equalTo(self.leftLb);
        make.height.equalTo(40);
        make.right.equalTo(self.contentView).offset(-16);
    }];
}

- (void)handleClick:(int)index
{
    if (index == 0)
    {
        WorkConfigManageResponse *response = self.dataArr.firstObject;
        if (!response.isSelected)
        {
            return;
        }
        if (self.manageDelete)
        {
            self.manageDelete(response.workId);
        }
    }
    else
    {
        WorkConfigManageResponse *response = self.dataArr.lastObject;
        if (!response.isSelected)
        {
            return;
        }
        if (self.manageDelete)
        {
            self.manageDelete(response.workId);
        }
    }
}


- (void)loadViewWithArray:(NSArray *)array
{
    self.dataArr = array;
    if (array.count > 0)
    {
        WorkConfigManageResponse *response = array.firstObject;
        self.leftLb.text = response.name;
        _leftLb.backgroundColor = response.isSelected ? [UIColor redColor] : [UIColor jk_colorWithHexString:@"#eeeeee"];
    }
    
    if (array.count > 1)
    {
        WorkConfigManageResponse *response = array.lastObject;
        self.rightLb.text = response.name;
        _rightLb.backgroundColor = response.isSelected ? [UIColor redColor] : [UIColor jk_colorWithHexString:@"#eeeeee"];
    }
    _leftLb.hidden = array.count == 0;
    _rightLb.hidden = array.count < 2;
}

@end
