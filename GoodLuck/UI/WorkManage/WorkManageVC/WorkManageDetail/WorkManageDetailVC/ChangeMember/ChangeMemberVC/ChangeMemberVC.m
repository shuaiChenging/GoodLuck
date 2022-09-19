//
//  ChangeMemberVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/6.
//

#import "ChangeMemberVC.h"

@interface ChangeMemberVC ()
@property (nonatomic, strong) UIImageView *iconImg;
@property (nonatomic, strong) UILabel *nameLb;
@end

@implementation ChangeMemberVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"修改工地管理员";
    self.view.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
    [self customerUI];
}

- (UIImageView *)iconImg
{
    if (!_iconImg)
    {
        _iconImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_seleted_admin"]];
    }
    return _iconImg;
}

- (RACSubject *)subject
{
    if (!_subject)
    {
        _subject = [RACSubject new];
    }
    return _subject;
}

- (UILabel *)nameLb
{
    if (!_nameLb)
    {
        _nameLb = [UILabel labelWithText:self.response.name
                                     font:[UIFont systemFontOfSize:14]
                                textColor:[UIColor blackColor]
                               alignment:NSTextAlignmentLeft];
    }
    return _nameLb;
}

- (void)customerUI
{
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.right.equalTo(self.view).offset(-16);
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop).offset(14);
        make.height.equalTo(80);
    }];
    
    UIButton *button = [UIButton new];
    [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [button setTitle:@"移除" forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    button.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.right.equalTo(self.view).offset(-16);
        make.top.equalTo(backView.mas_bottom).offset(40);
        make.height.equalTo(46);
    }];
    WeakSelf(self)
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakself deleteAdmin];
    }];
    
    [backView addSubview:self.iconImg];
    [_iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(54);
        make.left.equalTo(backView).offset(16);
        make.centerY.equalTo(backView);
    }];
    
    [backView addSubview:self.nameLb];
    [_nameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImg.mas_right).offset(20);
        make.centerY.equalTo(backView);
    }];
    
    UIImageView *phoneIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"manage_detail_phone_default"]];
    phoneIcon.userInteractionEnabled = YES;
    [phoneIcon jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"tel:%@",weakself.response.phone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:nil];
    }];
    [backView addSubview:phoneIcon];
    [phoneIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(20);
        make.right.equalTo(backView).offset(-16);
        make.centerY.equalTo(backView);
    }];
    
}

- (void)deleteRequest
{
    WeakSelf(self)
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:deleteadmin argument:@{@"phone":self.response.phone,@"projectId":self.projectId}];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            [weakself.subject sendNext:@"1"];
            [weakself.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

- (void)deleteAdmin
{
    WeakSelf(self)
    [Tools showAlertWithTitle:@"移除提示"
                      content:[NSString stringWithFormat:@"确认要移除工地管理员%@?",self.response.name]
                         left:@"取消"
                        right:@"确认" block:^{
        [weakself deleteRequest];
    }];
}

@end
