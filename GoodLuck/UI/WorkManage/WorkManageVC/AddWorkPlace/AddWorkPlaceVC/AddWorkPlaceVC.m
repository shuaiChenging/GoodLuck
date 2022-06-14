//
//  AddWorkPlaceVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/5.
//

#import "AddWorkPlaceVC.h"
#import "InfoInputRightCompent.h"
#import "InfoInputCountCompent.h"
#import "InfoSeletedCompent.h"
#import "UnlitListVC.h"
#import "CompanyListResponse.h"
#import "WorkDetailResponse.h"
@interface AddWorkPlaceVC ()
@property (nonatomic, strong) InfoSeletedCompent *companyAddress;
@property (nonatomic, strong) CompanyListResponse *response;
@property (nonatomic, strong) InfoInputRightCompent *projectName;
@property (nonatomic, strong) InfoSeletedCompent *projectAddress;
@property (nonatomic, strong) InfoInputCountCompent *detailAddress;
@end

@implementation AddWorkPlaceVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [self customerUI];
}

- (InfoInputCountCompent *)detailAddress
{
    if (!_detailAddress)
    {
        _detailAddress = [InfoInputCountCompent new];
        [_detailAddress setName:@"详细地址" placeholder:@"请输入详细地址"];
    }
    return _detailAddress;
}

- (InfoSeletedCompent *)projectAddress
{
    if (!_projectAddress)
    {
        _projectAddress = [InfoSeletedCompent new];
        [_projectAddress setName:@"项目地址" info:@"" defaultInfo:@"请输入项目地址"];
    }
    return _projectAddress;
}

- (InfoSeletedCompent *)companyAddress
{
    if (!_companyAddress)
    {
        _companyAddress = [InfoSeletedCompent new];
        [_companyAddress setName:@"土方单位" info:@"" defaultInfo:@"请输入土方单位"];
    }
    return _companyAddress;
}

- (InfoInputRightCompent *)projectName
{
    if (!_projectName)
    {
        _projectName = [InfoInputRightCompent new];
        [_projectName setName:@"项目名称" placeholder:@"请输入项目名称"];
    }
    return _projectName;
}

- (void)customerUI
{
    UIView *baseView = [UIView new];
    [self.view addSubview:baseView];
    [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(46);
        make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.left.right.equalTo(self.view);
    }];
    UILabel *baseLb = [UILabel labelWithText:@"基本配置（必填）"
                                        font:[UIFont systemFontOfSize:16]
                                   textColor:[UIColor jk_colorWithHexString:@"#666666"]
                                   alignment:NSTextAlignmentLeft];
    [baseView addSubview:baseLb];
    [baseLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(baseView).offset(16);
        make.centerY.equalTo(baseView);
    }];
    
    [self.view addSubview:self.projectName];
    [_projectName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(46);
        make.top.equalTo(baseView.mas_bottom);
        make.left.right.equalTo(self.view);
    }];
    
    UIView *firstLine = [UIView new];
    firstLine.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [self.view addSubview:firstLine];
    [firstLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.projectName.mas_bottom);
    }];
    
    WeakSelf(self)
    [self.projectAddress jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        NSLog(@"来了，老弟");
    }];
    [self.view addSubview:self.projectAddress];
    [_projectAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(46);
        make.top.equalTo(firstLine.mas_bottom);
        make.left.right.equalTo(self.view);
    }];
    
    UIView *secondLine = [UIView new];
    secondLine.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [self.view addSubview:secondLine];
    [secondLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.projectAddress.mas_bottom);
    }];
    
    [self.view addSubview:self.detailAddress];
    [_detailAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(56);
        make.top.equalTo(secondLine.mas_bottom);
        make.left.right.equalTo(self.view);
    }];
    
    UIView *thirdLine = [UIView new];
    thirdLine.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [self.view addSubview:thirdLine];
    [thirdLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.detailAddress.mas_bottom);
    }];
    
    [self.companyAddress jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself showUnlitListVC];
    }];
    [self.view addSubview:_companyAddress];
    [_companyAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(46);
        make.top.equalTo(thirdLine.mas_bottom);
        make.left.right.equalTo(self.view);
    }];
    
    UIView *fourthLine = [UIView new];
    fourthLine.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
    [self.view addSubview:fourthLine];
    [fourthLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.companyAddress.mas_bottom);
    }];
    
    UIButton *button = [UIButton new];
    [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [weakself addWorkPlace];
    }];
    [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    button.backgroundColor = [UIColor blueColor];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.right.equalTo(self.view).offset(-16);
        make.top.equalTo(fourthLine).offset(60);
        make.height.equalTo(46);
    }];
}

- (void)addWorkPlace
{
    PostRequest *request = [[PostRequest alloc] initWithRequestUrl:projectsave argument:@{@"address":@"江苏省",
                                                                                          @"city":@"苏州市",
                                                                                          @"companyId":@"district",
                                                                                          @"district":@"district",
                                                                                          @"latitude":@"district",
                                                                                          @"name":@"district",
                                                                                          @"province":@"district"}];
    WeakSelf(self)
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            
        }
        
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

- (void)loadViewWithProjectId:(NSString *)projectId
{
    WeakSelf(self)
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:projectdetails argument:@{@"id":projectId}];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            WorkDetailResponse *response = [WorkDetailResponse mj_objectWithKeyValues:result[@"data"]];
            [weakself handleData:response];
        }
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

- (void)handleData:(WorkDetailResponse *)response
{
    self.projectName.textField.text = response.name;
    self.projectAddress.infoLb.text = [NSString stringWithFormat:@"%@%@%@",response.province,response.city,response.district];
    self.projectAddress.infoLb.textColor = [UIColor blackColor];
    
    self.detailAddress.textField.text = response.address;
    self.companyAddress.infoLb.text = response.companyName;
    self.companyAddress.infoLb.textColor = [UIColor blackColor];
}

- (void)showUnlitListVC
{
    UnlitListVC *unlitListVC = [UnlitListVC new];
    WeakSelf(self)
    [unlitListVC.subject subscribeNext:^(id  _Nullable x) {
        weakself.response = (CompanyListResponse *)x;
        weakself.companyAddress.infoLb.text = weakself.response.name;
        weakself.companyAddress.infoLb.textColor = [UIColor blackColor];
    }];
    [self presentViewController:unlitListVC animated:YES completion:nil];
}

@end
