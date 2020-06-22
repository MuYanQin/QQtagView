//
//  MCFactory.h
//  QQFoundation
//
//  Created by qinmuqiao on 2018/7/4.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MCFactory : NSObject

UIColor * getColor(CGFloat red,CGFloat gree, CGFloat blue);

UIColor * getColorWithAlpha(CGFloat red,CGFloat gree, CGFloat blue,CGFloat alpha);

UIColor * getColorWithHex(NSString *hex);

NSString * getHexWithColor(UIColor *color);

NSArray  * getRGBWithColor(UIColor *color);

UIImage * getColorImage(UIColor *color);





@end
