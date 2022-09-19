//
//  CreateWorkOrderVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/17.
//

#import "CreateWorkOrderVC.h"
#import "CarSizeModel.h"
#import "InfoInputRightCompent.h"
#import "InfoSeletedCompent.h"
#import "LoginInfoManage.h"
#import "YTKBatchRequest.h"
#import "WorkConfigManageResponse.h"
#import "CarListVC.h"
#import "TZImagePickerController.h"
#import "AFURLRequestSerialization.h"
#import "PrintNumberVC.h"
#import "PrintNumberModel.h"
#import <PrinterSDK/PrinterSDK.h>
#import "WorkOderStatusResponse.h"
#import "OrderDetailResponse.h"
#import "CameraViewController.h"
#import "WorkConfigManageVC.h"
#import "SDPhotoBrowser.h"
#import "ConfigModel.h"
#import "RemberLastCarResponse.h"
@interface CreateWorkOrderVC ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,SDPhotoBrowserDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *topImg;
@property (nonatomic, strong) UILabel *carLb;
@property (nonatomic, strong) UILabel *dischargedPeopleLb;
@property (nonatomic, strong) UILabel *dischargedTimeLb;
@property (nonatomic, strong) NSMutableArray *carSizeArr;
@property (nonatomic, strong) NSArray<WorkConfigManageResponse *> *soilArr;
@property (nonatomic, strong) NSMutableArray<WorkConfigManageResponse *> *dsoilArr;
@property (nonatomic, strong) InfoSeletedCompent *carTeamName;
@property (nonatomic, strong) InfoInputRightCompent *driveInput;
@property (nonatomic, strong) InfoSeletedCompent *printNo;
@property (nonatomic, strong) InfoInputRightCompent *priceInput;
@property (nonatomic, strong) InfoInputRightCompent *remarkInput;
@property (nonatomic, copy) NSString *currentTime;

@property (nonatomic, strong) NSMutableArray *carLabs;
@property (nonatomic, strong) NSMutableArray *soilLabs;
@property (nonatomic, strong) NSMutableArray *dsoilLabs;

@property (nonatomic, strong) UIImage *photo;

@property (nonatomic, strong) UIImageView *uploadImg;
@property (nonatomic, strong) UIImageView *carImg;

@property (nonatomic, strong) CarSizeModel *seletedCarSize;
@property (nonatomic, strong) WorkConfigManageResponse *seletedSoil;
@property (nonatomic, strong) WorkConfigManageResponse *seletedsSoil;
@property (nonatomic, strong) WorkConfigManageResponse *carTeamResponse;

@property (nonatomic, assign) BOOL isChange;
@property (nonatomic, strong) GLTextField *weightTF;

@property (nonatomic, strong) GLTextField *sizeTF;
@property (nonatomic, assign) BOOL isOtherSize;

@property (nonatomic, assign) BOOL isOut;
@property (nonatomic, assign) BOOL hasLoad;
@property (nonatomic, strong) ConfigModel *workConfigModel;

@property (nonatomic, strong) RemberLastCarResponse *remberLastCar;
@end

@implementation CreateWorkOrderVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getConfig];
    self.currentTime = [Tools getCurrentTime];
    self.carSizeArr = [NSMutableArray arrayWithCapacity:0];
    self.dsoilArr = [NSMutableArray arrayWithCapacity:0];
    
    self.carLabs = [NSMutableArray arrayWithCapacity:0];
    self.soilLabs = [NSMutableArray arrayWithCapacity:0];
    self.dsoilLabs = [NSMutableArray arrayWithCapacity:0];
    [self remberLastCar:self.carName];
}

- (void)getConfig
{
    WeakSelf(self)
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:pcdetails argument:@{@"projectId":self.projectId}];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            weakself.workConfigModel = [ConfigModel mj_objectWithKeyValues:result[@"data"][@"content"]];
        }
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

- (UIImageView *)uploadImg
{
    if (!_uploadImg)
    {
        _uploadImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"manage_detail_add_image"]];
        _uploadImg.userInteractionEnabled = YES;
    }
    return _uploadImg;
}

- (UIImageView *)carImg
{
    if (!_carImg)
    {
        _carImg = [UIImageView new];
        _carImg.userInteractionEnabled = YES;
    }
    return _carImg;
}

- (void)remberLastCar:(NSString *)carNo
{
    if ([LoginInfoManage shareInstance].workConfigResponse.isRememberLastConfig)
    {
        WeakSelf(self)
        GetRequest *request = [[GetRequest alloc] initWithRequestUrl:rememberlastconfig argument:@{@"plateNumber":carNo,@"projectId":self.projectId}];
        [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
            if (success)
            {
                weakself.remberLastCar = [RemberLastCarResponse mj_objectWithKeyValues:result[@"data"][@"content"]];
                [weakself getSetting];
            }
            
        } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
            
        }];
    }
    else
    {
        [self getSetting];
    }
    
}

- (void)getSetting
{
    WeakSelf(self)
    GetRequest *offRequest = [[GetRequest alloc] initWithRequestUrl:platenumberstatus
                                                           argument:@{@"projectId":self.projectId,@"plateNumber":self.carLb.text}];
    [offRequest startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            WorkOderStatusResponse *response = [WorkOderStatusResponse mj_objectWithKeyValues:result[@"data"]];
            weakself.isOut = response.scanCount == 1 || (response.scanCount == 2 && [response.status isEqualToString:@"NOT_OUT"]);
            if (weakself.isOut)
            {
                if (!weakself.hasLoad)
                {
                    weakself.hasLoad = YES;
                    [weakself getDate];
                }
                else
                {
                    [weakself customerUI];
                }
            }
            else
            {
                [weakself customerUIIn];
            }
        }
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
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
        [weakself getPriceData];

    } failure:^(YTKBatchRequest * _Nonnull batchRequest) {
        
    }];
}

- (void)getPriceData
{
    NSString *bodySize = self.isChange ? @"0": self.isOtherSize ? @"0": self.seletedCarSize.size;
    WeakSelf(self)
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:pricegetprice argument:@{@"projectId":self.projectId,
                                                                                          @"bodySize":bodySize,
                                                                                          @"tlxId":self.seletedSoil.workId,
                                                                                          @"ztcId":self.seletedsSoil.workId
                                                                                        }];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            weakself.priceInput.textField.text = [NSString stringWithFormat:@"%@元",result[@"data"]];
        }
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

- (void)dSoilHandle:(GetRequest *)request
{
    NSDictionary *carResult = [request responseJSONObject];
    BOOL isCarSuccess = [[carResult objectForKey:@"code"] intValue] == 200;
    if (isCarSuccess)
    {
        self.dsoilArr = [WorkConfigManageResponse mj_objectArrayWithKeyValuesArray:carResult[@"data"]];
        WorkConfigManageResponse *response = [WorkConfigManageResponse new];
        response.name = @"自倒";
        response.isSelected = NO;
        response.workId = @"-1";
        [self.dsoilArr insertObject:response atIndex:0];
        
        if (self.remberLastCar)
        {
            for (WorkConfigManageResponse *workResponse in self.dsoilArr)
            {
                if ([self.remberLastCar.ztcName isEqualToString:workResponse.name])
                {
                    workResponse.isSelected = YES;
                    self.seletedsSoil = workResponse;
                    break;
                }
            }
        }
        else
        {
            WorkConfigManageResponse *firstResponse = self.dsoilArr.firstObject;
            firstResponse.isSelected = YES;
            self.seletedsSoil = firstResponse;
        }
    }
    [self customerUI];
}

- (void)soilHandle:(GetRequest *)request
{
    NSDictionary *carResult = [request responseJSONObject];
    BOOL isCarSuccess = [[carResult objectForKey:@"code"] intValue] == 200;
    if (isCarSuccess)
    {
        self.soilArr = [WorkConfigManageResponse mj_objectArrayWithKeyValuesArray:carResult[@"data"]];
        if (self.remberLastCar)
        {
            for (WorkConfigManageResponse *response in self.soilArr)
            {
                if ([self.remberLastCar.tlxName isEqualToString:response.name])
                {
                    response.isSelected = YES;
                    self.seletedSoil = response;
                    break;
                }
            }
        }
        else
        {
            if (self.soilArr.count > 0)
            {
                WorkConfigManageResponse *response = self.soilArr.firstObject;
                response.isSelected = YES;
                self.seletedSoil = response;
            }
        }
    }
}

- (void)carManageHandle:(GetRequest *)request
{
    NSDictionary *carResult = [request responseJSONObject];
    BOOL isCarSuccess = [[carResult objectForKey:@"code"] intValue] == 200;
    if (isCarSuccess)
    {
        NSArray *result = carResult[@"data"];
        for (int i = 0; i < result.count; i++)
        {
            NSString *name = [NSString stringWithFormat:@"%@方",result[i]];
            if ([result[i] intValue] == 0)
            {
                name = @"其他";
            }
            CarSizeModel *model = [CarSizeModel new];
            if (self.remberLastCar)
            {
                BOOL lastSeleted = [self.remberLastCar.bodySzie isEqualToString:[NSString stringWithFormat:@"%@",result[i]]];
                model = [[CarSizeModel alloc] initWithName:name isSeleted:lastSeleted size:result[i]];
                if (lastSeleted)
                {
                    self.seletedCarSize = model;
                }
            }
            else
            {
                model = [[CarSizeModel alloc] initWithName:name isSeleted:i == 0 ? YES : NO size:result[i]];
                if (i == 0)
                {
                    self.seletedCarSize = model;
                }
            }
            [self.carSizeArr addObject:model];
        }
    }
    
}

- (RACSubject *)subject
{
    if (!_subject)
    {
        _subject = [RACSubject new];
    }
    return _subject;
}

- (GLTextField *)weightTF
{
    if (!_weightTF)
    {
        _weightTF = [GLTextField new];
        [_weightTF placeHolderString:@"输入"];
        _weightTF.delegate = self;
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
        _sizeTF.delegate = self;
        _sizeTF.textAlignment = NSTextAlignmentCenter;
        _sizeTF.textColor = [UIColor whiteColor];
        _sizeTF.font = [UIFont systemFontOfSize:font_13];
    }
    return _sizeTF;
}

- (InfoSeletedCompent *)carTeamName
{
    if (!_carTeamName)
    {
        _carTeamName = [InfoSeletedCompent new];
        [_carTeamName setName:@"车队名称" info:@"" defaultInfo:@"请选择车队名称"];
    }
    return _carTeamName;
}

- (InfoInputRightCompent *)driveInput
{
    if (!_driveInput)
    {
        _driveInput = [InfoInputRightCompent new];
        [_driveInput setName:@"司机" placeholder:@"请输入司机名字"];
    }
    return _driveInput;
}

- (InfoSeletedCompent *)printNo
{
    if (!_printNo)
    {
        _printNo = [InfoSeletedCompent new];
        NSString *name = @"不打印";
        switch ([LoginInfoManage shareInstance].workConfigResponse.pointCount) {
            case 1:
            {
                name = @"一联";
                break;
            }
            case 2:
            {
                name = @"二联";
                break;
            }
            case 3:
            {
                name = @"三联";
                break;
            }
            case 4:
            {
                name = @"四联";
                break;
            }
            default:
                break;
        }
        [_printNo setName:@"打印联数" info:name defaultInfo:@""];
    }
    return _printNo;
}

- (InfoInputRightCompent *)priceInput
{
    if (!_priceInput)
    {
        _priceInput = [InfoInputRightCompent new];
        [_priceInput setName:@"价格" placeholder:@""];
        _priceInput.textField.text = @"0元";
        _priceInput.userInteractionEnabled = NO;
    }
    return _priceInput;
}

- (InfoInputRightCompent *)remarkInput
{
    if (!_remarkInput)
    {
        _remarkInput = [InfoInputRightCompent new];
        [_remarkInput setName:@"备注" placeholder:@"请输入（最多50个字）"];
    }
    return _remarkInput;
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

- (UILabel *)carLb
{
    if (!_carLb)
    {
        _carLb = [UILabel labelWithText:self.carName
                                   font:[UIFont systemFontOfSize:24]
                              textColor:[UIColor jk_colorWithHexString:COLOR_BLUE]
                              alignment:NSTextAlignmentCenter];
    }
    return _carLb;
}

- (UILabel *)dischargedPeopleLb
{
    if (!_dischargedPeopleLb)
    {
        _dischargedPeopleLb = [UILabel labelWithText:[NSString stringWithFormat:@"放行人：%@",[LoginInfoManage shareInstance].personalResponse.name]
                                                font:[UIFont systemFontOfSize:font_12]
                                           textColor:[UIColor jk_colorWithHexString:@"#333333"]
                                           alignment:NSTextAlignmentLeft];
    }
    return _dischargedPeopleLb;
}

- (UILabel *)dischargedTimeLb
{
    if (!_dischargedTimeLb)
    {
        _dischargedTimeLb = [UILabel labelWithText:@"放行时间："
                                              font:[UIFont systemFontOfSize:12]
                                         textColor:[UIColor jk_colorWithHexString:@"#333333"]
                                         alignment:NSTextAlignmentRight];
    }
    return _dischargedTimeLb;
}

- (UIImageView *)topImg
{
    if (!_topImg)
    {
        _topImg = [[UIImageView alloc] initWithImage:self.carImage];
        _topImg.contentMode = UIViewContentModeScaleToFill;
        _topImg.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
    }
    return _topImg;
}

- (void)customerUIIn
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
    
    UILabel *printLb = [UILabel labelWithText:@"入场放行"
                                         font:[UIFont boldSystemFontOfSize:16]
                                    textColor:[UIColor whiteColor]
                                    alignment:NSTextAlignmentCenter];
    printLb.userInteractionEnabled = YES;
    [printLb jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself uploadCarImg];
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
    
    [_scrollView addSubview:self.topImg];
    [_topImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.scrollView);
        make.height.equalTo(200);
    }];
    
    [_scrollView addSubview:self.carLb];
    [_carLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.topImg.mas_bottom).offset(20);
    }];
    
    UILabel *carRecognitionLb = [UILabel labelWithText:@"车牌识别："
                                                  font:[UIFont systemFontOfSize:font_14]
                                             textColor:[UIColor jk_colorWithHexString:COLOR_BLUE]
                                             alignment:NSTextAlignmentRight];
    [_scrollView addSubview:carRecognitionLb];
    [carRecognitionLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.carLb.mas_left);
        make.bottom.equalTo(self.carLb);
    }];
    
    UILabel *changeLb = [UILabel labelWithText:@"修改"
                                          font:[UIFont systemFontOfSize:font_15]
                                     textColor:[UIColor jk_colorWithHexString:COLOR_BLUE]
                                     alignment:NSTextAlignmentRight];
    changeLb.userInteractionEnabled = YES;
    [changeLb jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself changeCarNumber];
    }];
    [_scrollView addSubview:changeLb];
    [changeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-40);
        make.bottom.equalTo(self.carLb.mas_bottom);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [_scrollView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.carLb.mas_bottom).offset(20);
        make.height.equalTo(0.5);
        make.left.right.equalTo(self.view);
    }];
    
    [_scrollView addSubview:self.dischargedPeopleLb];
    [_dischargedPeopleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.top.equalTo(lineView.mas_bottom).offset(16);
    }];
    
    UILabel *timeLb = [UILabel labelWithText:[NSString stringWithFormat:@"放行时间:%@",self.currentTime]
                                        font:[UIFont systemFontOfSize:12]
                                   textColor:[UIColor jk_colorWithHexString:@"#333333"]
                                   alignment:NSTextAlignmentRight];
    [_scrollView addSubview:timeLb];
    [timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-16);
        make.centerY.equalTo(self.dischargedPeopleLb);
    }];
    
    UIView *grayLine = [UIView new];
    grayLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
    [_scrollView addSubview:grayLine];
    [grayLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dischargedPeopleLb.mas_bottom).offset(16);
        make.height.equalTo(10);
        make.left.right.equalTo(self.view);
    }];
    
    UILabel *uploadLb = [UILabel labelWithText:@"上传车斗照"
                                          font:[UIFont systemFontOfSize:15]
                                     textColor:[UIColor blackColor]
                                     alignment:NSTextAlignmentLeft];
    [_scrollView addSubview:uploadLb];
    [uploadLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.top.equalTo(grayLine.mas_bottom).offset(20);
    }];
    
    
    [_scrollView addSubview:self.uploadImg];
    [_uploadImg jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself takePhoto];
    }];
    [_uploadImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo((kScreenWidth - 2 * 10 - 32)/3);
        make.left.equalTo(uploadLb);
        make.top.equalTo(uploadLb.mas_bottom).offset(20);
        make.bottom.equalTo(self.scrollView).offset(-40);
    }];
    
    [_scrollView addSubview:self.carImg];
    [_carImg jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        
    }];
    
    GLImageView *closeImg = [GLImageView new];
    closeImg.userInteractionEnabled = YES;
    [closeImg jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        weakself.carImg.hidden = YES;
        weakself.uploadImg.hidden = NO;
    }];
    closeImg.image = [UIImage imageNamed:@"home_arrow_close"];
    [_carImg addSubview:closeImg];
    [closeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self.carImg);
        make.width.height.equalTo(16);
    }];
    
    _carImg.hidden = YES;
    [_carImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.uploadImg);
    }];
    
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
    
    UILabel *printLb = [UILabel labelWithText:@"打印并放行"
                                         font:[UIFont boldSystemFontOfSize:16]
                                    textColor:[UIColor whiteColor]
                                    alignment:NSTextAlignmentCenter];
    printLb.userInteractionEnabled = YES;
    [printLb jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself uploadCarImg];
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
    
    [_scrollView addSubview:self.topImg];
    [_topImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.scrollView);
        make.height.equalTo(200);
    }];
    
    [_scrollView addSubview:self.carLb];
    [_carLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.topImg.mas_bottom).offset(20);
    }];
    
    UILabel *carRecognitionLb = [UILabel labelWithText:@"车牌识别："
                                                  font:[UIFont systemFontOfSize:font_14]
                                             textColor:[UIColor jk_colorWithHexString:COLOR_BLUE]
                                             alignment:NSTextAlignmentRight];
    [_scrollView addSubview:carRecognitionLb];
    [carRecognitionLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.carLb.mas_left);
        make.bottom.equalTo(self.carLb);
    }];
    
    UILabel *changeLb = [UILabel labelWithText:@"修改"
                                          font:[UIFont systemFontOfSize:font_15]
                                     textColor:[UIColor jk_colorWithHexString:COLOR_BLUE]
                                     alignment:NSTextAlignmentRight];
    changeLb.userInteractionEnabled = YES;
    [changeLb jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself changeCarNumber];
    }];
    [_scrollView addSubview:changeLb];
    [changeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-40);
        make.bottom.equalTo(self.carLb.mas_bottom);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [_scrollView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.carLb.mas_bottom).offset(20);
        make.height.equalTo(0.5);
        make.left.right.equalTo(self.view);
    }];
    
    [_scrollView addSubview:self.dischargedPeopleLb];
    [_dischargedPeopleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.top.equalTo(lineView.mas_bottom).offset(16);
    }];
    
    UILabel *timeLb = [UILabel labelWithText:[NSString stringWithFormat:@"放行时间:%@",self.currentTime]
                                        font:[UIFont systemFontOfSize:12]
                                   textColor:[UIColor jk_colorWithHexString:@"#333333"]
                                   alignment:NSTextAlignmentRight];
    [_scrollView addSubview:timeLb];
    [timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(-16);
        make.centerY.equalTo(self.dischargedPeopleLb);
    }];
    
    UIView *grayLine = [UIView new];
    grayLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
    [_scrollView addSubview:grayLine];
    [grayLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dischargedPeopleLb.mas_bottom).offset(16);
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
    changeView.hidden = YES;
    changeView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
    [_scrollView addSubview:changeView];
    [changeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(carSizeTitleLb.mas_bottom).offset(20);
        make.left.equalTo(carSizeTitleLb);
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
    UIView *carLine = [UIView new];
    
    UIView *sizeContentView = [UIView new];
    sizeContentView.hidden = YES;
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
            if (!weakself.isOtherSize)
            {
                [weakself getPriceData];
            }
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
                make.top.equalTo(carSizeTitleLb.mas_bottom).offset(20);
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
        make.top.equalTo(lastLb.mas_bottom).offset(20);
    }];
    
    UILabel *soilTypeLb = [UILabel labelWithText:@"土类型"
                                            font:[UIFont boldSystemFontOfSize:14]
                                       textColor:[UIColor blackColor]
                                       alignment:NSTextAlignmentLeft];
    soilTypeLb.userInteractionEnabled = YES;
    [soilTypeLb jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        if (weakself.soilArr.count == 0)
        {
            WorkConfigManageVC *workConfigManageVC = [WorkConfigManageVC new];
            workConfigManageVC.settingType = TlxManage;
            workConfigManageVC.projectId = self.projectId;
            workConfigManageVC.title = @"土类型管理";
            [self.navigationController pushViewController:workConfigManageVC animated:YES];
        }
    }];
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
        if (lastSoilLb)
        {
            make.top.equalTo(lastSoilLb.mas_bottom).offset(20);
        }
        else
        {
            make.top.equalTo(soilTypeLb.mas_bottom).offset(20);
        }
        
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
    
    [_scrollView addSubview:self.carTeamName];
    if (![Tools isEmpty:self.remberLastCar.fleetName])
    {
        self.carTeamName.infoLb.text = self.remberLastCar.fleetName;
        self.carTeamName.infoLb.textColor = [UIColor jk_colorWithHexString:COLOR_242424];
        self.carTeamResponse = [WorkConfigManageResponse new];
        self.carTeamResponse.workId = self.remberLastCar.fleetId;
    }
    [_carTeamName jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself presentCarListVC];
    }];
    [_carTeamName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(46);
        make.top.equalTo(secondGrayLine.mas_bottom);
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

    [_scrollView addSubview:self.printNo];
    [_printNo jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself seletedPrintNo];
    }];
    [_printNo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(56);
        make.top.equalTo(secondLine.mas_bottom);
        make.left.right.equalTo(self.view);
    }];
    
    UIView *thirdLine = [UIView new];
    thirdLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [_scrollView addSubview:thirdLine];
    [thirdLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.printNo.mas_bottom);
    }];
    
    [_scrollView addSubview:self.priceInput];
    [_priceInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(56);
        make.top.equalTo(thirdLine.mas_bottom);
        make.left.right.equalTo(self.view);
    }];
    
    UIView *fourthLine = [UIView new];
    fourthLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [_scrollView addSubview:fourthLine];
    [fourthLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.priceInput.mas_bottom);
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
        make.top.equalTo(fourthLine.mas_bottom);
        make.left.right.equalTo(self.view);
    }];
    
    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = [UIColor jk_colorWithHexString:COLOR_LINE];
    [_scrollView addSubview:bottomLine];
    [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(0.5);
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.remarkInput.mas_bottom);
    }];
    
    UILabel *uploadLb = [UILabel labelWithText:@"上传车斗照"
                                          font:[UIFont systemFontOfSize:15]
                                     textColor:[UIColor blackColor]
                                     alignment:NSTextAlignmentLeft];
    [_scrollView addSubview:uploadLb];
    [uploadLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(16);
        make.top.equalTo(bottomLine.mas_bottom).offset(20);
    }];
    
    
    [_scrollView addSubview:self.uploadImg];
    [_uploadImg jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself takePhoto];
    }];
    [_uploadImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo((kScreenWidth - 2 * 10 - 32)/3);
        make.left.equalTo(uploadLb);
        make.top.equalTo(uploadLb.mas_bottom).offset(20);
        make.bottom.equalTo(self.scrollView).offset(-40);
    }];
    
    [_scrollView addSubview:self.carImg];
    [_carImg jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [weakself showBigImg];
    }];
    
    GLImageView *closeImg = [GLImageView new];
    closeImg.userInteractionEnabled = YES;
    [closeImg jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        weakself.carImg.hidden = YES;
        weakself.uploadImg.hidden = NO;
    }];
    closeImg.image = [UIImage imageNamed:@"home_arrow_close"];
    [_carImg addSubview:closeImg];
    [closeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self.carImg);
        make.width.height.equalTo(16);
    }];
    
    _carImg.hidden = YES;
    [_carImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.uploadImg);
    }];
}

- (void)showBigImg
{
    SDPhotoBrowser *browser = [SDPhotoBrowser new];
    browser.currentImageIndex = 0;
    browser.sourceImagesContainerView = self.scrollView;
    browser.imageCount = 1;
    browser.delegate = self;
    [browser show];
}

- (void)seletedPrintNo
{
    WeakSelf(self)
    PrintNumberVC *printNumberVC = [PrintNumberVC new];
    [printNumberVC.subject subscribeNext:^(id  _Nullable x) {
        PrintNumberModel *printModel = (PrintNumberModel *)x;
        weakself.printNo.infoLb.text = printModel.name;
        [weakself saveConfig:printModel.name];
    }];
    [self presentViewController:printNumberVC animated:YES completion:nil];
}

- (void)saveConfig:(NSString *)name
{
    int pointCount = 0;
    if ([name isEqualToString:@"一联"])
    {
        pointCount = 1;
    }
    else if ([name isEqualToString:@"二联"])
    {
        pointCount = 2;
    }
    else if ([name isEqualToString:@"三联"])
    {
        pointCount = 3;
    }
    else if ([name isEqualToString:@"四联"])
    {
        pointCount = 4;
    }
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:configedit argument:@{@"key":@"pointCount",@"value":@(pointCount),@"projectId":self.projectId}];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            [LoginInfoManage shareInstance].workConfigResponse.pointCount = pointCount;
        }
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

- (void)changeCarNumber
{
    WeakSelf(self)
    [Tools showCarNoChangeView:self.carName image:self.carImage rescan:^{
        [weakself reScan];
    } sure:^(NSString * _Nonnull result) {
        weakself.carName = result;
        weakself.carLb.text = result;
        [weakself clearView];
        [weakself getSetting];
        [weakself remberLastCar:result];
    }];
}

- (void)clearView
{
    [self.scrollView removeFromSuperview];
    _scrollView = nil;
    [self.carLabs removeAllObjects];
    [self.soilLabs removeAllObjects];
    [self.dsoilLabs removeAllObjects];
}

- (void)reScan
{
    WeakSelf(self)
    CameraViewController *video = [CameraViewController new];
    video.resultCB = ^(NSString* text, UIImage* image) {
        weakself.carImage = image;
        weakself.carName = text;
        weakself.carImg.image = image;
        weakself.carLb.text = text;
        [weakself remberLastCar:text];
    };
    [weakself.navigationController pushViewController:video animated:YES];
}


- (void)takePhoto
{
    UIImagePickerController *pickerCon = [[UIImagePickerController alloc]init];
    pickerCon.sourceType = UIImagePickerControllerSourceTypeCamera;
    pickerCon.allowsEditing = NO;//是否可编辑
    pickerCon.delegate = self;
    [self presentViewController:pickerCon animated:YES completion:nil];
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
    [self getPriceData];
    for (int i = 0; i < self.soilArr.count; i++)
    {
        WorkConfigManageResponse *model = self.soilArr[i];
        model.isSelected = index == i;
        
        UILabel *label = self.soilLabs[i];
        label.textColor = model.isSelected ? [UIColor whiteColor] : [UIColor blackColor];
        label.backgroundColor = model.isSelected ? [UIColor jk_colorWithHexString:COLOR_BLUE] : [UIColor jk_colorWithHexString:COLOR_BACK];
    }
}

- (void)dsoilLbChange:(int)index
{
    self.seletedsSoil = self.dsoilArr[index];
    [self getPriceData];
    for (int i = 0; i < self.dsoilArr.count; i++)
    {
        WorkConfigManageResponse *model = self.dsoilArr[i];
        model.isSelected = index == i;
        
        UILabel *label = self.dsoilLabs[i];
        label.textColor = model.isSelected ? [UIColor whiteColor] : [UIColor blackColor];
        label.backgroundColor = model.isSelected ?[UIColor jk_colorWithHexString:COLOR_BLUE] : [UIColor jk_colorWithHexString:COLOR_BACK];
    }
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

- (void)uploadCarImg
{
    if (!self.photo)
    {
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请上传车斗照"];
        return;
    }
    [SVProgressHUD showWithStatus:@"上传中..."];
    WeakSelf(self)
    PostRequest *request = [[PostRequest alloc] initWithRequestUrl:bodyupload argument:@{} constructingBodyBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:UIImageJPEGRepresentation(self.photo, 0.3) name:@"file" fileName:[NSString stringWithFormat:@"%@.png",[Tools getNowTimeStamp]] mimeType:@"image/jpeg"];
    }];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        
        if (success)
        {
            NSString *imgUrl = result[@"data"];
            if (weakself.carImage)
            {
                [weakself uploadHeaderImg:imgUrl];
            }
            else
            {
                [weakself createOrder:imgUrl headerImg:@""];
            }
        }
        
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        [SVProgressHUD dismiss];
    }];
}

- (void)uploadHeaderImg:(NSString *)imgUrl
{
    WeakSelf(self)
    PostRequest *request = [[PostRequest alloc] initWithRequestUrl:headerupload argument:@{} constructingBodyBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:UIImageJPEGRepresentation(self.carImage, 0.5) name:@"file" fileName:[NSString stringWithFormat:@"%@.png",[Tools getNowTimeStamp]] mimeType:@"image/jpeg"];
    }];
    
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        
        if (success)
        {
            NSString *image = result[@"data"];
            [weakself createOrder:imgUrl headerImg:image];
        }
        
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        [SVProgressHUD dismiss];
    }];
}

- (void)createOrder:(NSString *)imageUrl headerImg:(NSString *)headerImg
{
    WeakSelf(self)
    NSString *url = self.isOut ? workorderoutaccess : workerorderinaccess;
    NSString *bodySize = self.isChange ? @"0": self.isOtherSize ? self.sizeTF.text: self.seletedCarSize.size;
    NSString *weight = self.isChange ? self.weightTF.text : @"0";
    NSString *soil = [Tools isEmpty:self.seletedSoil.workId] ? @"0" : self.seletedSoil.workId;
    NSString *ssoil = [Tools isEmpty:self.seletedsSoil.workId] ? @"0" : self.seletedsSoil.workId;
    PostRequest *request = [[PostRequest alloc] initWithRequestUrl:url argument:@{
                                                                                  @"projectId":self.projectId,
                                                                                  @"plateNumber":[Tools isEmpty:self.carLb.text] ? @"" : self.carLb.text,
                                                                                  @"bodySize":self.isOut ? bodySize : @"0",
                                                                                  @"weight":self.isOut ? weight : @"0",
                                                                                  @"tlxId":self.isOut ? soil : @"0",
                                                                                  @"ztcId":self.isOut ? ssoil : @"0",
                                                                                  @"driverName":self.isOut ? self.driveInput.textField.text : @"",
                                                                                  @"fleetId":self.isOut ? [Tools isEmpty:self.carTeamResponse.workId] ? @"0" : self.carTeamResponse.workId : @"0",
                                                                                  @"price":@"0",
                                                                                  @"remark":self.isOut ? self.remarkInput.textField.text : @"",
                                                                                  @"carBodyImg":imageUrl,
                                                                                  @"carHeaderImg":headerImg,
                                                                                  @"isException":[LoginInfoManage shareInstance].errorWorkOrder ? @"TRUE" : @"FALSE",
                                                                                  @"exception":self.isOut ? self.remarkInput.textField.text : @""
                                                                                }];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            [SVProgressHUD dismiss];
            if (weakself.isOut)
            {
                OrderDetailResponse *response = [OrderDetailResponse mj_objectWithKeyValues:result[@"data"]];
                [weakself printInfo:response];
            }
            else
            {
                [weakself.subject sendNext:@"1"];
                [weakself.navigationController popViewControllerAnimated:YES];
            }
            
        }
        
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        [SVProgressHUD dismiss];
    }];
}

- (void)printInfo:(OrderDetailResponse *)response
{
    NSString *number = self.printNo.infoLb.text;
    if ([number isEqualToString:@"不打印"])
    {
        [[RACScheduler mainThreadScheduler]afterDelay:1.0 schedule:^{
            [SVProgressHUD showInfoWithStatus:@"APP配置不打印"];
        }];
        [self.subject sendNext:@"1"];
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    if ([PTDispatcher share].printerConnected == nil)
    {
        
        [[RACScheduler mainThreadScheduler]afterDelay:1.0 schedule:^{
            [SVProgressHUD showInfoWithStatus:@"打印机未连接，请先连接"];
        }];
    }
    else
    {
        NSString *classNoStr = [response.workType isEqualToString:@"NIGHT_WORK"] ? @"晚班" : @"白班";
        for (int i = 0; i < [LoginInfoManage shareInstance].workConfigResponse.pointCount; i++)
        {
            [Tools printWithProjectName:response.projectName
                             codeString:response.orderNo
                                  carNo:response.plateNumber
                                company:response.companyName
                                orderNo:response.orderNo
                                soilWay:response.ztcName
                                  ztWay:response.tlxName
                            carTeamName:response.fleetName
                              outPeople:response.outReleaser
                                classNo:[NSString stringWithFormat:@"%@(%@)",classNoStr,[response.created substringToIndex:10]]
                                outTime:response.outReleaserTime
                              printTime:[Tools getCurrentTime]
                                  count:i+1
                                  price:response.price
                            isShowPrice:self.workConfigModel.printWithPrice];
        }
    }
    [self.subject sendNext:@"1"];
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma -- mark UIImagePickerControllerDelegate && UINavigationControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.photo = image;
    _carImg.image = image;
    _carImg.hidden = NO;
    _uploadImg.hidden = YES;
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self getPriceData];
}

-(UIImage*)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    return _carImg.image;
}


@end
