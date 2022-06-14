//
//  RoleApproveVC.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/6.
//

#import "RoleApproveVC.h"

@interface RoleApproveVC ()

@end

@implementation RoleApproveVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"角色审批";
    [self customerUI];
    [self getData];
}

- (void)getData
{
    GetRequest *request = [[GetRequest alloc] initWithRequestUrl:listapply argument:@{@"projectId":self.projectId,@"role":@"BOSS"}];
    [request startWithCompletionBlockWithSuccess:^(__kindof Request * _Nonnull request, NSDictionary * _Nonnull result, BOOL success) {
        if (success)
        {
            
        }
    } failure:^(__kindof Request * _Nonnull request, NSString * _Nonnull errorInfo) {
        
    }];
}

- (void)customerUI
{
    
}

@end
