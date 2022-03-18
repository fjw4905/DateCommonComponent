//
//  RHDateCommonComponentAlertView.h
//  DateCommonComponent
//
//  Created by 冯俊武 on 2022/3/17.
//

#import <UIKit/UIKit.h>
#import "RHDateModel.h"

NS_ASSUME_NONNULL_BEGIN





@interface RHDateCommonComponentAlertView : UIView


@property (nonatomic,strong)RHDateModel *dateModel;//日期模型
@property (nonatomic,strong)void (^completeBlock)(RHDateModel *dateModel);


-(void)showInView:(UIView *)view;
-(void)hide;
+(void)showInView:(UIView *)view withDateModel:(RHDateModel *)dateModel completeBlock:(void (^)(RHDateModel *dateModel))completeBlock;


@end

NS_ASSUME_NONNULL_END
