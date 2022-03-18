//
//  RHCAGradientLayer.h
//  DateCommonComponent
//
//  Created by 冯俊武 on 2022/3/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RHCAGradientLayer : UIView


/// 返回渐变色layer
/// @param colorsArray CGColor 颜色数组 该方法只支持2中颜色水平渐变
+(CAGradientLayer *)drawGradientWithCGColorsArray:(NSArray *)colorsArray WithViewframe:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
