//
//  GLTextField.m
//  GoodLuck
//
//  Created by 徐志成 on 2022/7/6.
//

#import "GLTextField.h"

@implementation GLTextField

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.textColor = [UIColor jk_colorWithHexString:COLOR_242424];
        self.font = [UIFont systemFontOfSize:font_14];
    }
    return self;
}

- (void)placeHolderString:(NSString *)name
{
    NSAttributedString *attrstring = [[NSAttributedString alloc] initWithString:name
                                                                     attributes:@{NSForegroundColorAttributeName:[UIColor jk_colorWithHexString:@"#cccccc"],
                                                                                  NSFontAttributeName:self.font}];
    self.attributedPlaceholder = attrstring;
}

- (void)customerPlaceholder:(NSString *)name
{
    NSAttributedString *attrstring = [[NSAttributedString alloc] initWithString:name
                                                                     attributes:@{NSForegroundColorAttributeName:[UIColor jk_colorWithHexString:@"#cccccc"],
                                                                                  NSFontAttributeName:[UIFont systemFontOfSize:font_14]}];
    self.attributedPlaceholder = attrstring;
}

@end
