//
//  QYTagItem.m
//  QQtagView
//
//  Created by leaduMac on 2020/6/21.
//  Copyright © 2020 ZhangQun. All rights reserved.
//

#import "QYTagItem.h"

@implementation QYTagItem

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)layoutSubviews
{
    [super layoutSubviews];
    CGRect rect = self.imageView.frame;
    rect.size = CGSizeMake(15, 15);
    rect.origin.y = (self.frame.size.height - 15)/2;
    self.imageView.frame = rect;
}
@end
