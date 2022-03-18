//
//  RHDateItemHeaderReusableView.m
//  DateCommonComponent
//
//  Created by 冯俊武 on 2022/3/17.
//

#import "RHDateItemHeaderReusableView.h"
#import "RHDateCommonComponentHeader.h"

@implementation RHDateItemHeaderReusableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = FONT16BB;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.textColor = RHColor_Black;
        [self addSubview:self.titleLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@-7);
            make.left.equalTo(@16);
        }];
        
    }
    return self;
}

@end
