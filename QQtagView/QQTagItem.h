
//  QQtagView
//
//  Created by ZhangQun on 2017/4/8.
//  Copyright © 2017年 ZhangQun. All rights reserved.
//

#import <UIKit/UIKit.h>
//选中的颜色
#define selectedColor  [UIColor purpleColor]
//未选中颜色
#define defaultColor  [UIColor lightGrayColor]

typedef NS_ENUM(NSInteger,QQTagStyle){
    //以下是标明标签是否是选中状态的
    QQTagStyleNone = 0,//不可编辑的无状态
    QQTagStyleSelected = 1,// 不可编辑的选中状态

};

typedef NS_ENUM(NSInteger,QQViewStyle){
    //以下是标明那个View是展示选中标签的
    QQViewStyleNone = 0,//无状态
    QQViewStyleSelected = 1,//选中状态
    
};

@class QQTagItem;


@protocol QQTagItemDelegate <NSObject>

- (void)QQTagItem:(QQTagItem *)QQTagItem;

@end

@interface QQTagItem :  UITextField<UITextFieldDelegate>

@property (nonatomic,assign) QQTagStyle Style;
@property (nonatomic,assign) id<QQTagItemDelegate> mydelagete;
@property(nonatomic) UIEdgeInsets padding;
@property (nonatomic,strong) UIColor * EditShowColor;
- (void)changeItemType:(QQTagStyle)tagType;
@end
