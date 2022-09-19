//
//  WorkContentScrollView.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/9/5.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WorkContentScrollView : UIScrollView
@property (nonatomic, strong) GLTableView *carTab;
@property (nonatomic, strong) GLTableView *ztcTab;
@property (nonatomic, strong) GLTableView *zdTab;
@property (nonatomic, strong) GLTableView *cardTab;
@property (nonatomic, strong) GLTableView *carTeamTab;
@property (nonatomic, strong) GLTableView *soilTab;
@property (nonatomic, strong) GLTableView *historyTab;
@end

NS_ASSUME_NONNULL_END
