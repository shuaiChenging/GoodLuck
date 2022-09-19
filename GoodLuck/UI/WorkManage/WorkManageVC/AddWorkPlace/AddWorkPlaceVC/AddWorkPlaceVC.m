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
#import "SearchAroundVC.h"
#import <AMapSearchKit/AMapSearchKit.h>
@interface AddWorkPlaceVC ()
@property (nonatomic, strong) InfoSeletedCompent *companyAddress;
@property (nonatomic, strong) CompanyListResponse *response;
@property (nonatomic, strong) InfoInputRightCompent *projectName;
@property (nonatomic, strong) InfoSeletedCompent *projectAddress;
@property (nonatomic, strong) InfoInputCountCompent *detailAddress;
@property (nonatomic, strong) AMapPOI *ampaPOI;
@property (nonatomic, strong) NSString *projectId;
@property (nonatomic, assign) CGFloat latitude;
@property (nonatomic, assign) CGFloat longitude;
@end

@implementation AddWorkPlaceVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
    self.ampaPOI = [AMapPOI new];
    self.response = [CompanyListResponse new];
    [self customerUI];
}

- (RACSubject *)subject
{
    if (!_subject)
    {
        _subject = [RACSubject new];
    }
    return _subject;
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
                                        font:[UIFont systemFontOfSize:14]
                                   textColor:[UIColor jk_colorWithHexString:@"#989898"]
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
    firstLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [self.view addSubview:firstLine];
    [firstLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.projectName.mas_bottom);
    }];
    
    WeakSelf(self)
    [self.projectAddress jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        SearchAroundVC *searchAroundVC = [SearchAroundVC new];
        [searchAroundVC.subject subscribeNext:^(id  _Nullable x) {
            weakself.ampaPOI = (AMapPOI *)x;
            weakself.longitude = weakself.ampaPOI.location.longitude;
            weakself.latitude = weakself.ampaPOI.location.latitude;
            weakself.projectAddress.infoLb.text = [NSString stringWithFormat:@"%@%@%@",weakself.ampaPOI.province,weakself.ampaPOI.city,weakself.ampaPOI.district];
            weakself.projectAddress.infoLb.textColor = [UIColor jk_colorWithHexString:COLOR_242424];
            weakself.detailAddress.textField.text = weakself.ampaPOI.address;
            weakself.detailAddress.numberLb.text = [NSString stringWithFormat:@"%lu/50",(unsigned long)weakself.ampaPOI.address.length];
        }];
        [weakself.navigationController pushViewController:searchAroundVC animated:YES];
    }];
    [self.view addSubview:self.projectAddress];
    [_projectAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(46);
        make.top.equalTo(firstLine.mas_bottom);
        make.left.right.equalTo(self.view);
    }];
    
    UIView *secondLine = [UIView new];
    secondLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
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
    thirdLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
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
    fourthLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
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
    button.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
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
    NSString *url = projectsave;
    NSDictionary *dic = @{@"address":self.detailAddress.textField.text,
                          @"city":self.ampaPOI.city,
                     @"companyId":self.response.companyId,
                      @"district":self.ampaPOI.district,
                      @"latitude":@(self.latitude),
                     @"longitude":@(self.longitude),
                          @"name":self.projectName.textField.text,
                      @"province":self.ampaPOI.province};
    if (![Tools isEmpty:self.projectId])
    {
        url = projectedit;
        dic = @{@"address":self.detailAddress.textField.text,
                     @"id":self.projectId,
                   @"city":self.ampaPOI.city,
              @"companyId":self.response.companyId,
               @"district":self.ampaPOI.district,
               @"latitude":@(self.latitude),
              @"longitude":@(self.longitude),
                   @"name":self.projectName.textField.text,
               @"province":self.ampaPOI.province};
    }
    PostRequest *request = [[PostRequest alloc] initWithRequestUrl:url argument:dic];
    WeakSelf(self)
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            [weakself.subject sendNext:@"1"];
            [weakself.navigationController popViewControllerAnimated:YES];
        }
        
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

- (void)loadViewWithProjectId:(NSString *)projectId
{
    WeakSelf(self)
    self.projectId = projectId;
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
    
    self.ampaPOI.city = response.city;
    self.ampaPOI.district = response.district;
    self.latitude = [response.latitude floatValue];
    self.longitude = [response.longitude floatValue];
    
    self.ampaPOI.province = response.province;
    self.response.companyId = response.companyId;
    
    self.detailAddress.textField.text = response.address;
    self.detailAddress.numberLb.text = [NSString stringWithFormat:@"%lu/50",(unsigned long)response.address.length];
    self.companyAddress.infoLb.text = response.companyName;
    self.companyAddress.infoLb.textColor = [UIColor blackColor];
}

- (void)showUnlitListVC
{
    UnlitListVC *unlitListVC = [UnlitListVC new];
    unlitListVC.companyId = self.response.companyId;
    WeakSelf(self)
    [unlitListVC.subject subscribeNext:^(id  _Nullable x) {
        weakself.response = (CompanyListResponse *)x;
        weakself.companyAddress.infoLb.text = weakself.response.name;
        weakself.companyAddress.infoLb.textColor = [UIColor jk_colorWithHexString:COLOR_242424];
    }];
    [self presentViewController:unlitListVC animated:YES completion:nil];
}

@end
