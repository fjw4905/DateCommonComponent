//
//  YSProgressHUD.h
//  YSUseek
//
//  Created by orange on 15/6/6.
//  Copyright (c) 2015年 liming4343@163.com. All rights reserved.
//

#import "MBProgressHUD.h"

@interface XProgressView:UIView<CAAnimationDelegate>
@end

@interface XProgressHUD : MBProgressHUD

#pragma mark - 下面函数 view 传nil 则加载到window上

#pragma mark 显示加载框
+(void)showLoad:(UIView *)view;
#pragma mark 隐藏加载框
+(void)hideLoad:(UIView *)view;
#pragma mark 显示提示文字 
+ (void)showTitle:(NSString *)title toView:(UIView *)view;
#pragma mark 显示提示详情
+ (void)showDetailText:(NSString *)text toView:(UIView *)view;
#pragma mark 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view;
#pragma mark 显示成功信息
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
@end
