//
//  ViewController1.m
//  SMSLimmitOpation
//
//  Created by 张国兵 on 15/6/18.
//  Copyright (c) 2015年 zhangguobing. All rights reserved.
//

#import "ViewController1.h"
#import "MyControl.h"
#import "GBverifyButton.h"

@interface ViewController1 (){
    


}
@property(nonatomic,retain)GBverifyButton*button;

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    _button=[[GBverifyButton alloc]initWithFrame:CGRectMake(100, 100, 200, 40) delegate:self Target:self Action:@selector(request)];
    
   
    
}
#pragma mark-提交网络请求
-(void)request{
    
    //请求成功跑秒
    NSLog(@"请求成功");
    [_button startGetMessage];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
