//
//  RHPlaneBackAndForthBottomView.m
//  DateCommonComponent
//
//  Created by 冯俊武 on 2022/3/18.
//

#import "RHPlaneBackAndForthBottomView.h"
#import "RHDateCommonComponentHeader.h"

@implementation RHPlaneBackAndForthBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.submitBut = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //渐变一定要设置到内容显示之前
        [self.submitBut.layer addSublayer:[RHCAGradientLayer drawGradientWithCGColorsArray:@[(id)RHColor_DarkBlue.CGColor,(id)RHColor_LightBlue.CGColor] WithViewframe:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 30, 48)]];
        
        self.submitBut.layer.cornerRadius = 5;
        self.submitBut.layer.masksToBounds = YES;
        
        [self.submitBut setTitle:@"确认" forState:UIControlStateNormal];
        [self.submitBut setTitleColor:RHColor_White forState:UIControlStateNormal];
        self.submitBut.titleLabel.font = FONT18B;
        
        [self addSubview:self.submitBut];
        
        [self.submitBut mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@20);
            make.left.equalTo(@15);
            make.right.equalTo(@-15);
            make.height.equalTo(@48);
        }];
        
    }
    return self;
}


@end
