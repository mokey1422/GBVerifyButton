//
//  GBverifyButton.h
//  SMSLimmitOpation
//
//  Created by 张国兵 on 15/6/18.
//  Copyright (c) 2015年 zhangguobing. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *获取验证码button使用说明
 *1.将GBverifyButton两个文件拖入工程并且在使用的地方添加头文件
 *2.在需要获取验证码之后跑秒的地方直接创建GBbutton，不需要添加到self.view层上，因为在方法里已经添加，添加了也不影响。
 *3.一般来说跑秒操作是在提交发送验证码请求成功之后，所以我添加了一个方法使操作更加可控,可以在网络请求成功调用startGetMessage方法
 *4.设置button的点击许可，比如未填写手机号不能点击
 *5.可以自定义一些基本常用的属性比如：button的背景色、背景图、字体的颜色、大小等如果还需要什么属性请自行添加
 *6.封装的可能不是很完善大神勿喷
 *7.听取了别人的意见为了防止内存泄露，暴露一个关闭定时器的接口，在离开这个界面的时候关闭定时器
 */
@interface GBverifyButton : UIButton
@property(assign) UIViewController* delegate;
@property(assign) id target;
@property (nonatomic, assign) SEL action;
-(id)initWithFrame:(CGRect)frame delegate:(UIViewController*)Delegate Target:(id)target Action:(SEL)action;

/**
 *  自定义背景图片
 */
- (void)setBackgroundImage:(UIImage *)image forState:(UIControlState)state ;
/**
 *  自定义button背景色
 */
-(void)setBackgroundColor:(UIColor *)backgroundColor;
/**
 *  自定义button的点击允许权
 */
-(void)setEnabled:(BOOL)enabled;
/**
 *  开始跑秒操作
 */
-(void)startGetMessage;
/**
 *  自定义button的字体大小
 */
-(void)setTitleFont:(UIFont*)font;
/**
 *  自定义字体颜色
 */
-(void)setTitleColor:(UIColor *)color forState:(UIControlState)state;
/**
 *  关闭定时器
 */
-(void)colseTimer;

@property (nonatomic) CGRect frame;
@end
