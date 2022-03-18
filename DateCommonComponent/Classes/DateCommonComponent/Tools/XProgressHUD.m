//
//  YSProgressHUD.m
//  YSUseek
//
//  Created by orange on 15/6/6.
//  Copyright (c) 2015年 liming4343@163.com. All rights reserved.
//

#import "XProgressHUD.h"
@interface XProgressView()<CAAnimationDelegate>{
    BOOL shouldRestartAnimate;
}
@property(nonatomic,strong)UIImageView *animationImage;
@property(nonatomic,strong)UIImageView *backView;
@end
@implementation XProgressView

- (void)dealloc
{
    [self stopAnimating];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        
        UIView *back = [[UIView alloc] initWithFrame:self.bounds];
        [back setBackgroundColor:[UIColor clearColor]];
        [self addSubview:back];
        
//        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0,0, 100, 100)];
//        [backView setCenter:self.center];
//        [backView setAlpha:0.9];
//        [backView setBackgroundColor:[UIColor colorWithRGBRed:85 green:85 blue:85]];
//        backView.layer.cornerRadius = 8;
//        backView.layer.masksToBounds = YES;
//        [self addSubview:backView];
        UIImageView *backView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        backView.image = [UIImage imageNamed:@"loading"];
        [self addSubview:backView];
        [backView setCenter:self.center];
        self.backView = backView;
//        UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
//        [logo setImage:[XResource imageNamed:@"loading2"]];
//        [logo setCenter:self.center];
//        [self addSubview:logo];
//        
//        _animationImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 36, 36)];
//        _animationImage.center = self.center;
//        [_animationImage setImage:[UIImage imageNamed:@"loading"]];
//        [self addSubview:_animationImage];
        
        [self startAnimating];
    }
    return self;
}

-(void)willMoveToSuperview:(UIView *)newSuperview{
    if (!newSuperview) {
        [self stopAnimating];
    }
}
#pragma -mark 接口方法
-(void)startAnimating
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 0.6;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    rotationAnimation.delegate = self;
//    [_animationImage.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    [self.backView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    shouldRestartAnimate = true;
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if (!flag) {
        if (shouldRestartAnimate) {
            [self startAnimating];
        }
 
//        CABasicAnimation* rotationAnimation = [self.backView.layer animationForKey:@"rotationAnimation"];
//        [self.backView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    }
}

-(void)stopAnimating
{
    shouldRestartAnimate = false;
    [self.backView.layer removeAnimationForKey:@"rotationAnimation"];
//    [_animationImage.layer removeAnimationForKey:@"rotationAnimation"];
}
@end

@implementation XProgressHUD


#pragma mark 显示加载框 view 传nil 则加载到window上
+(void)showLoad:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    [XProgressHUD hideLoad:view];
    XProgressView *v = [[XProgressView alloc] initWithFrame:view.bounds];
    [view addSubview:v];
}


#pragma mark 隐藏加载框
+(void)hideLoad:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    for (UIView *views in [view subviews]) {
        if ([views isKindOfClass:[XProgressView class]]) {
            [views removeFromSuperview];
        }
    }
}

#pragma mark 显示提示文字
+ (void)showTitle:(NSString *)title toView:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    [XProgressHUD hideLoad:view];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.labelText = title;
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeText;
    hud.dimBackground = NO;
    [hud setColor:[UIColor blackColor]];
    hud.animationType = MBProgressHUDAnimationFade;
    [hud hide:YES afterDelay:1.5];
}


#pragma mark 显示提示详情
+ (void)showDetailText:(NSString *)text toView:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    [XProgressHUD hideLoad:view];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.detailsLabelText = text;
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeText;
    hud.dimBackground = NO;
    [hud setColor:[UIColor blackColor]];
    hud.animationType = MBProgressHUDAnimationFade;
    [hud hide:YES afterDelay:1.5];
}


#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"ImageError.png" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"Checkmark.png" view:view];
}

#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    [XProgressHUD hideLoad:view];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 1秒之后再消失
    [hud hide:YES afterDelay:0.7];
}
@end
