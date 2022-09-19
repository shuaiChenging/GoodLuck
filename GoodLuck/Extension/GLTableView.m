//
//  GLTableView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/10.
//

#import "GLTableView.h"

@implementation GLTableView


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self)
    {
        [self addSubview:self.emptyLb];
        [_emptyLb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).offset(0);
        }];
    }
    return self;
}

- (UILabel *)emptyLb
{
    if (!_emptyLb)
    {
        _emptyLb = [UILabel labelWithText:@"暂无数据"
                                     font:[UIFont systemFontOfSize:font_14]
                                textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                alignment:NSTextAlignmentCenter];
        _emptyLb.hidden = YES;
    }
    return _emptyLb;
}

- (void)updataPostion
{
    [_emptyLb mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self).offset(158);
    }];
}

@end
