//
//  GBverifyButton.m
//  SMSLimmitOpation
//
//  Created by 张国兵 on 15/6/18.
//  Copyright (c) 2015年 zhangguobing. All rights reserved.
//

#import "GBverifyButton.h"
#define R_G_B_16(rgbValue)\
\
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

@interface GBverifyButton()
{
    
    int timeCount;
    NSTimer*timer;
    
}

@property(nonatomic,retain)UIButton*get_verifyButton;
@property(nonatomic,retain)UILabel*tipLabel;
@end
@implementation GBverifyButton
-(id)initWithFrame:(CGRect)frame delegate:(UIViewController*)Delegate Target:(id)target Action:(SEL)action{
    
    self = [super initWithFrame:frame];
    if(self){
         self.delegate=Delegate;
         self.frame=frame;
         self.target=target;
         self.action=action;
         [self createUI];
        
    }
    return self;
    
}
-(void)createUI{
    
    timeCount=60;
    
    //获取验证码按钮
    
    _get_verifyButton=[self createButtonWithFrame:self.frame ImageName:nil Target:self.target Action:self.action Title:@"获取验证码"];
    
    [_get_verifyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _get_verifyButton.layer.cornerRadius=3;
    _get_verifyButton.clipsToBounds=YES;
    [_get_verifyButton setBackgroundColor:R_G_B_16(0x4edb69)];
    
    [self.delegate.view addSubview:_get_verifyButton];
    
    //验证提交之后的跑秒提示防止用户的重复提交数据有效时间60秒
    _tipLabel=[[UILabel alloc ]initWithFrame:self.frame];
    _tipLabel.textAlignment=NSTextAlignmentCenter;
    _tipLabel.text=[[NSString alloc]initWithFormat:@"%ds后重新获取",timeCount];
    _tipLabel.textColor=[UIColor whiteColor];
    _tipLabel.layer.cornerRadius=3;
    _tipLabel.clipsToBounds=YES;
    _tipLabel.backgroundColor=[UIColor lightGrayColor];
    _tipLabel.hidden=YES;
    [self.delegate.view addSubview:_tipLabel];
    
    
}

#pragma mark-->读秒开始
-(void)readSecond{
    
    _get_verifyButton.hidden=YES;
    
    _tipLabel.hidden=NO;
    
    timer=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(dealTimer) userInfo:nil repeats:YES];
    timer.fireDate=[NSDate distantPast];
}

#pragma mark-->跑秒操作
-(void)dealTimer{
    
    _tipLabel.text=[[NSString alloc]initWithFormat:@"%ds后重新发送",timeCount];
    timeCount=timeCount-1;
    if(timeCount==0){
        timer.fireDate=[NSDate distantFuture];
        timeCount=60;
        _tipLabel.hidden=YES;
        _get_verifyButton.hidden=NO;
    }
    
}
#pragma mark-获取验证码
-(void)getVerifyClick{
    
    
    if([[NSUserDefaults standardUserDefaults]objectForKey:@"GBVerifyEnterAgain"]==NO){
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"GBVerifyEnterAgain"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        //第一次点击直接读秒
        [self readSecond];
        //读秒开始记录时间
        NSDate *datenow = [NSDate date];
        NSString *timeSp = [NSString stringWithFormat:@"%d", (int)[datenow timeIntervalSince1970]];
        [[NSUserDefaults standardUserDefaults] setObject:timeSp forKey:@"getMessageTime"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        
    }else{
        
        
        //第二次点击，先进行时间对比
        NSString*signTime=[[NSUserDefaults standardUserDefaults]objectForKey:@"getMessageTime"];
        int signTime_NUM=[signTime intValue];
        /**
         获取获取验证码的时间
         */
        NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:signTime_NUM];
        NSTimeInterval interval=[[NSDate date]timeIntervalSinceDate:confromTimesp];
        
        NSLog(@"%d",(int)interval );
        //如果时间间隔大于60秒，点击允许下次点击，重新记录获取时间
        if(interval>60){
            NSLog(@"获取验证码");
            NSDate *datenow = [NSDate date];
            NSString *timeSp = [NSString stringWithFormat:@"%d", (int)[datenow timeIntervalSince1970]];
            [[NSUserDefaults standardUserDefaults] setObject:timeSp forKey:@"getMessageTime"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [self readSecond];
            
        }else{
            
            UIAlertView*al=[[UIAlertView alloc]initWithTitle:@"提示" message:@"您的操作过于频繁请稍后再试" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            [al show];
        }
        
        
        
    }
    
}
-(void)setEnabled:(BOOL)enabled{
    
    _get_verifyButton.enabled=enabled;
    if(enabled==YES){
        
        [_get_verifyButton setBackgroundColor:R_G_B_16(0x4edb69)];

    }else{
        
       [_get_verifyButton setBackgroundColor:[UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:.8]];
    }
   
    
}
#pragma -获取验证码
-(void)startGetMessage{
    
    [self getVerifyClick];
    
    
}
- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state;
{
    [_get_verifyButton setTitleColor:color forState:state];
    _tipLabel.textColor=color;
    
}
-(void)setBackgroundColor:(UIColor *)backgroundColor;
{
    [_get_verifyButton setBackgroundColor:backgroundColor];
    
}
- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state
{
    [_get_verifyButton setBackgroundImage:image forState:state];

    
}
-(void)setTitleFont:(UIFont*)font{
    
    _get_verifyButton.titleLabel.font=font;
    _tipLabel.font=font;

    
}
-(void)colseTimer{
     //在invalidate之前最好先用isValid先判断是否还在线程中
    if ([timer isValid] == YES) {
        [timer invalidate];
         timer = nil;
    }

}
-(UIButton*)createButtonWithFrame:(CGRect)frame ImageName:(NSString*)imageName Target:(id)target Action:(SEL)action Title:(NSString*)title
{
    UIButton*button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=frame;
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchDown];
    
    return button;
    
    
}

@end
