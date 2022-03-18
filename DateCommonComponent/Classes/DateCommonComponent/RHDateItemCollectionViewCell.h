//
//  RHDateItemCollectionViewCell.h
//  DateCommonComponent
//
//  Created by 冯俊武 on 2022/3/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RHDateItemCollectionViewCell : UICollectionViewCell

/// 日期
@property (nonatomic,strong)UILabel *dateLabel;

/// 节日
@property (nonatomic,strong)UILabel *holidayLabel;

/// 标签
@property (nonatomic,strong)UILabel *tagLabel;

@end

NS_ASSUME_NONNULL_END
