//
//  PrintNumberVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/8.
//

#import "PrintNumberVC.h"
#import "PrintNumberModel.h"
#import "PrintNumberCell.h"
#import "DDDataStorageManage.h"
#import "LoginInfoManage.h"
@interface PrintNumberVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<PrintNumberModel *> *source;
@end

@implementation PrintNumberVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.source = @[[[PrintNumberModel alloc] initWithName:@"不打印" isSelected:NO],
                    [[PrintNumberModel alloc] initWithName:@"一联" isSelected:NO],
                    [[PrintNumberModel alloc] initWithName:@"二联" isSelected:YES],
                    [[PrintNumberModel alloc] initWithName:@"三联" isSelected:NO],
                    [[PrintNumberModel alloc] initWithName:@"四联" isSelected:NO]];
    NSString *seletedName = @"不打印";
    switch ([LoginInfoManage shareInstance].workConfigResponse.pointCount) {
        case 1:
        {
            seletedName = @"一联";
            break;
        }
        case 2:
        {
            seletedName = @"二联";
            break;
        }
        case 3:
        {
            seletedName = @"三联";
            break;
        }
        case 4:
        {
            seletedName = @"四联";
            break;
        }
        default:
            break;
    }
    for (PrintNumberModel *model in self.source)
    {
        model.isSelected = [seletedName isEqualToString:model.name];
    }
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

- (void)customerUI
{
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}
- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:PrintNumberCell.class forCellReuseIdentifier:NSStringFromClass(PrintNumberCell.class)];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource && UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.source.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PrintNumberCell *cell = [PrintNumberCell cellWithCollectionView:tableView];
    [cell loadViewWithModel:self.source[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PrintNumberModel *model = self.source[indexPath.row];
    [DDDataStorageManage userDefaultsSaveObject:model.name forKey:PRINTNUMBER];
    [self.subject sendNext:model];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
