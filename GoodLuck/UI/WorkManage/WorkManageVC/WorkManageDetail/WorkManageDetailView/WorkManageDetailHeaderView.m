//
//  WorkManageDetailHeaderView.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/5.
//

#import "WorkManageDetailHeaderView.h"


#import "LoginInfoManage.h"
#import <MAMapKit/MAMapKit.h>
@interface WorkManageDetailHeaderView ()<MAMapViewDelegate>

@property (nonatomic, strong) MAMapView *mapView;
@end
@implementation WorkManageDetailHeaderView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self customerUI];
    }
    return self;
}

- (WorkOrderStatisticsView *)workOrderView
{
    if (!_workOrderView)
    {
        _workOrderView = [WorkOrderStatisticsView new];
    }
    return _workOrderView;
}

- (void)setProjectId:(NSString *)projectId
{
    _workOrderView.projectId = projectId;
}

- (UILabel *)currentPeople
{
    if (!_currentPeople)
    {
        _currentPeople = [UILabel labelWithText:@"当前上班管理员："
                                           font:[UIFont systemFontOfSize:font_12]
                                      textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                      alignment:NSTextAlignmentLeft];
    }
    return _currentPeople;
}

- (UIView *)scanView
{
    if (!_scanView)
    {
        _scanView = [UIView new];
        _scanView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
        _scanView.layer.masksToBounds = YES;
        _scanView.layer.cornerRadius = 45;
        _scanView.userInteractionEnabled = YES;
        _scanView.hidden = [LoginInfoManage shareInstance].isBoss;
    }
    return _scanView;
}

- (UIView *)carNumberView
{
    if (!_carNumberView)
    {
        _carNumberView = [UIView new];
        _carNumberView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
        _carNumberView.layer.masksToBounds = YES;
        _carNumberView.layer.cornerRadius = 45;
        _carNumberView.userInteractionEnabled = YES;
        _carNumberView.hidden = [LoginInfoManage shareInstance].isBoss;
    }
    return _carNumberView;
}


- (WorkManageHandleView *)handleView
{
    if (!_handleView)
    {
        _handleView = [WorkManageHandleView new];
    }
    return _handleView;
}

- (WorkManageDetalAdmiView *)admiView
{
    if (!_admiView)
    {
        _admiView = [WorkManageDetalAdmiView new];
    }
    return _admiView;
}

- (RACSubject *)subject
{
    if (!_subject)
    {
        _subject = [RACSubject new];
    }
    return _subject;
}

- (MAMapView *)mapView
{
    if (!_mapView)
    {
        _mapView = [MAMapView new];
        _mapView.showsCompass = NO;
        _mapView.delegate = self;
    }
    return _mapView;
}

- (WorkStatisticsView *)workStatisicsView
{
    if (!_workStatisicsView)
    {
        _workStatisicsView = [WorkStatisticsView new];
    }
    return _workStatisicsView;
}

- (void)customerUI
{
    if ([LoginInfoManage shareInstance].isBoss)
    {
        [self addSubview:self.handleView];
        [_handleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
        }];
    }
    else
    {
        [self addSubview:self.admiView];
        [_admiView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.height.equalTo(46);
        }];
    }
    
    [self addSubview:self.mapView];
    [_mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo( [LoginInfoManage shareInstance].isBoss ? self.handleView.mas_bottom : self.admiView.mas_bottom);
        make.height.equalTo([LoginInfoManage shareInstance].isBoss ? 160 : 220);
    }];
    
    [self addSubview:self.scanView];
    [_scanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(90);
        make.centerX.equalTo(self).offset(-70);
        make.top.equalTo(self.mapView).offset(40);
    }];
    
    UIImageView *scanImg = [UIImageView jk_imageViewWithImageNamed:@"mange_detail_scan"];
    [_scanView addSubview:scanImg];
    [scanImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scanView).offset(20);
        make.width.height.equalTo(24);
        make.centerX.equalTo(self.scanView);
    }];
    
    UILabel *scanLb = [UILabel labelWithText:@"扫描车牌"
                                        font:[UIFont systemFontOfSize:font_12]
                                   textColor:[UIColor whiteColor]
                                   alignment:NSTextAlignmentCenter];
    [_scanView addSubview:scanLb];
    [scanLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scanImg.mas_bottom).offset(10);
        make.centerX.equalTo(scanImg);
    }];
    
    [self addSubview:self.carNumberView];
    [_carNumberView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(90);
        make.centerX.equalTo(self).offset(70);
        make.top.equalTo(self.mapView).offset(40);
    }];
    
    UIImageView *carImg = [UIImageView jk_imageViewWithImageNamed:@"mange_detail_edit"];
    [_carNumberView addSubview:carImg];
    [carImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.carNumberView).offset(20);
        make.width.height.equalTo(24);
        make.centerX.equalTo(self.carNumberView);
    }];
    
    UILabel *carLb = [UILabel labelWithText:@"输入车牌"
                                        font:[UIFont systemFontOfSize:font_12]
                                   textColor:[UIColor whiteColor]
                                   alignment:NSTextAlignmentCenter];
    [_carNumberView addSubview:carLb];
    [carLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(carImg.mas_bottom).offset(10);
        make.centerX.equalTo(carImg);
    }];
    
    UIView *currentBack = [UIView new];
    currentBack.layer.masksToBounds = YES;
    currentBack.layer.cornerRadius = 5;
    currentBack.backgroundColor = [UIColor jk_colorWithHexString:COLOR_E6F0FC];
    [self addSubview:currentBack];
    [currentBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mapView).offset(-10);
        make.left.equalTo(self).offset(16);
        make.height.equalTo(42);
        make.right.equalTo(self).offset(-70);
    }];
    
    UIImageView *img = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[LoginInfoManage shareInstance].isBoss ? @"home_seleted_boss":@"home_seleted_admin"]];
    [currentBack addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(28);
        make.left.equalTo(currentBack).offset(16);
        make.centerY.equalTo(currentBack);
    }];
    
    [currentBack addSubview:self.currentPeople];
    [_currentPeople mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(img.mas_right).offset(8);
        make.centerY.equalTo(img);
        make.right.equalTo(currentBack).offset(-16);
    }];
    
    [self addSubview:self.workOrderView];
    [_workOrderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mapView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(194);
    }];
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.equalTo(10);
        make.top.equalTo(self.workOrderView.mas_bottom);
    }];
    
    WeakSelf(self)
    [self addSubview:self.workStatisicsView];
    [_workStatisicsView.subject subscribeNext:^(id  _Nullable x) {
        [weakself.subject sendNext:x];
    }];
    [_workStatisicsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(100);
    }];
}

- (void)loadOrderWithModel:(WorkOrderResponse *)response
{
    [self.workOrderView loadOrderWithModel:response];
}

- (void)loadMapInfo:(WorkDetailResponse *)response
{
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake([response.latitude doubleValue], [response.longitude doubleValue]);
    MACoordinateRegion region = MACoordinateRegionMakeWithDistance(location,5000 ,5000);
    MACoordinateRegion adjustedRegion = [_mapView regionThatFits:region];
    [_mapView setRegion:adjustedRegion animated:NO];
    
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = location;
    pointAnnotation.title = response.name;
    [_mapView addAnnotation:pointAnnotation];
}

#pragma mark - MAMapViewDelegate
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout = YES;       //设置气泡可以弹出，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
    }
    return nil;
}

@end
