# GBVerifyButton
#简介：<br>
##验证码控件button直接创建一个控件就可以实现基本的短信验证码倒计时操作<br>
##只需要自定义一个空间就可以实现跑秒倒计时操作，十分方便，而且目前我看了大部分的这种代码是没有对验证码的获取做出限制当我们返回dealloc控件的时候再回来重新初始化的时候发现我们又能发验证了，这就是漏洞了我们可以无限制的刷验证码，一条平均6分钱苍蝇再小也是肉本着节约用钱的想法做了一些限制<br>
##如果觉得有用的话请点个星谢谢支持，会继续出一些功能性的框架，如有bug也请指出群号：433060483欢迎加入组织<br>
#使用说明：<br>
* 将GBverifyButton两个文件拖入工程并且在使用的地方添加头文件<br>
* 在需要获取验证码之后跑秒的地方直接创建GBbutton，不需要添加到self.view层上，因为在方法里已经添加，添加了也不影响<br>
* 一般来说跑秒操作是在提交发送验证码请求成功之后，所以我添加了一个方法使操作更加可控,可以在网络请求成功调用startGetMessage方法<br>
* 设置button的点击许可，比如未填写手机号不能点击<br>
* 可以自定义一些基本常用的属性比如：button的背景色、背景图、字体的颜色、大小等如果还需要什么属性请自行添加<br>
* 添加了获取验证码的时间间隔在60秒之内不能重复提交即使返回销毁之后再重新创建也不行，防止刷短信一条短信6分钱啊<br>
* 听取了别人的意见为了防止内存泄露，暴露一个关闭定时器的接口，在离开这个界面的时候关闭定时器<br>

#代码示例：<br>
```
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    _button=[[GBverifyButton alloc]initWithFrame:CGRectMake(100, 100, 200, 40) delegate:self Target:self Action:@selector(request)];
    [self.view addSubview:_button];
    
   
    
}
#pragma mark-提交网络请求
-(void)request{
    
    //请求成功开始跑秒
    [_button startGetMessage];
    
}
```
#效果图展示：<br>
![image](https://github.com/mokey1422/gifResource/blob/master/sms.gif)
