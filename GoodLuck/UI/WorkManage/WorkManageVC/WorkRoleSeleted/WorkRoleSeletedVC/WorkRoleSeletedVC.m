//
//  WorkRoleSeletedVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/4.
//

#import "WorkRoleSeletedVC.h"
#import "RoleView.h"
#import "RoleModel.h"
@interface WorkRoleSeletedVC ()
@property (nonatomic, strong) NSArray *roleInfos;
@property (nonatomic, strong) NSMutableArray *roleViews;
@end

@implementation WorkRoleSeletedVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"工作角色";
    [self dataInit];
    self.view.backgroundColor = [UIColor whiteColor];
    self.roleViews = [NSMutableArray arrayWithCapacity:0];
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

- (void)dataInit
{
    NSString *roleType = [DDDataStorageManage userDefaultsGetObjectWithKey:ROLETYPE];
    
    if (![Tools isEmpty:roleType])
    {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancle)];
    }
    
    RoleModel *bossModel = [RoleModel new];
    bossModel.imageName = @"";
    bossModel.name = @"工地老板";
    bossModel.isSeleted = [roleType isEqualToString:@"1"];
    
    RoleModel *manageModel = [RoleModel new];
    manageModel.imageName = @"";
    manageModel.name = @"工地管理员";
    manageModel.isSeleted = [roleType isEqualToString:@"2"];
    
    self.roleInfos = @[bossModel,manageModel];
}

- (void)cancle
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)customerUI
{
    UILabel *descrbeLb = [UILabel labelWithText:@"请选择您在工作中的角色"
                                           font:[UIFont boldSystemFontOfSize:16]
                                      textColor:[UIColor jk_colorWithHexString:@"#666666"]
                                      alignment:NSTextAlignmentCenter];
    [self.view addSubview:descrbeLb];
    [descrbeLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(60);
    }];
    
    __weak typeof(self) weakSelf = self;
    RoleView *lastView = [RoleView new];
    @autoreleasepool {
        for (int i = 0; i < self.roleInfos.count; i++)
        {
            RoleView *roleView = [RoleView new];
            RoleModel *model = self.roleInfos[i];
            [roleView setRole:[UIImage imageNamed:model.imageName]
                         name:model.name
                    isSeleted:model.isSeleted];
            [roleView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
                [weakSelf changeState:i];
            }];
            lastView = roleView;
            [self.view addSubview:roleView];
            [self.roleViews addObject:roleView];
            [roleView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(descrbeLb.mas_bottom).offset(40);
                if (i == 0)
                {
                    make.left.equalTo(self.view);
                }
                else
                {
                    make.left.equalTo(self.view).offset(kScreenWidth/3);
                }
                make.width.equalTo(kScreenWidth/3);
                make.height.equalTo(100);
            }];
        }
    }
}

- (void)changeState:(int)index
{
    @autoreleasepool {
        for (int i = 0; i < self.roleInfos.count;i++)
        {
            RoleModel *model = self.roleInfos[i];
            model.isSeleted = i == index ? YES : NO;
        }
        
        for (int i = 0; i < self.roleInfos.count;i++)
        {
            RoleModel *model = self.roleInfos[i];
            RoleView *roleView = self.roleViews[i];
            [roleView setRole:[UIImage imageNamed:model.imageName]
                         name:model.name
                    isSeleted:model.isSeleted];
        }
    }
    [DDDataStorageManage userDefaultsSaveObject:index == 0 ? @"1":@"2" forKey:ROLETYPE];
    [self.subject sendNext:@"1"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
