//
//  ViewController.m
//  QQtagView
//
//  Created by ZhangQun on 2017/4/8.
//  Copyright © 2017年 ZhangQun. All rights reserved.
//213

#import "ViewController.h"

#import "QYTagView.h"
#define kMKScreenWidth [UIScreen mainScreen].bounds.size.width
#define kMKScreenHeight [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<QYTagViewDelegate>
@property(nonatomic, strong) UIView *tagForSelectContainer;
@property (nonatomic , strong) QYTagView *tagView;
@property (nonatomic , strong) QYTagView *tagViewForSelect;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.tagView = [[QYTagView alloc]initWithType:(noneStyle)];
    self.tagView.frame = CGRectMake(0, 0, kMKScreenWidth, 0);
    self.tagView.tagTextPadding = UIEdgeInsetsMake(10, 10, 10, 10);
    self.tagView.delegate = self;
    self.tagView.tag = 1;
    [self.tagView addTags:@[@"6754674567", @"88888888", @"999",@"43243434",@"341234",@"777",@"743432523577"]];
    [self.view addSubview:self.tagView];
    
    self.tagViewForSelect = [[QYTagView alloc] initWithType:deleteStyle];
    self.tagViewForSelect.frame = CGRectMake(0, 250, kMKScreenWidth, 0);
    self.tagViewForSelect.delegate = self;
    self.tagViewForSelect.tag = 2;
    self.tagViewForSelect.tagTextPadding = UIEdgeInsetsMake(10, 10, 10, 10);
    [self.tagViewForSelect addTags:@[@"123", @"3123213", @"94543534599",@"645654",@"weqr3",@"tre43",@"3432fg"]];
    [self.view addSubview:self.tagViewForSelect];

}

- (void)QYTagView:(QYTagView *)tagView clickTagItem:(QYTagItem *)tagItem
{
    if (tagView.tag ==1) {
        if (tagItem.selected) {
            [self.tagViewForSelect addLabel:tagItem.titleLabel.text];
        }else{
            [self.tagViewForSelect remove:tagItem.titleLabel.text];
        }
    }else{
        [self.tagView changeItemString:tagItem.titleLabel.text];
    }
    NSLog(@"%@",self.tagViewForSelect.selectTagsArray);
}
- (void)QYTagView:(QYTagView *)tagView frameChange:(CGRect)newframe
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
