//
//  QQTagView.m
//  QQtagView
//
//  Created by ZhangQun on 2017/4/8.
//  Copyright © 2017年 ZhangQun. All rights reserved.
//

#import "QQTagView.h"
#import "CustomBtn.h"
@implementation QQTagView

- (instancetype)init
{
    if (self = [super init]) {
        self.tagFontSize = 12;
        self.tagSpace = 10;
        self.padding = UIEdgeInsetsMake(10, 10, 10, 10);//控件的距离
//        self.tagTextPadding = UIEdgeInsetsMake(5, 10, 5, 10);
        self.Style = QQViewStyleNone;
        self.selectTagsArray = [NSMutableArray array];
        self.backgroundColor =[UIColor redColor];
    }
    return self;
}
- (instancetype)initWith:(QQViewStyle)TagViewStyle
{
    self = [super init];
    self.tagFontSize = 12;
    self.tagSpace = 10;
    self.Style = TagViewStyle;
    self.padding = UIEdgeInsetsMake(10, 10, 10, 10);//控件的距离
    self.selectTagsArray = [NSMutableArray array];
    self.backgroundColor =[UIColor redColor];
    return self;
}
- (void)QQTagItem:(QQTagItem *)QQTagItem
{
    if (self.Style == QQViewStyleSelected) {
        if (QQTagItem.Style == QQTagStyleNone) {
            [QQTagItem removeFromSuperview];
        }
    }else{
        if (QQTagItem.Style == QQTagStyleNone) {
            [self.selectTagsArray removeObject:QQTagItem.text];
        }
    }
    if (QQTagItem.Style == QQTagStyleSelected) {
        [self.selectTagsArray addObject:QQTagItem.text];
    }else{
        [self.selectTagsArray removeObject: QQTagItem.text];
    }
    if([self.delegate respondsToSelector:@selector(QQTagView:QQTagItem:)]) {
        [self.delegate QQTagView:self QQTagItem:QQTagItem];
    }
}
- (void)changeItemString:(NSString *)string
{
    for (QQTagItem *item in self.subviews) {
        if([self stringIsEquals:item.text to:string]) {
            [item changeItemType:item.Style];
            break;
        }
    }
}
- (void)remove:(NSString *)text
{
    for (QQTagItem *item in self.subviews) {
        if([self stringIsEquals:item.text to:text]) {
            [item removeFromSuperview];
            [self.selectTagsArray removeObject:text];
            break;
        }
    }
}
- (void)addTags:(NSArray *)tags
{
    [self.selectTagsArray removeAllObjects];
    for (int i = 0; i< tags.count; i++) {
        [self addLabel:tags[i]];
    }
}
- (void)addLabel:(NSString *)text {
    if (self.Style == QQViewStyleSelected && ![self.selectTagsArray containsObject:text]) {
        [self.selectTagsArray addObject:text];
    }

    CGRect frame = CGRectZero;
    if(self.subviews && self.subviews.count > 0) {
        frame = [self.subviews lastObject].frame;
    }
    
    QQTagItem *Item = [[QQTagItem alloc]init];
#warning mark - 是否显示删除图片 
    // 这里是RightView实现的也可以用CleanButtonMode实现
    /**
     UIButton *button = [label.label valueForKey:@"_clearButton"];
     [button setImage:[UIImage imageNamed:@"clear_icon"] forState:UIControlStateNormal];
     Item.clearButtonMode = UITextFieldViewModeAlways;
     */
    if (self.Style == QQViewStyleSelected) {
        UIView *rightVeiw = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 26, 26)];
        CustomBtn *button = [CustomBtn buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(4, 5, 16, 16);
        [button setBackgroundImage:[UIImage imageNamed:@"qqqq"] forState:UIControlStateNormal];
        button.info = Item;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [rightVeiw addSubview:button];
        Item.rightView = rightVeiw;
        Item.rightViewMode = UITextFieldViewModeAlways;
        Item.padding = UIEdgeInsetsMake(10, 10, 10, 26);//字体与控件的距离
        Item.Style = QQTagStyleSelected;
        Item.EditShowColor = selectedColor;
    }else{
        Item.Style = QQTagStyleNone;
        Item.padding = UIEdgeInsetsMake(10, 10, 10, 10);//字体与控件的距离
    }
    Item.text =text;
    Item.mydelagete = self;
    Item.frame = CGRectMake(frame.origin.x, frame.origin.y, Item.frame.size.width, Item.frame.size.height);
    [Item sizeToFit];
    [self addSubview:Item];

}
- (void)buttonClick:(CustomBtn *)btn
{
    QQTagItem *Item = (QQTagItem *)btn.info;
    //设置选中与正常颜色
    if (Item.Style == QQTagStyleNone) {
        Item.Style = QQTagStyleSelected;
    }else if(Item.Style == QQTagStyleSelected){
        Item.Style = QQTagStyleNone;
    }

    [self QQTagItem:btn.info];
}
- (void)layoutSubviews {
    [UIView beginAnimations:nil context:nil];
    CGFloat paddingRight = self.padding.right;
    CGFloat cellspace = 5;
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
    if([self.delegate respondsToSelector:@selector(QQTagView:sizeChange:)]) {
        [self.delegate QQTagView:self sizeChange:self.frame];
    }
    [UIView commitAnimations];
}
- (BOOL)stringIsEquals:(NSString *)string to:(NSString *)string2 {
    return [string isEqualToString:string2];
}@end
