//
//  QYTagView.m
//  QQtagView
//
//  Created by leaduMac on 2020/6/21.
//  Copyright © 2020 ZhangQun. All rights reserved.
//

#import "QYTagView.h"
#import "MCFactory.h"
#import "QYTagItem.h"
@interface  QYTagView ()
@property (nonatomic,assign) QYTagViewStyle style;

@end

@implementation QYTagView
- (instancetype)initWithType:(QYTagViewStyle)style
{
    QYTagView * tagView  = [self init];
    self.style = style;
    return tagView;
}
- (instancetype)init
{
    if (self = [super init]) {
        self.selectTagsArray = [NSMutableArray array];
        self.padding = UIEdgeInsetsMake(10, 10, 10, 10);
        self.tagTextPadding = UIEdgeInsetsMake(10, 10, 10, 10);
        self.tagSpace = 10;
        self.tagFont = [UIFont systemFontOfSize:12 weight:(UIFontWeightRegular)];
        self.tagColorNor = getColorWithHex(@"f5f5f5");
        self.tagColorSel = getColorWithHex(@"EBF4FF");
        self.tagTextColorSel = getColorWithHex(@"73A2DB");
        self.tagTextColorNor = getColorWithHex(@"333333");
    }
    return self;
}

- (void)addTags:(NSArray *)tags
{
    [self.selectTagsArray removeAllObjects];
    for (int i = 0; i< tags.count; i++) {
        [self addLabel:tags[i]];
    }
}
- (void)addLabel:(NSString *)text {
    if (![self.selectTagsArray containsObject:text]) {
        [self.selectTagsArray addObject:text];
    }

    CGRect frame = CGRectZero;
    if(self.subviews && self.subviews.count > 0) {
        frame = [self.subviews lastObject].frame;
    }
    
    QYTagItem *item = [[QYTagItem alloc]init];
    [item addTarget:self action:@selector(itemClick:) forControlEvents:(UIControlEventTouchUpInside)];
    [item setTitleColor:self.tagTextColorNor forState:(UIControlStateNormal)];
    [item setTitleColor:self.tagTextColorSel forState:(UIControlStateSelected)];
    [item setTitle:text forState:(UIControlStateNormal)];
    item.titleLabel.font = self.tagFont;
    [item setTitleEdgeInsets:self.tagTextPadding];
    [item sizeToFit];
    [item.titleLabel sizeToFit];//这样才能获取到  titleLabel 的高度
    
    CGFloat height = self.tagTextPadding.top + self.tagTextPadding.bottom + item.titleLabel.frame.size.height;
    CGFloat width = item.frame.size.width + self.tagTextPadding.left + self.tagTextPadding.right ;
    
    if (self.style == deleteStyle) {
        item.selected = YES;
        [item setBackgroundColor:self.tagColorSel];
        [item setTitleEdgeInsets:UIEdgeInsetsMake(self.tagTextPadding.top, self.tagTextPadding.left, self.tagTextPadding.bottom, self.tagTextPadding.right + 20)];
        width = width + 20;

        QYTagItem *delete = [QYTagItem buttonWithType:(UIButtonTypeCustom)];
        [delete addTarget:self action:@selector(deleteClick:) forControlEvents:(UIControlEventTouchUpInside)];
        [delete setImage:[UIImage imageNamed:@"qqqq"] forState:(UIControlStateNormal)];
        delete.info = item;
        delete.frame = CGRectMake(width - 25, 0, 25, height);
        [item addSubview:delete];
    }else{
        item.selected = NO;
        
        [item setBackgroundColor:self.tagColorNor];
    }
    item.frame = CGRectMake(0, 0,width,height);
    [self addSubview:item];

}

- (void)changeItemString:(NSString *)string
{
    for (QYTagItem *item in self.subviews) {
        if([self stringIsEquals:item.titleLabel.text to:string]) {
            item.selected = !item.selected;
            if (item.selected) {
                [item setBackgroundColor:self.tagColorSel];
            }else{
                [item setBackgroundColor:self.tagColorNor];
            }
            break;
        }
    }
}
- (void)remove:(NSString *)text
{
    for (QYTagItem *item in self.subviews) {
        if([self stringIsEquals:item.titleLabel.text to:text]) {
            [item removeFromSuperview];
            [self.selectTagsArray removeObject:text];
            break;
        }
    }
}
- (void)removeItem:(QYTagItem *)item
{
    [item removeFromSuperview];
    [self.selectTagsArray removeObject:item.titleLabel.text];
    
}

- (void)itemClick:(QYTagItem *)item{
    [self clickEvent:item];
}
- (void)deleteClick:(QYTagItem *)item{
    [self clickEvent:item.info];
}
- (void)clickEvent:(QYTagItem *)item{

    if (self.style == deleteStyle) {
        [self removeItem:item];
    }else if (self.style == noneStyle) {
        item.selected = !item.selected;
        if (item.selected) {
            [item setBackgroundColor:self.tagColorSel];
        }else{
            [item setBackgroundColor:self.tagColorNor];
        }
    }
    if([self.delegate respondsToSelector:@selector(QYTagView:clickTagItem:)]) {
        [self.delegate QYTagView:self clickTagItem:item];
    }
}
- (void)layoutSubviews {
    [UIView beginAnimations:nil context:nil];
    CGFloat paddingRight = self.padding.right;
    CGFloat cellspace = self.tagSpace;
    CGFloat y = self.padding.top;
    CGFloat x = self.padding.left;
    CGRect frame;
    for(UIView *tag in self.subviews) {
        frame = tag.frame;
        frame.origin.x = x;
        frame.origin.y = y;
        
        if(frame.origin.x + frame.size.width + paddingRight > self.frame.size.width) {
            // 换行
            frame.origin.x = self.padding.left;
            frame.origin.y = frame.origin.y + frame.size.height + cellspace;
            
            y = frame.origin.y;
        }
        
        if(frame.origin.x + frame.size.width > self.frame.size.width - paddingRight) {
            frame.size.width = self.frame.size.width - paddingRight - frame.origin.x;
        }
        
        x = frame.origin.x + frame.size.width + cellspace;
        tag.frame = frame;
    }
    CGFloat containerHeight = frame.origin.y + frame.size.height + self.padding.bottom;
    CGRect containerFrame = self.frame;
    containerFrame.size.height = containerHeight;
    self.frame = containerFrame;
    if([self.delegate respondsToSelector:@selector(QYTagView:frameChange:)]) {
        [self.delegate QYTagView:self frameChange:containerFrame];
    }
    [UIView commitAnimations];
}

- (BOOL)stringIsEquals:(NSString *)string to:(NSString *)string2 {
    return [string isEqualToString:string2];
}
@end
