//
//  RHWeekHeaderView.m
//  DateCommonComponent
//
//  Created by 冯俊武 on 2022/3/17.
//

#import "RHWeekHeaderView.h"
#import "RHDateCommonComponentHeader.h"

@implementation RHWeekHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        NSArray *weekArray = @[@"周日",@"周一",@"周二",@"周三",@"周四",@"周五",@"周六"];
        int i = 0;
        NSInteger width = ([UIScreen mainScreen].bounds.size.width - 14) / 7;
        for(i = 0; i < 7; i++)
        {
            UILabel *weekLabel = [[UILabel alloc]initWithFrame:CGRectMake(i * width + 7, 0, width, 38)];
            weekLabel.backgroundColor = [UIColor clearColor];
            weekLabel.text = weekArray[i];
            weekLabel.font = FONT14;
            weekLabel.textAlignment = NSTextAlignmentCenter;
            if(i == 0 || i == 6){
                weekLabel.textColor = RHColor_Orange;
            }else{
                weekLabel.textColor = RHColor_Black_SubText;
            }
            [self addSubview:weekLabel];
        }
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
