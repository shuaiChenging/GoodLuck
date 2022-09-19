//
//  WorkOrderDetailChangeVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/4.
//

#import "WorkOrderDetailChangeVC.h"
#import "YTKBatchRequest.h"
#import "CarSizeModel.h"
#import "WorkConfigManageResponse.h"
#import "InfoSeletedCompent.h"
#import "InfoInputRightCompent.h"
#import "CarListVC.h"
@interface WorkOrderDetailChangeVC ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) CarSizeModel *seletedCarSize;
@property (nonatomic, strong) NSMutableArray *carSizeArr;
@property (nonatomic, strong) NSArray<WorkConfigManageResponse *> *soilArr;

@property (nonatomic, strong) WorkConfigManageResponse *seletedSoil;
@property (nonatomic, strong) WorkConfigManageResponse *seletedsSoil;
@property (nonatomic, strong) WorkConfigManageResponse *seletedClass;

@property (nonatomic, strong) NSMutableArray<WorkConfigManageResponse *> *dsoilArr;
@property (nonatomic, strong) NSArray<WorkConfigManageResponse *> *classArr;

@property (nonatomic, strong) NSMutableArray *carLabs;
@property (nonatomic, strong) NSMutableArray *soilLabs;
@property (nonatomic, strong) NSMutableArray *dsoilLabs;
@property (nonatomic, strong) NSMutableArray *classLabs;

@property (nonatomic, strong) InfoSeletedCompent *carTeamName;
@property (nonatomic, strong) InfoInputRightCompent *driveInput;
@property (nonatomic, strong) InfoInputRightCompent *priceInput;

@property (nonatomic, strong) InfoInputRightCompent *remarkInput;
@property (nonatomic, strong) UILabel *carLb;
@property (nonatomic, strong) UILabel *outTimeLb;

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *numberLb;
@property (nonatomic, strong) UILabel *textLb;

@property (nonatomic, assign) BOOL isChange;
@property (nonatomic, strong) GLTextField *weightTF;

@property (nonatomic, strong) GLTextField *sizeTF;
@property (nonatomic, assign) BOOL isOtherSize;

@property (nonatomic, strong) WorkConfigManageResponse *carTeamResponse;
@end

@implementation WorkOrderDetailChangeVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"修改工单";
    self.isChange = self.orderDetailResponse.weight > 0;
    BOOL dayStatus = [self.orderDetailResponse.workType isEqualToString:@"DAY_WORK"];
    
    WorkConfigManageResponse *dayWork = [WorkConfigManageResponse new];
    dayWork.name = @"白班";
    dayWork.status = @"DAY_WORK";
    dayWork.isSelected = dayStatus;
    
    WorkConfigManageResponse *nightWork = [WorkConfigManageResponse new];
    nightWork.name = @"晚班";
    nightWork.status = @"NIGHT_WORK";
    nightWork.isSelected = !dayStatus;
    
    self.seletedClass = dayStatus ? dayWork : nightWork;
    
    self.classArr = @[dayWork, nightWork];
    
    self.carTeamResponse.name = self.orderDetailResponse.fleetName;
    self.carTeamResponse.workId = self.orderDetailResponse.fleetId;
    
    self.carSizeArr = [NSMutableArray arrayWithCapacity:0];
    self.dsoilArr = [NSMutableArray arrayWithCapacity:0];
    
    self.carLabs = [NSMutableArray arrayWithCapacity:0];
    self.soilLabs = [NSMutableArray arrayWithCapacity:0];
    self.dsoilLabs = [NSMutableArray arrayWithCapacity:0];
    self.classLabs = [NSMutableArray arrayWithCapacity:0];
    
    [self getDate];
    
}

- (GLTextField *)weightTF
{
    if (!_weightTF)
    {
        _weightTF = [GLTextField new];
        [_weightTF placeHolderString:@"输入"];
        _weightTF.text = self.isChange ? [NSString stringWithFormat:@"%d",self.orderDetailResponse.weight] : @"";
        _weightTF.textAlignment = NSTextAlignmentCenter;
        _weightTF.textColor = [UIColor whiteColor];
        _weightTF.font = [UIFont systemFontOfSize:font_13];
    }
    return _weightTF;
}

- (GLTextField *)sizeTF
{
    if (!_sizeTF)
    {
        _sizeTF = [GLTextField new];
        [_sizeTF placeHolderString:@"输入"];
        _sizeTF.text = self.isOtherSize ? self.orderDetailResponse.bodySize : @"";
        _sizeTF.textAlignment = NSTextAlignmentCenter;
        _sizeTF.textColor = [UIColor whiteColor];
        _sizeTF.font = [UIFont systemFontOfSize:font_13];
    }
    return _sizeTF;
}

- (RACSubject *)subject
{
    if (!_subject)
    {
        _subject = [RACSubject new];
    }
    return _subject;
}

- (WorkConfigManageResponse *)carTeamResponse
{
    if (!_carTeamResponse)
    {
        _carTeamResponse = [WorkConfigManageResponse new];
    }
    return _carTeamResponse;
}

- (UILabel *)textLb
{
    if (!_textLb)
    {
        _textLb = [UILabel labelWithText:@"请输入修改原因(必填)"
                                    font:[UIFont systemFontOfSize:font_14]
                               textColor:[UIColor jk_colorWithHexString:@"#cccccc"]
                               alignment:NSTextAlignmentLeft];
    }
    return _textLb;
}

- (UITextView *)textView
{
    if (!_textView)
    {
        _textView = [UITextView new];
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.font = [UIFont systemFontOfSize:font_14];
        _textView.text = self.orderDetailResponse.exception;
        _textView.textColor = [UIColor jk_colorWithHexString:COLOR_242424];
    }
    return _textView;
}

- (UILabel *)numberLb
{
    if (!_numberLb)
    {
        _numberLb = [UILabel labelWithText:[NSString stringWithFormat:@"%ld/50",self.orderDetailResponse.exception.length]
                                      font:[UIFont systemFontOfSize:font_12]
                                 textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                 alignment:NSTextAlignmentRight];
    }
    return _numberLb;
}

- (UILabel *)outTimeLb
{
    if (!_outTimeLb)
    {
        _outTimeLb = [UILabel labelWithText:[NSString stringWithFormat:@"出场放行时间：%@",self.orderDetailResponse.outReleaserTime]
                                       font:[UIFont systemFontOfSize:font_12]
                                  textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                  alignment:NSTextAlignmentCenter];
    }
    return _outTimeLb;
}

- (UILabel *)carLb
{
    if (!_carLb)
    {
        _carLb = [UILabel labelWithText:self.orderDetailResponse.plateNumber
                                   font:[UIFont boldSystemFontOfSize:24]
                              textColor:[UIColor jk_colorWithHexString:COLOR_BLUE]
                              alignment:NSTextAlignmentCenter];
    }
    return _carLb;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        _scrollView = [UIScrollView new];
        _scrollView.backgroundColor = [UIColor whiteColor];
    }
    return _scrollView;
}

- (InfoInputRightCompent *)priceInput
{
    if (!_priceInput)
    {
        _priceInput = [InfoInputRightCompent new];
        [_priceInput setName:@"价格" placeholder:@""];
        _priceInput.textField.text = @"0";
        _priceInput.userInteractionEnabled = NO;
    }
    return _priceInput;
}

- (InfoSeletedCompent *)carTeamName
{
    if (!_carTeamName)
    {
        _carTeamName = [InfoSeletedCompent new];
        [_carTeamName setName:@"车队名称" info:self.orderDetailResponse.fleetName defaultInfo:@"请选择车队名称"];
    }
    return _carTeamName;
}

- (InfoInputRightCompent *)driveInput
{
    if (!_driveInput)
    {
        _driveInput = [InfoInputRightCompent new];
        [_driveInput setName:@"司机" placeholder:@"请输入司机名字"];
        _driveInput.textField.text = self.orderDetailResponse.driverName;
    }
    return _driveInput;
}

- (InfoInputRightCompent *)remarkInput
{
    if (!_remarkInput)
    {
        _remarkInput = [InfoInputRightCompent new];
        [_remarkInput setName:@"备注" placeholder:@"请输入（最多50个字）"];
        _remarkInput.textField.text = self.orderDetailResponse.remark;
    }
    return _remarkInput;
}

- (void)getDate
{
    GetRequest *carManageRequest = [[GetRequest alloc] initWithRequestUrl:bodysizeall argument:@{}];
    GetRequest *soilRequest = [[GetRequest alloc] initWithRequestUrl:tlxquery argument:@{@"projectId":self.projectId}];
    GetRequest *ztcRequest = [[GetRequest alloc] initWithRequestUrl:ztcquery argument:@{@"projectId":self.projectId}];
    YTKBatchRequest *batchRequest = [[YTKBatchRequest alloc] initWithRequestArray:@[carManageRequest,soilRequest,ztcRequest]];
    WeakSelf(self)
    [batchRequest startWithCompletionBlockWithSuccess:^(YTKBatchRequest * _Nonnull batchRequest) {
        NSArray *requests = batchRequest.requestArray;
        GetRequest *carManageRequest = (GetRequest *)requests[0];
        GetRequest *soilRequest = (GetRequest *)requests[1];
        GetRequest *ztcRequest = (GetRequest *)requests[2];
        
        [weakself carManageHandle:carManageRequest];
        [weakself soilHandle:soilRequest];
        [weakself dSoilHandle:ztcRequest];

    } failure:^(YTKBatchRequest * _Nonnull batchRequest) {
        
    }];
}

- (void)carManageHandle:(GetRequest *)request
{
    NSDictionary *carResult = [request responseJSONObject];
    BOOL isCarSuccess = [[carResult objectForKey:@"code"] intValue] == 200;
    if (isCarSuccess)
    {
        NSArray *result = carResult[@"data"];
        BOOL hasSeleted = NO;
        for (int i = 0; i < result.count; i++)
        {
            NSString *name = [NSString stringWithFormat:@"%@方",result[i]];
            if ([result[i] intValue] == 0)
            {
                name = @"其他";
            }
            BOOL isSeleted = [[NSString stringWithFormat:@"%@",result[i]] isEqualToString:self.orderDetailResponse.bodySize];
            CarSizeModel *model = [[CarSizeModel alloc] initWithName:name isSeleted:isSeleted size:result[i]];
            if (isSeleted)
            {
                self.seletedCarSize = model;
                hasSeleted = YES;
            }
            [self.carSizeArr addObject:model];
        }
        
        if (!hasSeleted && self.orderDetailResponse.weight == 0)
        {
            CarSizeModel *model = self.carSizeArr.lastObject;
            model.isSeleted = YES;
            self.isOtherSize = YES;
        }
    }
    
    
}

- (void)soilHandle:(GetRequest *)request
{
    NSDictionary *carResult = [request responseJSONObject];
    BOOL isCarSuccess = [[carResult objectForKey:@"code"] intValue] == 200;
    if (isCarSuccess)
    {
        self.soilArr = [WorkConfigManageResponse mj_objectArrayWithKeyValuesArray:carResult[@"data"]];
        for (WorkConfigManageResponse *response in self.soilArr)
        {
            BOOL isSelected = [response.name isEqualToString:self.orderDetailResponse.tlxName];
            response.isSelected = isSelected;
            if (isSelected)
            {
                self.seletedSoil = response;
            }
        }
    }
}

- (void)dSoilHandle:(GetRequest *)request
{
    NSDictionary *carResult = [request responseJSONObject];
    BOOL isCarSuccess = [[carResult objectForKey:@"code"] intValue] == 200;
    if (isCarSuccess)
    {
        self.dsoilArr = [WorkConfigManageResponse mj_objectArrayWithKeyValuesArray:carResult[@"data"]];
        BOOL hasSeleted = NO;
        for (WorkConfigManageResponse *workResponse in self.dsoilArr)
        {
            BOOL isSeleted = [workResponse.name isEqualToString:self.orderDetailResponse.ztcName];
            workResponse.isSelected = isSeleted;
            if (isSeleted)
            {
                hasSeleted = YES;
            }
        }
        
        WorkConfigManageResponse *response = [WorkConfigManageResponse new];
        response.name = @"自倒";
        response.isSelected = !hasSeleted;
        response.workId = @"-1";
        self.seletedsSoil = response;
        [self.dsoilArr insertObject:response atIndex:0];
    }
    [self customerUI];
}

- (void)customerUI
{
    WeakSelf(self)
    UIView *footView = [UIView new];
    footView.userInteractionEnabled = YES;
    footView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
    [self.view addSubview:footView];
    [footView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(60);
        make.bottom.equalTo(self.view.safeAreaLayoutGuideBottom);
    }];
    
    UILabel *printLb = [UILabel labelWithText:@"确定"
                                         font:[UIFont boldSystemFontOfSize:16]
                                    textColor:[UIColor whiteColor]
                                    alignment:NSTextAlignmentCenter];
    printLb.userInteractionEnabled = YES;
    [printLb jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself saveRequest];
    }];
    printLb.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
    [footView addSubview:printLb];
    [printLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(footView).offset(16);
        make.right.equalTo(footView).offset(-16);
        make.top.equalTo(footView).offset(10);
        make.bottom.equalTo(footView).offset(-10);
    }];
    
    [self.view addSubview:self.scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(footView.mas_top);
    }];
    
    UIView *topView = [UIView new];
    [_scrollView addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scrollView);
        make.left.right.equalTo(self.view);
        make.height.equalTo(90);
    }];
    
    UIView *topLine = [UIView new];
    topLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [topView addSubview:topLine];
    [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(topView);
        make.height.equalTo(0.5);
    }];
    
    [topView addSubview:self.carLb];
    [_carLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topView);
        make.top.equalTo(topLine.mas_bottom).offset(12);
    }];
    
    UILabel *carNameLb = [UILabel labelWithText:@"车牌："
                                           font:[UIFont systemFontOfSize:font_14]
                                      textColor:[UIColor jk_colorWithHexString:COLOR_BLUE]
                                      alignment:NSTextAlignmentRight];
    [topView addSubview:carNameLb];
    [carNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.carLb.mas_left);
        make.bottom.equalTo(self.carLb);
    }];
    
    UIView *topSecondLine = [UIView new];
    topSecondLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [topView addSubview:topSecondLine];
    [topSecondLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(topView);
        make.top.equalTo(self.carLb.mas_bottom).offset(12);
        make.height.equalTo(0.5);
    }];
    
    [topView addSubview:self.outTimeLb];
    [_outTimeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topSecondLine.mas_bottom).offset(10);
        make.centerX.equalTo(topView);
    }];
    
    UIView *grayLine = [UIView new];
    grayLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
    [_scrollView addSubview:grayLine];
    [grayLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topView.mas_bottom);
        make.height.equalTo(10);
        make.left.right.equalTo(self.view);
    }];
    
    UILabel *carSizeTitleLb = [UILabel labelWithText:@"车斗大小"
                                                font:[UIFont boldSystemFontOfSize:14]
                                           textColor:[UIColor blackColor]
                                           alignment:NSTextAlignmentLeft];
    [_scrollView addSubview:carSizeTitleLb];
    [carSizeTitleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(grayLine.mas_bottom).offset(20);
        make.left.equalTo(self.view).offset(16);
    }];
    
    UIView *changeView = [UIView new];
    changeView.hidden = !self.isChange;
    changeView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
    [_scrollView addSubview:changeView];
    [changeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(carSizeTitleLb.mas_bottom).offset(20);
        make.left.equalTo(carSizeTitleLb).offset(16);
        make.height.equalTo(30);
        make.width.equalTo(100);
    }];
    
    UILabel *dunLb = [UILabel labelWithText:@"吨"
                                       font:[UIFont systemFontOfSize:font_13]
                                  textColor:[UIColor whiteColor]
                                  alignment:NSTextAlignmentRight];
    [changeView addSubview:dunLb];
    [dunLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(changeView).offset(-6);
        make.centerY.equalTo(changeView);
        make.width.equalTo(12);
    }];
    
    [changeView addSubview:self.weightTF];
    [_weightTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(changeView);
        make.left.equalTo(changeView).offset(6);
        make.right.equalTo(dunLb.mas_left);
    }];
    
    UIView *carContentView = [UIView new];
    carContentView.hidden = self.isChange;
    UIView *carLine = [UIView new];
    
    UIView *sizeContentView = [UIView new];
    sizeContentView.hidden = !self.isOtherSize;
    sizeContentView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
    UILabel *fangLb = [UILabel labelWithText:@"方"
                                       font:[UIFont systemFontOfSize:font_13]
                                  textColor:[UIColor whiteColor]
                                  alignment:NSTextAlignmentRight];
    [sizeContentView addSubview:fangLb];
    [fangLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(sizeContentView).offset(-6);
        make.centerY.equalTo(sizeContentView);
        make.width.equalTo(12);
    }];
    
    [sizeContentView addSubview:self.sizeTF];
    [_sizeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(sizeContentView);
        make.left.equalTo(sizeContentView).offset(6);
        make.right.equalTo(fangLb.mas_left);
    }];
    
    
    
    UILabel *changLb = [UILabel labelWithText:@"切换重量"
                                         font:[UIFont systemFontOfSize:font_12]
                                    textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                    alignment:NSTextAlignmentLeft];
    changLb.userInteractionEnabled = YES;
    [changLb jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        weakself.isChange = !weakself.isChange;
        carContentView.hidden = weakself.isChange;
        changeView.hidden = !weakself.isChange;
        if (weakself.isChange)
        {
            [carLine mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(0.5);
                make.left.right.equalTo(self.view);
                make.top.equalTo(changeView.mas_bottom).offset(20);
            }];
        }
        else
        {
            [carLine mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(0.5);
                make.left.right.equalTo(self.view);
                make.top.equalTo(carContentView.mas_bottom).offset(20);
            }];
        }
    }];
    [_scrollView addSubview:changLb];
    [changLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(carSizeTitleLb.mas_right).offset(10);
        make.bottom.equalTo(carSizeTitleLb);
    }];
    
    carContentView.backgroundColor = [UIColor whiteColor];
    [_scrollView addSubview:carContentView];
    
    UILabel *lastLb;
    for(int i = 0; i < self.carSizeArr.count; i++)
    {
        CarSizeModel *model = self.carSizeArr[i];
        UILabel *label = [UILabel labelWithText:model.name
                                           font:[UIFont systemFontOfSize:13]
                                      textColor:[UIColor blackColor]
                                      alignment:NSTextAlignmentCenter];
        label.userInteractionEnabled = YES;
        [label jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            [weakself carLbChange:i];
            weakself.isOtherSize = i == weakself.carSizeArr.count - 1;
            sizeContentView.hidden = !weakself.isOtherSize;
        }];
        label.textColor = model.isSeleted ? [UIColor whiteColor] : [UIColor blackColor];
        label.backgroundColor = model.isSeleted ? [UIColor jk_colorWithHexString:COLOR_BLUE] : [UIColor jk_colorWithHexString:COLOR_BACK];
        [carContentView addSubview:label];
        [self.carLabs addObject:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0)
            {
                make.left.equalTo(self.view).offset(16);
                make.top.equalTo(carContentView).offset(20);
            }
            else if (i % 3 == 0)
            {
                make.left.equalTo(self.view).offset(16);
                make.top.equalTo(lastLb.mas_bottom).offset(10);
            }
            else
            {
                make.left.equalTo(lastLb.mas_right).offset(20);
                make.top.equalTo(lastLb);
            }
            make.height.equalTo(30);
            make.width.equalTo((kScreenWidth - 32 - 40)/3);
        }];
        lastLb = label;
    }
    [carContentView addSubview:sizeContentView];
    [sizeContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(lastLb);
    }];
    
    [carContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(carSizeTitleLb.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(lastLb);
    }];
    
    carLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [_scrollView addSubview:carLine];
    [carLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.right.equalTo(self.view);
        if (self.isChange)
        {
            make.top.equalTo(changeView.mas_bottom).offset(20);
        }
        else
        {
            make.top.equalTo(carContentView.mas_bottom).offset(20);
        }
        
    }];
    
    UILabel *soilTypeLb = [UILabel labelWithText:@"土类型"
                                            font:[UIFont boldSystemFontOfSize:14]
                                       textColor:[UIColor blackColor]
                                       alignment:NSTextAlignmentLeft];
    [_scrollView addSubview:soilTypeLb];
    [soilTypeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.top.equalTo(carLine.mas_bottom).offset(20);
    }];
    
    UILabel *lastSoilLb;
    for(int i = 0; i < self.soilArr.count; i++)
    {
        WorkConfigManageResponse *model = self.soilArr[i];
        UILabel *label = [UILabel labelWithText:model.name
                                           font:[UIFont systemFontOfSize:13]
                                      textColor:[UIColor blackColor]
                                      alignment:NSTextAlignmentCenter];
        label.userInteractionEnabled = YES;
        [label jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            [weakself soilLbChange:i];
        }];
        label.textColor = model.isSelected ? [UIColor whiteColor] : [UIColor blackColor];
        label.backgroundColor = model.isSelected ? [UIColor jk_colorWithHexString:COLOR_BLUE] : [UIColor jk_colorWithHexString:COLOR_BACK];
        [self.scrollView addSubview:label];
        [self.soilLabs addObject:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0)
            {
                make.left.equalTo(self.view).offset(16);
                make.top.equalTo(soilTypeLb.mas_bottom).offset(20);
            }
            else if (i % 3 == 0)
            {
                make.left.equalTo(self.view).offset(16);
                make.top.equalTo(lastSoilLb.mas_bottom).offset(10);
            }
            else
            {
                make.left.equalTo(lastSoilLb.mas_right).offset(20);
                make.top.equalTo(lastSoilLb);
            }
            make.height.equalTo(30);
            make.width.equalTo((kScreenWidth - 32 - 40)/3);
        }];
        lastSoilLb = label;
    }

    
    UIView *soilLine = [UIView new];
    soilLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [_scrollView addSubview:soilLine];
    [soilLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.right.equalTo(self.view);
        make.top.equalTo(lastSoilLb.mas_bottom).offset(20);
    }];
    
    UILabel *soilWayLb = [UILabel labelWithText:@"倒土方式"
                                           font:[UIFont boldSystemFontOfSize:14]
                                      textColor:[UIColor blackColor]
                                      alignment:NSTextAlignmentLeft];
    [_scrollView addSubview:soilWayLb];
    [soilWayLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.top.equalTo(soilLine.mas_bottom).offset(20);
    }];
    
    UILabel *soillastLb;
    for(int i = 0; i < self.dsoilArr.count; i++)
    {
        WorkConfigManageResponse *model = self.dsoilArr[i];
        UILabel *label = [UILabel labelWithText:model.name
                                           font:[UIFont systemFontOfSize:13]
                                      textColor:[UIColor blackColor]
                                      alignment:NSTextAlignmentCenter];
        label.userInteractionEnabled = YES;
        [label jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            [weakself dsoilLbChange:i];
        }];
        label.textColor = model.isSelected ? [UIColor whiteColor] : [UIColor blackColor];
        label.backgroundColor = model.isSelected ? [UIColor jk_colorWithHexString:COLOR_BLUE] : [UIColor jk_colorWithHexString:COLOR_BACK];
        [self.scrollView addSubview:label];
        [self.dsoilLabs addObject:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0)
            {
                make.left.equalTo(self.view).offset(16);
                make.right.equalTo(self.view).offset(-16);
                make.top.equalTo(soilWayLb.mas_bottom).offset(20);
            }
            else if (i == 1)
            {
                make.left.equalTo(self.view).offset(16);
                make.top.equalTo(soillastLb.mas_bottom).offset(10);
                make.width.equalTo((kScreenWidth - 32 - 40)/3);
            }
            else if ((i - 1) % 3 == 0)
            {
                make.left.equalTo(self.view).offset(16);
                make.top.equalTo(soillastLb.mas_bottom).offset(10);
                make.width.equalTo((kScreenWidth - 32 - 40)/3);
            }
            else
            {
                make.left.equalTo(soillastLb.mas_right).offset(20);
                make.top.equalTo(soillastLb);
                make.width.equalTo((kScreenWidth - 32 - 40)/3);
            }
            make.height.equalTo(30);
        }];
        soillastLb = label;
    }
    
    UIView *secondGrayLine = [UIView new];
    secondGrayLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
    [_scrollView addSubview:secondGrayLine];
    [secondGrayLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(soillastLb.mas_bottom).offset(30);
        make.height.equalTo(10);
        make.left.right.equalTo(self.view);
    }];
    
    [_scrollView addSubview:self.priceInput];
    [_priceInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(46);
        make.top.equalTo(secondGrayLine.mas_bottom);
        make.left.right.equalTo(self.view);
    }];
    
    UIView *thirdLine = [UIView new];
    thirdLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [_scrollView addSubview:thirdLine];
    [thirdLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.priceInput.mas_bottom);
    }];
    
    UIView *classView = [UIView new];
    [_scrollView addSubview:classView];
    
    
    UILabel *classLb = [UILabel labelWithText:@"班次"
                                           font:[UIFont boldSystemFontOfSize:14]
                                      textColor:[UIColor blackColor]
                                      alignment:NSTextAlignmentLeft];
    [classView addSubview:classLb];
    [classLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.top.equalTo(classView).offset(20);
    }];
    
    UILabel *lastClassLb;
    for(int i = 0; i < self.classArr.count; i++)
    {
        WorkConfigManageResponse *model = self.classArr[i];
        UILabel *label = [UILabel labelWithText:model.name
                                           font:[UIFont systemFontOfSize:13]
                                      textColor:[UIColor blackColor]
                                      alignment:NSTextAlignmentCenter];
        label.userInteractionEnabled = YES;
        [label jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            [weakself classLbChange:i];
        }];
        label.textColor = model.isSelected ? [UIColor whiteColor] : [UIColor blackColor];
        label.backgroundColor = model.isSelected ? [UIColor jk_colorWithHexString:COLOR_BLUE] : [UIColor jk_colorWithHexString:COLOR_BACK];
        [classView addSubview:label];
        [self.classLabs addObject:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            if (i == 0)
            {
                make.left.equalTo(self.view).offset(16);
                make.top.equalTo(classLb.mas_bottom).offset(20);
            }
            else
            {
                make.left.equalTo(lastClassLb.mas_right).offset(20);
                make.top.equalTo(lastClassLb);
            }
            make.height.equalTo(30);
            make.width.equalTo((kScreenWidth - 32 - 20)/2);
        }];
        lastClassLb = label;
    }
    
    [classView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(thirdLine.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(lastClassLb.mas_bottom).offset(20);
    }];
    
    UIView *fourthLine = [UIView new];
    fourthLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [_scrollView addSubview:fourthLine];
    [fourthLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.right.equalTo(self.view);
        make.top.equalTo(classView.mas_bottom);
    }];
    
    [_scrollView addSubview:self.carTeamName];
    [_carTeamName jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself presentCarListVC];
    }];
    [_carTeamName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(46);
        make.top.equalTo(fourthLine.mas_bottom);
        make.left.right.equalTo(self.view);
    }];
    
    UIView *firstLine = [UIView new];
    firstLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [_scrollView addSubview:firstLine];
    [firstLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.carTeamName.mas_bottom);
    }];
    
    [_scrollView addSubview:self.driveInput];
    [_driveInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(46);
        make.top.equalTo(firstLine.mas_bottom);
        make.left.right.equalTo(self.view);
    }];
    
    UIView *secondLine = [UIView new];
    secondLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [_scrollView addSubview:secondLine];
    [secondLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.driveInput.mas_bottom);
    }];
    
    [_scrollView addSubview:self.remarkInput];
    [self.remarkInput.textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        if (x.length > 50)
        {
            weakself.remarkInput.textField.text = [x substringToIndex:50];
        }
    }];
    [_remarkInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(46);
        make.top.equalTo(secondLine.mas_bottom);
        make.left.right.equalTo(self.view);
    }];
    
    UIView *thirdGrayLine = [UIView new];
    thirdGrayLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
    [_scrollView addSubview:thirdGrayLine];
    [thirdGrayLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.remarkInput.mas_bottom);
        make.height.equalTo(10);
        make.left.right.equalTo(self.view);
    }];
    
    UIView *reasonView = [UIView new];
    [_scrollView addSubview:reasonView];
    [reasonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(thirdGrayLine.mas_bottom);
        make.bottom.equalTo(self.scrollView);
    }];
    
    UILabel *changeLb = [UILabel labelWithText:@"修改原因"
                                           font:[UIFont boldSystemFontOfSize:14]
                                      textColor:[UIColor blackColor]
                                      alignment:NSTextAlignmentLeft];
    [reasonView addSubview:changeLb];
    [changeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.top.equalTo(reasonView).offset(20);
    }];
    
    [reasonView addSubview:self.textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(reasonView).offset(16);
        make.right.equalTo(reasonView).offset(-16);
        make.top.equalTo(changeLb.mas_bottom).offset(10);
        make.height.equalTo(60);
    }];

    [_textView.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        weakself.textLb.hidden = [x length] > 0;
        if (x.length > 50)
        {
            weakself.textView.text = [x substringToIndex:50];
        }
        weakself.numberLb.text = [NSString stringWithFormat:@"%ld/50",weakself.textView.text.length];
    }];
    
    [reasonView addSubview:self.textLb];
    [_textLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textView).offset(2);
        make.top.equalTo(self.textView).offset(8);
    }];
    
    [reasonView addSubview:self.numberLb];
    [_numberLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.textView);
        make.top.equalTo(self.textView.mas_bottom);
        make.bottom.equalTo(reasonView).offset(-20);
    }];
}

- (void)saveRequest
{
    if (self.textView.text.length == 0)
    {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入修改原因"];
        return;
    }
    
    WeakSelf(self)
    PostRequest *request = [[PostRequest alloc] initWithRequestUrl:orderedit argument:@{@"id":self.orderDetailResponse.orderId,
                                                                                        @"orderNo":self.orderDetailResponse.orderNo,
                                                                                        @"projectId":self.projectId,
                                                                                        @"plateNumber":self.orderDetailResponse.plateNumber,
                                                                                        @"bodySize":self.isChange ? @"0": self.isOtherSize ? self.sizeTF.text: self.seletedCarSize.size,
                                                                                        @"weight":self.isChange ? self.weightTF.text : @"0",
                                                                                        @"tlxId":self.seletedSoil.workId,
                                                                                        @"ztcId":self.seletedsSoil.workId,
                                                                                        @"driverName":self.driveInput.textField.text,
                                                                                        @"fleetId":self.carTeamResponse.workId,
                                                                                        @"price":@"0",
                                                                                        @"remark":self.remarkInput.textField.text,
                                                                                        @"isException":@"FALSE",
                                                                                        @"exception":self.textView.text,
                                                                                        @"workType":self.seletedClass.status
                                                                                      }];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"修改工单成功"];
            [weakself.subject sendNext:@"1"];
            [weakself.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

- (void)presentCarListVC
{
    CarListVC *carListVC = [CarListVC new];
    carListVC.projectId = self.projectId;
    carListVC.workerId = self.carTeamResponse.workId;
    WeakSelf(self)
    [carListVC.subject subscribeNext:^(id  _Nullable x) {
        WorkConfigManageResponse *response = (WorkConfigManageResponse *)x;
        weakself.carTeamName.infoLb.text = response.name;
        weakself.carTeamName.infoLb.textColor = [UIColor jk_colorWithHexString:COLOR_242424];
        weakself.carTeamResponse = response;
    }];
    [self presentViewController:carListVC animated:YES completion:nil];
}

- (void)carLbChange:(int)index
{
    self.seletedCarSize = self.carSizeArr[index];
    for (int i = 0; i < self.carSizeArr.count; i++)
    {
        CarSizeModel *model = self.carSizeArr[i];
        model.isSeleted = index == i;
        
        UILabel *label = self.carLabs[i];
        label.textColor = model.isSeleted ? [UIColor whiteColor] : [UIColor blackColor];
        label.backgroundColor = model.isSeleted ? [UIColor jk_colorWithHexString:COLOR_BLUE] : [UIColor jk_colorWithHexString:COLOR_BACK];
    }
}

- (void)soilLbChange:(int)index
{
    self.seletedSoil = self.soilArr[index];
    for (int i = 0; i < self.soilArr.count; i++)
    {
        WorkConfigManageResponse *model = self.soilArr[i];
        model.isSelected = index == i;
        
        UILabel *label = self.soilLabs[i];
        label.textColor = model.isSelected ? [UIColor whiteColor] : [UIColor blackColor];
        label.backgroundColor = model.isSelected ? [UIColor jk_colorWithHexString:COLOR_BLUE] : [UIColor jk_colorWithHexString:COLOR_BACK];
    }
}

- (void)classLbChange:(int)index
{
    self.seletedClass = self.classArr[index];
    for (int i = 0; i < self.classArr.count; i++)
    {
        WorkConfigManageResponse *model = self.classArr[i];
        model.isSelected = index == i;
        
        UILabel *label = self.classLabs[i];
        label.textColor = model.isSelected ? [UIColor whiteColor] : [UIColor blackColor];
        label.backgroundColor = model.isSelected ? [UIColor jk_colorWithHexString:COLOR_BLUE] : [UIColor jk_colorWithHexString:COLOR_BACK];
    }
}

- (void)dsoilLbChange:(int)index
{
    self.seletedsSoil = self.dsoilArr[index];
    for (int i = 0; i < self.dsoilArr.count; i++)
    {
        WorkConfigManageResponse *model = self.dsoilArr[i];
        model.isSelected = index == i;
        
        UILabel *label = self.dsoilLabs[i];
        label.textColor = model.isSelected ? [UIColor whiteColor] : [UIColor blackColor];
        label.backgroundColor = model.isSelected ?[UIColor jk_colorWithHexString:COLOR_BLUE] : [UIColor jk_colorWithHexString:COLOR_BACK];
    }
}

@end
