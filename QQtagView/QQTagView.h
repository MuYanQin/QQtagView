//
//  QQTagView.h
//  QQtagView
//
//  Created by ZhangQun on 2017/4/8.
//  Copyright © 2017年 ZhangQun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QQTagItem.h"

@class QQTagView,QQTagItem;
@protocol QQTagViewDelegate <NSObject>


- (void)QQTagView:(QQTagView *)QQTagView sizeChange:(CGRect)newSize;
- (void)QQTagView:(QQTagView *)QQTagView QQTagItem:(QQTagItem *)QQTagItem;

@end

@interface QQTagView : UIView <QQTagItemDelegate>
@property (nonatomic,weak) id<QQTagViewDelegate> delegate;

@property (nonatomic,assign) QQTagStyle Style;
@property(nonatomic, assign) CGFloat tagSpace;// space between two tag, default is 10
@property(nonatomic, assign) CGFloat tagFontSize; // default is 12
@property(nonatomic) UIEdgeInsets padding; // container inner spacing, default is {10, 10, 10, 10}
@property(nonatomic) UIEdgeInsets tagTextPadding; // tag text inner spaces, default is {3, 5, 3, 5}
- (void)addTags:(NSArray *)tags;
- (void)addLabel:(NSString *)text tag:(NSInteger)tag;
- (void)remove:(NSString *)text;
- (instancetype)initWith:(QQTagStyle)TagViewStyle;
@end
