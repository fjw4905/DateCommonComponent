//
//  RHDateModel.m
//  DateCommonComponent
//
//  Created by 冯俊武 on 2022/3/17.
//

#import "RHDateModel.h"

@implementation RHDateModel

-(instancetype)init{
    if (self = [super init]) {
        self.afterTodayCanTouch = YES;
        self.beforeTodayCanTouch = YES;
    }
    return self;
}


- (NSString *)timestampToDateStringkWithDate:(NSInteger)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM月dd日"];
    NSString *dateString = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:date]];
    return dateString;
}


/// 间隔时间计算 单位 晚
/// @param startTime 开始时间
/// @param endTime 结束时间
- (NSInteger)calculationTimeDifferenceWithStartTime:(NSInteger)startTime withEndTime:(NSInteger)endTime{
    
    NSInteger  timeDifference = (endTime - startTime) / 60 / 60 / 24;
    
    NSLog(@"======%ld",(long)timeDifference);
    return timeDifference;
    
}

@end
