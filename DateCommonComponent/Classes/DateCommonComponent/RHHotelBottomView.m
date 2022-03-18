//
//  RHHotelBottomView.m
//  DateCommonComponent
//
//  Created by 冯俊武 on 2022/3/17.
//

#import "RHHotelBottomView.h"
#import "RHDateCommonComponentHeader.h"

@implementation RHHotelBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        
        self.backgroundColor = RHColor_White;
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = RHColor_Gray_Line;
        [self addSubview:lineView];
        
        self.leftTitle = [[UILabel alloc] init];
        self.leftTitle.text = @"入住";
        self.leftTitle.textColor = RHColor_Black_SubText;
        self.leftTitle.font = FONT12;
        [self addSubview:self.leftTitle];
        
        self.leftContent = [[UILabel alloc] init];
        self.leftContent.text = @"- -";
        self.leftContent.textColor = RHColor_Black;
        self.leftContent.font = FONT16B;
        [self addSubview:self.leftContent];
        
        
        self.rightTitle = [[UILabel alloc] init];
        self.rightTitle.text = @"离店";
        self.rightTitle.textColor = RHColor_Black_SubText;
        self.rightTitle.font = FONT12;
        [self addSubview:self.rightTitle];
        
        self.rightContent = [[UILabel alloc] init];
        self.rightContent.text = @"- -";
        self.rightContent.textColor = RHColor_Black;
        self.rightContent.font = FONT16B;
        [self addSubview:self.rightContent];
        
        self.submitBut = [UIButton buttonWithType:UIButtonTypeCustom];
        
        //渐变一定要设置到内容显示之前
        [self.submitBut.layer addSublayer:[RHCAGradientLayer drawGradientWithCGColorsArray:@[(id)RHColor_DarkBlue.CGColor,(id)RHColor_LightBlue.CGColor] WithViewframe:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width - 30, 48)]];
        
        self.submitBut.layer.cornerRadius = 5;
        self.submitBut.layer.masksToBounds = YES;
        
        [self.submitBut setTitle:@"确认--晚" forState:UIControlStateNormal];
        [self.submitBut setTitleColor:RHColor_White forState:UIControlStateNormal];
        self.submitBut.titleLabel.font = FONT18B;
        
        [self addSubview:self.submitBut];
        
        
        __weak typeof(self) weakself = self;
        
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(@0);
            make.height.equalTo(@5);
        }];
        
        [self.leftTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineView.mas_bottom).offset(10);
            make.left.equalTo(@20);
            make.width.equalTo(@(([UIScreen mainScreen].bounds.size.width - 40) / 3.0));
        }];
        
        [self.leftContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.leftTitle.mas_bottom).offset(3);
            make.left.equalTo(@20);
            make.width.equalTo(@(([UIScreen mainScreen].bounds.size.width - 40) / 3.0));
        }];
        
        [self.rightTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(lineView.mas_bottom).offset(10);
            make.right.equalTo(@-20);
            make.width.equalTo(@(([UIScreen mainScreen].bounds.size.width - 40) / 3.0));
        }];
        
        [self.rightContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.rightTitle.mas_bottom).offset(3);
            make.right.equalTo(@-20);
            make.width.equalTo(@(([UIScreen mainScreen].bounds.size.width - 40) / 3.0));
        }];
        
        [self.submitBut mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.leftContent.mas_bottom).offset(5);
            make.left.equalTo(@15);
            make.right.equalTo(@-15);
            make.height.equalTo(@48);
        }];
    }
    return self;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
