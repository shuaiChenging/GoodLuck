//
//  AddressBookVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/12.
//

#import "AddressBookVC.h"
#import "PPGetAddressBook.h"
#import "AddressBookCell.h"
@interface AddressBookVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *contactPeopleDict;
@property (nonatomic, strong) NSArray *keys;
@end

@implementation AddressBookVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"选择人员";
    self.view.backgroundColor = [UIColor whiteColor];
    /// 请求用户获取通讯录权限
//    [PPGetAddressBook requestAddressBookAuthorization];
    [self customerUI];
    WeakSelf(self);
    CNContactStore *contactStore = [[CNContactStore alloc] init];
    [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
        [weakself getData];
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
        [_tableView registerClass:AddressBookCell.class forCellReuseIdentifier:NSStringFromClass(AddressBookCell.class)];
    }
    return _tableView;
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

- (void)getData
{
    WeakSelf(self)
    //获取按联系人姓名首字拼音A~Z排序(已经对姓名的第二个字做了处理)
    [PPGetAddressBook getOrderAddressBook:^(NSDictionary<NSString *,NSArray *> *addressBookDict, NSArray *nameKeys) {
        weakself.contactPeopleDict = addressBookDict;
        weakself.keys = nameKeys;
        [weakself.tableView reloadData];
    } authorizationFailure:^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"请在iPhone的“设置-隐私-通讯录”选项中，允许好运来访问您的通讯录"
                                                       delegate:nil
                                              cancelButtonTitle:@"知道了"
                                              otherButtonTitles:nil];
        [alert show];
    }];
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.keys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *key = self.keys[section];
    return [self.contactPeopleDict[key] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor whiteColor];
    
    UILabel *lable = [UILabel labelWithText:self.keys[section]
                                       font:[UIFont systemFontOfSize:font_14]
                                  textColor:[UIColor jk_colorWithHexString:COLOR_242424]
                                  alignment:NSTextAlignmentLeft];
    [view addSubview:lable];
    [lable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view).offset(16);
        make.centerY.equalTo(view);
    }];
    
    return view;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.keys;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressBookCell *cell = [AddressBookCell cellWithCollectionView:tableView];
    NSString *key = self.keys[indexPath.section];
    PPPersonModel *people = [self.contactPeopleDict[key] objectAtIndex:indexPath.row];
    [cell loadViewWithName:people.name image:people.headerImage ? people.headerImage : [UIImage imageNamed:@"mange_detail_connect"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *key = self.keys[indexPath.section];
    PPPersonModel *people = [self.contactPeopleDict[key] objectAtIndex:indexPath.row];
    if (people.mobileArray.count > 0)
    {
        [self.subject sendNext:people.mobileArray[0]];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
