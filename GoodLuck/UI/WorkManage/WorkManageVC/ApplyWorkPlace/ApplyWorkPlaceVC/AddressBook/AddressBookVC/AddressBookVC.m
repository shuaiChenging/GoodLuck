//
//  AddressBookVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/12.
//

#import "AddressBookVC.h"
#import "PPGetAddressBook.h"
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
    [self customerUI];
    [self getData];
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor jk_colorWithHexString:@"#eeeeee"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                        message:@"请在iPhone的“设置-隐私-通讯录”选项中，允许PPAddressBook访问您的通讯录"
//                                                       delegate:nil
//                                              cancelButtonTitle:@"知道了"
//                                              otherButtonTitles:nil];
//        [alert show];
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.keys[section];
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.keys;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuseIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    NSString *key = self.keys[indexPath.section];
    PPPersonModel *people = [self.contactPeopleDict[key] objectAtIndex:indexPath.row];
    cell.imageView.image = people.headerImage ? people.headerImage : [UIImage imageNamed:@"book_address_default"];
    cell.imageView.clipsToBounds = YES;
    cell.textLabel.text = people.name;
    
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
