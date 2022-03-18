//
//  ColorUtils.h
//  TwitterFon
//
//  Created by kaz on 7/21/08.
//  Copyright 2008 naan studio. All rights reserved.
//

#import <UIKit/UIKit.h>


#define RGB(r,g,b) [UIColor colorWithRGBRed:r green:g blue:b]
#define RGBN(n) [UIColor colorWithNumber:n]
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define HEX(a) [UIColor colorWithHexString:@#a]
#define COLOR_TO_HEX(a) ([UIColor hexStringFromColor:a])
@interface UIColor (Extension)
+ (UIColor *)colorWithRGBRed:(CGFloat)red green:(CGFloat)green  blue:(CGFloat)blue;
+ (UIColor *)colorWithNumber:(NSUInteger)number;

+ (UIColor *) colorWithHexString: (NSString *)color;
+ (NSString *)hexStringFromColor:(UIColor *)color;
@end
