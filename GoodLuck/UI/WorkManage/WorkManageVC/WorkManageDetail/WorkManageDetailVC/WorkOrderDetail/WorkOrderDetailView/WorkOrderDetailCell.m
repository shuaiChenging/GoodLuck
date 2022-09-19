//
//  WorkOrderDetailCell.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/16.
//

#import "WorkOrderDetailCell.h"
#import "LoginInfoManage.h"
#import "SDPhotoBrowser.h"
@interface WorkOrderDetailCell ()<SDPhotoBrowserDelegate>
@property (nonatomic, strong) UILabel *timeLb;
@property (nonatomic, strong) UILabel *carNoLb;
@property (nonatomic, strong) UILabel *orderNoLb;
@property (nonatomic, strong) UILabel *projectNameLb;
@property (nonatomic, strong) UILabel *orderStatusLb;
@property (nonatomic, strong) UILabel *carTeamLb;
@property (nonatomic, strong) UILabel *classesLb;
@property (nonatomic, strong) UILabel *priceLb;
@property (nonatomic, strong) UILabel *soilTypeLb;
@property (nonatomic, strong) UILabel *soilWayLb;
@property (nonatomic, strong) UILabel *carSizeLb;
@property (nonatomic, strong) UILabel *dateLb;
@property (nonatomic, strong) UILabel *driveNameLb;
@property (nonatomic, strong) UILabel *remarkLb;

@property (nonatomic, strong) UILabel *outPeopleLb;
@property (nonatomic, strong) UILabel *outTimeLb;

@property (nonatomic, strong) UILabel *inPeopleLb;
@property (nonatomic, strong) UILabel *inTimeLb;

@property (nonatomic, strong) UIImageView *outImg;
@property (nonatomic, strong) UIImageView *inImg;

@property (nonatomic, strong) UIImageView *carFontImg;
@property (nonatomic, strong) UIImageView *inCarFontImg;
@property (nonatomic, assign) int type;

@property (nonatomic, strong) UILabel *changeLb;
@property (nonatomic, strong) UILabel *printLb;
@end
@implementation WorkOrderDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
        self.type = 0;
        [self customerUI];
    }
    
    return self;
}

+ (instancetype)cellWithCollectionView:(UITableView *)tableView
{
    WorkOrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self)];
    return cell;
}

- (UILabel *)timeLb
{
    if (!_timeLb)
    {
        _timeLb = [UILabel labelWithText:@"2022.05.18 第一车"
                                    font:[UIFont boldSystemFontOfSize:font_14]
                               textColor:[UIColor jk_colorWithHexString:COLOR_BLUE]
                               alignment:NSTextAlignmentCenter];
    }
    return _timeLb;
}

- (UILabel *)carNoLb
{
    if (!_carNoLb)
    {
        _carNoLb = [UILabel labelWithText:@"浙A"
                                     font:[UIFont boldSystemFontOfSize:font_18]
                                textColor:[UIColor blackColor]
                                alignment:NSTextAlignmentCenter];
    }
    return _carNoLb;
}

- (UILabel *)orderNoLb
{
    if (!_orderNoLb)
    {
        _orderNoLb = [UILabel labelWithText:@"工单编号："
                                       font:[UIFont systemFontOfSize:font_13]
                                  textColor:[UIColor blackColor]
                                  alignment:NSTextAlignmentCenter];
    }
    return _orderNoLb;
}

- (UILabel *)projectNameLb
{
    if (!_projectNameLb)
    {
        _projectNameLb = [UILabel labelWithText:@"龙湖"
                                           font:[UIFont systemFontOfSize:font_14]
                                      textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                      alignment:NSTextAlignmentRight];
    }
    return _projectNameLb;
}

- (UILabel *)remarkLb
{
    if (!_remarkLb)
    {
        _remarkLb = [UILabel labelWithText:@"备注"
                                      font:[UIFont systemFontOfSize:font_14]
                                 textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                 alignment:NSTextAlignmentRight];
    }
    return _remarkLb;
}

- (UILabel *)orderStatusLb
{
    if (!_orderStatusLb)
    {
        _orderStatusLb = [UILabel labelWithText:@"已出场"
                                           font:[UIFont systemFontOfSize:font_14]
                                      textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                      alignment:NSTextAlignmentRight];
    }
    return _orderStatusLb;
}

- (UILabel *)driveNameLb
{
    if (!_driveNameLb)
    {
        _driveNameLb = [UILabel labelWithText:@"司机"
                                         font:[UIFont systemFontOfSize:font_14]
                                    textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                    alignment:NSTextAlignmentRight];
    }
    return _driveNameLb;
}

- (UILabel *)carTeamLb
{
    if (!_carTeamLb)
    {
        _carTeamLb = [UILabel labelWithText:@"小刚"
                                       font:[UIFont systemFontOfSize:font_14]
                                  textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                  alignment:NSTextAlignmentRight];
    }
    return _carTeamLb;
}

- (UILabel *)classesLb
{
    if (!_classesLb)
    {
        _classesLb = [UILabel labelWithText:@"白班"
                                       font:[UIFont systemFontOfSize:font_14]
                                  textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                  alignment:NSTextAlignmentRight];
    }
    return _classesLb;
}

- (UILabel *)priceLb
{
    if (!_priceLb)
    {
        _priceLb = [UILabel labelWithText:@"0元"
                                     font:[UIFont systemFontOfSize:font_14]
                                textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                alignment:NSTextAlignmentRight];
    }
    return _priceLb;
}

- (UILabel *)soilTypeLb
{
    if (!_soilTypeLb)
    {
        _soilTypeLb = [UILabel labelWithText:@"黑土"
                                        font:[UIFont systemFontOfSize:font_14]
                                   textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                   alignment:NSTextAlignmentRight];
    }
    return _soilTypeLb;
}

- (UILabel *)soilWayLb
{
    if (!_soilWayLb)
    {
        _soilWayLb = [UILabel labelWithText:@"自倒"
                                       font:[UIFont systemFontOfSize:font_14]
                                  textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                  alignment:NSTextAlignmentRight];
    }
    return _soilWayLb;
}

- (UILabel *)carSizeLb
{
    if (!_carSizeLb)
    {
        _carSizeLb = [UILabel labelWithText:@"20"
                                       font:[UIFont systemFontOfSize:font_14]
                                  textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                  alignment:NSTextAlignmentRight];
    }
    return _carSizeLb;
}

- (UILabel *)dateLb
{
    if (!_dateLb)
    {
        _dateLb = [UILabel labelWithText:@"2022"
                                    font:[UIFont systemFontOfSize:font_14]
                               textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                               alignment:NSTextAlignmentRight];
    }
    return _dateLb;
}

- (UILabel *)outPeopleLb
{
    if (!_outPeopleLb)
    {
        _outPeopleLb = [UILabel labelWithText:@"出场放行人"
                                         font:[UIFont systemFontOfSize:font_14]
                                    textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                    alignment:NSTextAlignmentRight];
    }
    return _outPeopleLb;
}

- (UILabel *)outTimeLb
{
    if (!_outTimeLb)
    {
        _outTimeLb = [UILabel labelWithText:@"2022"
                                       font:[UIFont systemFontOfSize:font_14]
                                  textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                  alignment:NSTextAlignmentRight];
    }
    return _outTimeLb;
}

- (UILabel *)inPeopleLb
{
    if (!_inPeopleLb)
    {
        _inPeopleLb = [UILabel labelWithText:@"入场放行人"
                                        font:[UIFont systemFontOfSize:font_14]
                                   textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                   alignment:NSTextAlignmentRight];
    }
    return _inPeopleLb;
}

- (UILabel *)inTimeLb
{
    if (!_inTimeLb)
    {
        _inTimeLb = [UILabel labelWithText:@"2022"
                                      font:[UIFont systemFontOfSize:font_14]
                                 textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                 alignment:NSTextAlignmentRight];
    }
    return _inTimeLb;
}

- (UIImageView *)outImg
{
    if (!_outImg)
    {
        _outImg = [UIImageView new];
        _outImg.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
        _outImg.userInteractionEnabled = YES;
    }
    return _outImg;
}

- (UIImageView *)inImg
{
    if (!_inImg)
    {
        _inImg = [UIImageView new];
        _inImg.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
        _inImg.userInteractionEnabled = YES;
    }
    return _inImg;
}

- (UIImageView *)carFontImg
{
    if (!_carFontImg)
    {
        _carFontImg = [UIImageView new];
        _carFontImg.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
        _carFontImg.userInteractionEnabled = YES;
    }
    return _carFontImg;
}

- (UIImageView *)inCarFontImg
{
    if (!_inCarFontImg)
    {
        _inCarFontImg = [UIImageView new];
        _inCarFontImg.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BACK];
        _inCarFontImg.userInteractionEnabled = YES;
    }
    return _inCarFontImg;
}

- (void)customerUI
{
    UIView *backView = [UIView new];
    backView.backgroundColor = [UIColor whiteColor];
    backView.layer.masksToBounds = YES;
    backView.layer.cornerRadius = 5;
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).offset(-20);
    }];
    
    WeakSelf(self)
    
    [backView addSubview:self.timeLb];
    [_timeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(backView).offset(40);
        make.centerX.equalTo(backView);
    }];
    
    [backView addSubview:self.carNoLb];
    [_carNoLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timeLb.mas_bottom).offset(10);
        make.centerX.equalTo(backView);
    }];
    
    [backView addSubview:self.orderNoLb];
    [_orderNoLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.carNoLb.mas_bottom).offset(10);
        make.centerX.equalTo(backView);
    }];
    
    UILabel *workName = [UILabel labelWithText:@"工地名称"
                                          font:[UIFont systemFontOfSize:font_14]
                                     textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                     alignment:NSTextAlignmentLeft];
    [backView addSubview:workName];
    [workName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderNoLb.mas_bottom).offset(40);
        make.left.equalTo(backView).offset(16);
    }];
    
    [backView addSubview:self.projectNameLb];
    [_projectNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-16);
        make.centerY.equalTo(workName);
    }];
    
    UILabel *workState = [UILabel labelWithText:@"工单状态"
                                           font:[UIFont systemFontOfSize:font_14]
                                      textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                      alignment:NSTextAlignmentLeft];
    [backView addSubview:workState];
    [workState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(workName.mas_bottom).offset(18);
        make.left.equalTo(workName);
    }];
    
    [backView addSubview:self.orderStatusLb];
    [_orderStatusLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-16);
        make.centerY.equalTo(workState);
    }];
    
    UILabel *carTeam = [UILabel labelWithText:@"车队名称"
                                         font:[UIFont systemFontOfSize:font_14]
                                    textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                    alignment:NSTextAlignmentLeft];
    [backView addSubview:carTeam];
    [carTeam mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(workState.mas_bottom).offset(18);
        make.left.equalTo(workName);
    }];
    
    [backView addSubview:self.carTeamLb];
    [_carTeamLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-16);
        make.centerY.equalTo(carTeam);
    }];
    
    UILabel *driveName = [UILabel labelWithText:@"司机"
                                           font:[UIFont systemFontOfSize:font_14]
                                      textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                      alignment:NSTextAlignmentLeft];
    [backView addSubview:driveName];
    [driveName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(carTeam.mas_bottom).offset(18);
        make.left.equalTo(carTeam);
    }];
    
    [backView addSubview:self.driveNameLb];
    [_driveNameLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-16);
        make.centerY.equalTo(driveName);
    }];

    UILabel *className = [UILabel labelWithText:@"班次"
                                           font:[UIFont systemFontOfSize:font_14]
                                      textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                      alignment:NSTextAlignmentLeft];
    [backView addSubview:className];
    [className mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(driveName.mas_bottom).offset(18);
        make.left.equalTo(driveName);
    }];
    
    [backView addSubview:self.classesLb];
    [_classesLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-16);
        make.centerY.equalTo(className);
    }];

    UILabel *price = [UILabel labelWithText:@"价格"
                                       font:[UIFont systemFontOfSize:font_14]
                                  textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                  alignment:NSTextAlignmentLeft];
    [backView addSubview:price];
    [price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(className.mas_bottom).offset(18);
        make.left.equalTo(workName);
    }];
    
    [backView addSubview:self.priceLb];
    [_priceLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-16);
        make.centerY.equalTo(price);
    }];

    UILabel *ztType = [UILabel labelWithText:@"渣土类型"
                                        font:[UIFont systemFontOfSize:font_14]
                                   textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                   alignment:NSTextAlignmentLeft];
    [backView addSubview:ztType];
    [ztType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(price.mas_bottom).offset(18);
        make.left.equalTo(workName);
    }];
    
    [backView addSubview:self.soilTypeLb];
    [_soilTypeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-16);
        make.centerY.equalTo(ztType);
    }];

    UILabel *dtWay = [UILabel labelWithText:@"倒土方式"
                                       font:[UIFont systemFontOfSize:font_14]
                                  textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                  alignment:NSTextAlignmentLeft];
    [backView addSubview:dtWay];
    [dtWay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ztType.mas_bottom).offset(18);
        make.left.equalTo(workName);
    }];
    
    [backView addSubview:self.soilWayLb];
    [_soilWayLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-16);
        make.centerY.equalTo(dtWay);
    }];

    UILabel *carSize = [UILabel labelWithText:@"车斗大小"
                                         font:[UIFont systemFontOfSize:font_14]
                                    textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                    alignment:NSTextAlignmentLeft];
    [backView addSubview:carSize];
    [carSize mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dtWay.mas_bottom).offset(18);
        make.left.equalTo(workName);
    }];
    
    [backView addSubview:self.carSizeLb];
    [_carSizeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-16);
        make.centerY.equalTo(carSize);
    }];
    
    UILabel *remark = [UILabel labelWithText:@"备注"
                                        font:[UIFont systemFontOfSize:font_14]
                                   textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                   alignment:NSTextAlignmentLeft];
    [backView addSubview:remark];
    [remark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(carSize.mas_bottom).offset(18);
        make.left.equalTo(carSize);
    }];
    
    [backView addSubview:self.remarkLb];
    [_remarkLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-16);
        make.centerY.equalTo(remark);
    }];
    
    UILabel *date = [UILabel labelWithText:@"日期"
                                      font:[UIFont systemFontOfSize:font_14]
                                 textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                 alignment:NSTextAlignmentLeft];
    [backView addSubview:date];
    [date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(remark.mas_bottom).offset(18);
        make.left.equalTo(remark);
    }];
    
    [backView addSubview:self.dateLb];
    [_dateLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(backView).offset(-16);
        make.centerY.equalTo(date);
    }];
    
    [backView addSubview:self.outPeopleLb];
    [_outPeopleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(workName);
        make.top.equalTo(self.dateLb.mas_bottom).offset(30);
    }];
    
    [backView addSubview:self.outTimeLb];
    [_outTimeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(workName);
        make.top.equalTo(self.outPeopleLb.mas_bottom).offset(8);
    }];
    
    [backView addSubview:self.outImg];
    [_outImg jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        weakself.type = 1;
        [weakself showBigImg];
    }];
    [_outImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo((kScreenWidth - 64 - 10)/2);
        make.height.equalTo(120);
        make.left.equalTo(workName);
        make.top.equalTo(self.outTimeLb.mas_bottom).offset(8);
    }];

    [backView addSubview:self.inPeopleLb];
    [_inPeopleLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.outImg.mas_right).offset(10);
        make.top.equalTo(self.outPeopleLb);
    }];

    [backView addSubview:self.inTimeLb];
    [_inTimeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.inPeopleLb);
        make.top.equalTo(self.outTimeLb);
    }];

    [backView addSubview:self.inImg];
    [_inImg jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        weakself.type = 2;
        [weakself showBigImg];
    }];
    [_inImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo((kScreenWidth - 64 - 10)/2);
        make.height.equalTo(120);
        make.left.equalTo(self.outImg.mas_right).offset(10);
        make.top.equalTo(self.inTimeLb.mas_bottom).offset(8);
    }];

    UILabel *carFront = [UILabel labelWithText:@"车斗照"
                                          font:[UIFont systemFontOfSize:font_14]
                                     textColor:[UIColor jk_colorWithHexString:@"#989898"]
                                     alignment:NSTextAlignmentLeft];
    [backView addSubview:carFront];
    [carFront mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(workName);
        make.top.equalTo(self.outImg.mas_bottom).offset(16);
    }];

    [backView addSubview:self.carFontImg];
    [_carFontImg jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        weakself.type = 3;
        [weakself showBigImg];
    }];
    [_carFontImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo((kScreenWidth - 64 - 10)/2);
        make.height.equalTo(120);
        make.left.equalTo(workName);
        make.top.equalTo(carFront.mas_bottom).offset(8);
    }];

    [backView addSubview:self.inCarFontImg];
    [_inCarFontImg jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        weakself.type = 4;
        [weakself showBigImg];
    }];
    [_inCarFontImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo((kScreenWidth - 64 - 10)/2);
        make.height.equalTo(120);
        make.left.equalTo(self.carFontImg.mas_right).offset(10);
        make.top.equalTo(self.carFontImg);
    }];


    UILabel *changeLb = [UILabel labelWithText:@"修改工单"
                                          font:[UIFont systemFontOfSize:font_14]
                                     textColor:[UIColor jk_colorWithHexString:COLOR_BLUE]
                                     alignment:NSTextAlignmentCenter];
    self.changeLb = changeLb;
    changeLb.userInteractionEnabled = YES;
    changeLb.hidden = [LoginInfoManage shareInstance].isBoss;
    changeLb.backgroundColor = [UIColor whiteColor];
    changeLb.layer.borderColor = [UIColor jk_colorWithHexString:COLOR_BLUE].CGColor;
    changeLb.layer.borderWidth = 1;
    changeLb.layer.cornerRadius = 2;
    [changeLb jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        if (weakself.seletedChange)
        {
            weakself.seletedChange(@"1");
        }
    }];
    [backView addSubview:changeLb];
    [changeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.carFontImg.mas_bottom).offset(30);
        make.centerX.equalTo(backView);
        make.width.equalTo(100);
        make.height.equalTo(30);
    }];

    UILabel *printLb = [UILabel labelWithText:@"打印工单"
                                         font:[UIFont systemFontOfSize:font_16]
                                    textColor:[UIColor whiteColor]
                                    alignment:NSTextAlignmentCenter];
    self.printLb = printLb;
    printLb.userInteractionEnabled = YES;
    printLb.hidden = [LoginInfoManage shareInstance].isBoss;
    [printLb jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        if (weakself.seletedChange)
        {
            weakself.seletedChange(@"2");
        }
    }];
    printLb.layer.masksToBounds = YES;
    printLb.layer.cornerRadius = 5;
    printLb.backgroundColor = [UIColor jk_colorWithHexString:COLOR_BLUE];
    [backView addSubview:printLb];
    [printLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(44);
        make.left.equalTo(backView).offset(16);
        make.right.equalTo(backView).offset(-16);
        make.top.equalTo(changeLb.mas_bottom).offset(30);
    }];
}

- (void)showBigImg
{
    SDPhotoBrowser *browser = [SDPhotoBrowser new];
    browser.currentImageIndex = 0;
    browser.sourceImagesContainerView = self.contentView;
    browser.imageCount = 1;
    browser.delegate = self;
    [browser show];
}

- (void)loadViewWithModel:(OrderDetailResponse *)response change:(SeletedChange)change isDelete:(BOOL)isDelete
{
    self.seletedChange = change;
    _timeLb.text = response.name;
    _carNoLb.text = response.plateNumber;
    _orderNoLb.text = [NSString stringWithFormat:@"工单编号：%@",response.orderNo];
    _projectNameLb.text = response.projectName;
    _orderStatusLb.text = [response.status isEqualToString:@"NOT_OUT"] ? @"未出场":@"已出场";
    _carTeamLb.text = response.fleetName;
    _driveNameLb.text = response.driverName;
    _remarkLb.text = response.remark;
    
    _classesLb.text = [response.workType isEqualToString:@"NIGHT_WORK"] ? @"晚班" : @"白班";
    _priceLb.text = [NSString stringWithFormat:@"%@元/车",response.price];
    _soilTypeLb.text = response.tlxName;
    _soilWayLb.text = response.ztcName;
    _carSizeLb.text = response.weight > 0 ? [NSString stringWithFormat:@"%d吨",response.weight] : [NSString stringWithFormat:@"%@方",response.bodySize];
    _dateLb.text = [response.created substringToIndex:10];
    
    _outPeopleLb.text = [NSString stringWithFormat:@"出场放行人：%@",response.outReleaser];
    _outTimeLb.text = response.outReleaserTime;
    
    _inPeopleLb.text = [NSString stringWithFormat:@"入场放行人：%@",response.inReleaser];
    _inTimeLb.text = response.inReleaserTime;
    
    _inPeopleLb.hidden = [Tools isEmpty:response.inReleaser];
    _inTimeLb.hidden = [Tools isEmpty:response.inReleaserTime];
    _inImg.hidden = _inCarFontImg.hidden = _inPeopleLb.hidden;
    
    [_outImg sd_setImageWithURL:[NSURL URLWithString:response.outCarHeaderImg] placeholderImage:[UIImage imageNamed:@""]];
    [_inImg sd_setImageWithURL:[NSURL URLWithString:response.inCarHeaderImg] placeholderImage:[UIImage imageNamed:@""]];

    [_carFontImg sd_setImageWithURL:[NSURL URLWithString:response.outCarBodyImg] placeholderImage:[UIImage imageNamed:@""]];
    [_inCarFontImg sd_setImageWithURL:[NSURL URLWithString:response.inCarBodyImg] placeholderImage:[UIImage imageNamed:@""]];
    
    self.changeLb.hidden = self.printLb.hidden = [LoginInfoManage shareInstance].isBoss || isDelete;
}

-(UIImage*)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    switch (self.type) {
        case 1:
        {
            return self.outImg.image;
            break;
        }
        case 2:
        {
            return self.inImg.image;
            break;
        }
        case 3:
        {
            return self.carFontImg.image;
            break;
        }
        case 4:
        {
            return self.inCarFontImg.image;
            break;
        }
        default:
            return [UIImage imageNamed:@""];
            break;
    }
}

@end
