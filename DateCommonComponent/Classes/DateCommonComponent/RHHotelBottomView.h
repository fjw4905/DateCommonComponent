//
//  RHHotelBottomView.h
//  DateCommonComponent
//
//  Created by 冯俊武 on 2022/3/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RHHotelBottomView : UIView


/// 入住日期
@property (nonatomic,strong)UILabel *leftTitle;
@property (nonatomic,strong)UILabel *leftContent;

/// 离店日期
@property (nonatomic,strong)UILabel *rightTitle;
@property (nonatomic,strong)UILabel *rightContent;


/// 提交按钮
@property (nonatomic,strong)UIButton *submitBut;

@end

NS_ASSUME_NONNULL_END
