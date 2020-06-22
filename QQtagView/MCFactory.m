//
//  MCFactory.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/7/4.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "MCFactory.h"
@implementation MCFactory
UIColor * getColor(CGFloat red,CGFloat gree, CGFloat blue)
{
    return [UIColor colorWithRed:red/255.f green:gree/255.f blue:blue/255.f alpha:1];
}

UIColor * getColorWithAlpha(CGFloat red,CGFloat gree, CGFloat blue,CGFloat alpha)
{
    return [UIColor colorWithRed:red/255.f green:gree/255.f blue:blue/255.f alpha:alpha];
}

UIColor * getColorWithHex(NSString *hex)
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    if ([cString hasPrefix:@"0X"]||[cString hasPrefix:@"0x"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    NSScanner *scanner = [NSScanner scannerWithString:cString];
    unsigned hexNum;
    if (![scanner scanHexInt:&hexNum]) return nil;
    int r = (hexNum >> 16) & 0xFF;
    int g = (hexNum >> 8) & 0xFF;
    int b = (hexNum) & 0xFF;
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:1.0f];
}
NSString *getHexWithColor(UIColor *color)
{
    const CGFloat *cs=CGColorGetComponents(color.CGColor);
    NSString *r = [NSString stringWithFormat:@"%@",getHex(cs[0]*255)];
    NSString *g = [NSString stringWithFormat:@"%@",getHex(cs[1]*255)];
    NSString *b = [NSString stringWithFormat:@"%@",getHex(cs[2]*255)];
    return [NSString stringWithFormat:@"%@%@%@",r,g,b];
}
//十进制转十六进制
NSString * getHex(int tmpid)
{
    NSString *endtmp=@"";
    NSString *nLetterValue;
    NSString *nStrat;
    int ttmpig=tmpid%16;
    int tmp=tmpid/16;
    switch (ttmpig)
    {
        case 10:
            nLetterValue =@"A";break;
        case 11:
            nLetterValue =@"B";break;
        case 12:
            nLetterValue =@"C";break;
        case 13:
            nLetterValue =@"D";break;
        case 14:
            nLetterValue =@"E";break;
        case 15:
            nLetterValue =@"F";break;
        default:nLetterValue=[[NSString alloc]initWithFormat:@"%i",ttmpig];
            
    }
    switch (tmp)
    {
        case 10:
            nStrat =@"A";break;
        case 11:
            nStrat =@"B";break;
        case 12:
            nStrat =@"C";break;
        case 13:
            nStrat =@"D";break;
        case 14:
            nStrat =@"E";break;
        case 15:
            nStrat =@"F";break;
        default:nStrat=[[NSString alloc]initWithFormat:@"%i",tmp];
            
    }
    endtmp=[[NSString alloc]initWithFormat:@"%@%@",nStrat,nLetterValue];
    return endtmp;
}

NSArray  * getRGBWithColor(UIColor *color)
{
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    
    [color getRed:&red green:&green blue:&blue alpha:nil];
    return @[@((int)red),@((int)green),@((int)blue)];
}
UIImage * getColorImage(UIColor *color)
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}




@end
