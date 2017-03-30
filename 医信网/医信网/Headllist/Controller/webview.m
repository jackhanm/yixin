//
//  webview.m
//  医信网
//
//  Created by yuhao on 2017/1/13.
//  Copyright © 2017年 sjq. All rights reserved.
//

#import "webview.h"
#import "UIView+Extension.h"
@implementation webview

- (instancetype)init
{
    self = [super init];
    if (self) {
        UILabel *label = [[UILabel alloc]init];
        label.font = [UIFont systemFontOfSize:65];
        
        label.textAlignment = NSTextAlignmentCenter;
        self.label = label;
        [self addSubview:label];
        
        self.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.label.width = self.width;
    self.label.height = self.height;
    self.label.x = 0;
    self.label.y = 0;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
