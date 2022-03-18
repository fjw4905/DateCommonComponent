//
//  RHCAGradientLayer.m
//  DateCommonComponent
//
//  Created by 冯俊武 on 2022/3/18.
//

#import "RHCAGradientLayer.h"

@implementation RHCAGradientLayer

/// 返回渐变色layer
/// @param colorsArray CGColor 颜色数组 该方法只支持2中颜色水平渐变
+(CAGradientLayer *)drawGradientWithCGColorsArray:(NSArray *)colorsArray WithViewframe:(CGRect)frame;{
    
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = colorsArray;
    gradientLayer.locations = @[@0.0, @1.0];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1.0, 0);
    gradientLayer.frame = frame;
//    [self.view.layer addSublayer:gradientLayer];
    return gradientLayer;
}

@end
