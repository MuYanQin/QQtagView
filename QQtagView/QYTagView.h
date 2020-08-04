//
//  QYTagView.h
//  QQtagView
//
//  Created by leaduMac on 2020/6/21.
//  Copyright © 2020 ZhangQun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QYTagItem.h"
typedef NS_ENUM(NSInteger,QYTagViewStyle){
    noneStyle = 0,//无状态
    deleteStyle = 1,// 有删除按钮
    
};

NS_ASSUME_NONNULL_BEGIN
@class QYTagView,QYTagItem;
@protocol QYTagViewDelegate <NSObject>

- (void)QYTagView:(QYTagView *)tagView frameChange:(CGRect)newframe;

- (void)QYTagView:(QYTagView *)tagView clickTagItem:(QYTagItem *)tagItem;


@end

@interface QYTagView : UIView
- (instancetype)initWithType:(QYTagViewStyle)style;

@property (nonatomic , assign) id<QYTagViewDelegate>  delegate;
/// 已选择的tag
@property (nonatomic , strong) NSMutableArray * selectTagsArray;


@property (nonatomic , assign) CGFloat  viewHeight;


/// tag 距离视图的距离 container inner spacing, default is {10, 10, 10, 10}
@property(nonatomic) UIEdgeInsets padding;

/// tag text inner spaces, default is {3, 5, 3, 5}
@property(nonatomic) UIEdgeInsets tagTextPadding;

/// 俩个tags之间的距离 default 10
@property(nonatomic, assign) CGFloat tagSpace;

/// tag字体 默认 regular 12
@property(nonatomic, strong) UIFont *tagFont;

/// tag backgroud color for normal default hex:f5f5f5
@property (nonatomic , strong) UIColor *tagColorNor;


/// tag background color for selected  default hex:EBF4FF
@property (nonatomic , strong) UIColor *tagColorSel;


/// tag textColor for normal  default hex:333333
@property (nonatomic , strong) UIColor *tagTextColorNor;

///  tag textColor for selected default hex:73A2DB
@property (nonatomic , strong) UIColor *tagTextColorSel;


/// 添加多个标签
/// @param tags 标签文字数组
- (void)addTags:(NSArray *)tags;

/// 添加单个标签文字
/// @param text 标签文字
- (void)addLabel:(NSString *)text;

/// 根据文字移除标签
/// @param item 标签
- (void)removeItem:(QYTagItem *)item;


- (void)remove:(NSString *)text;

- (void)changeItemString:(NSString *)string;

@end

NS_ASSUME_NONNULL_END
