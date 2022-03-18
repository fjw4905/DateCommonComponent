//
//  RHDateItemCollectionViewCell.m
//  DateCommonComponent
//
//  Created by 冯俊武 on 2022/3/17.
//

#import "RHDateItemCollectionViewCell.h"
#import "RHDateCommonComponentHeader.h"

@implementation RHDateItemCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.dateLabel = [[UILabel alloc] init];
        self.dateLabel.font = FONT15;
        self.dateLabel.textAlignment = NSTextAlignmentCenter;
        self.dateLabel.textColor = RHColor_Black_Text;
        [self.contentView addSubview:self.dateLabel];
        
        self.holidayLabel = [[UILabel alloc] init];
        self.holidayLabel.font = FONT10;
        self.holidayLabel.textAlignment = NSTextAlignmentCenter;
        self.holidayLabel.textColor = RHColor_Orange;
        [self.contentView addSubview:self.holidayLabel];
        
        self.tagLabel = [[UILabel alloc] init];
        self.tagLabel.font = FONT10B;
        self.tagLabel.textAlignment = NSTextAlignmentCenter;
        self.tagLabel.textColor = RHColor_White;
        [self.contentView addSubview:self.tagLabel];
        
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(@0);
            make.left.right.equalTo(@0);
        }];
        
        [self.holidayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@3);
            make.left.right.equalTo(@0);
        }];
        
        
        [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(@-3);
            make.left.right.equalTo(@0);
        }];
        
    }
    return self;
}

@end
