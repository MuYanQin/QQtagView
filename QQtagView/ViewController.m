//
//  ViewController.m
//  QQtagView
//
//  Created by ZhangQun on 2017/4/8.
//  Copyright © 2017年 ZhangQun. All rights reserved.
//

#import "ViewController.h"
#import "QQTagView.h"
#define kMKScreenWidth [UIScreen mainScreen].bounds.size.width
#define kMKScreenHeight [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<QQTagViewDelegate>
@property(nonatomic, strong) UIView *tagForSelectContainer;
@property(nonatomic, strong) QQTagView *QQSelect;
@property(nonatomic, strong) QQTagView *HeaderView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
//    self.tagForSelectContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kMKScreenWidth, kMKScreenHeight)];
//    self.tagForSelectContainer.backgroundColor = [UIColor purpleColor];
//    [self.view addSubview:self.tagForSelectContainer];
    
    
    self.QQSelect = [[QQTagView alloc] init];
    self.QQSelect.frame = CGRectMake(0, 0, kMKScreenWidth, 0);
    self.QQSelect.delegate = self;
    self.QQSelect .tag = 1;
    [self.QQSelect addTags:@[@"6754674567", @"88888888", @"999",@"43243434",@"341234",@"777",@"743432523577"]];
    [self.view addSubview:self.QQSelect];

    self.HeaderView = [[QQTagView alloc] initWith:QQTagStyleEditSlect];
    self.HeaderView.frame = CGRectMake(0, 250, kMKScreenWidth, 0);
    self.HeaderView.delegate = self;
    self.HeaderView.tag = 2;
    [self.HeaderView addTags:@[@"6754674567", @"88888888", @"999",@"43243434",@"341234",@"777",@"743432523577"]];
    [self.view addSubview:self.HeaderView];
    
    
}
- (void)QQTagView:(QQTagView *)QQTagView QQTagItem:(QQTagItem *)QQTagItem
{
    NSLog(@"%ld",QQTagItem.Style);
    if (QQTagView.tag ==1) {
        if (QQTagItem.Style == QQTagStyleNone) {
            [self.HeaderView addLabel:QQTagItem.text tag:1];
        }else{
            [self.HeaderView  remove:QQTagItem.text];
        }
    }

}
- (void)QQTagView:(QQTagView *)QQTagView sizeChange:(CGRect)newSize
{

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
