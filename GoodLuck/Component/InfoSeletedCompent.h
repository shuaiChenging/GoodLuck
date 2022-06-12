//
//  InfoSeletedCompent.h
//  GoodLuck
//
//  Created by 徐志成 on 2022/6/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface InfoSeletedCompent : UIView
@property (nonatomic, strong) UILabel *infoLb;
- (void)setName:(NSString *)name info:(NSString *)info;
@end

NS_ASSUME_NONNULL_END
