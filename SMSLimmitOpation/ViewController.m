//
//  ViewController.m
//  SMSLimmitOpation
//
//  Created by 张国兵 on 15/6/18.
//  Copyright (c) 2015年 zhangguobing. All rights reserved.
//
#define R_G_B_16(rgbValue)\
\
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

#import "ViewController.h"
#import "MyControl.h"
#import "ViewController1.h"
@interface ViewController (){
    int timeCount;
    NSTimer*timer;
    
}

@property(nonatomic,retain)UIButton*get_verifyButton;
@property(nonatomic,retain)UILabel*tipLabel;
@property(nonatomic,retain)UIButton*nextButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
   
    _nextButton=[MyControl createButtonWithFrame:CGRectMake(100, 300 ,200,40) ImageName:nil Target:self Action:@selector(nextClick) Title:@"下一步"];
    
    [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _nextButton.layer.cornerRadius=3;
    _nextButton.clipsToBounds=YES;
    [_nextButton setBackgroundColor:R_G_B_16(0x4edb69)];
    
    [self.view addSubview:_nextButton];
    


}
#pragma mark-跳转下一页
-(void)nextClick{
    
    ViewController1*vc=[[ViewController1 alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
