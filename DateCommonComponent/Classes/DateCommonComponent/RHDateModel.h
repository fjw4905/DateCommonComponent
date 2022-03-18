//
//  RHDateModel.h
//  DateCommonComponent
//
//  Created by 冯俊武 on 2022/3/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 控件类型
typedef NS_ENUM(NSInteger, RHDateType)
{
    RHPlaneOneWay = 0,//飞机单程
    RHPlaneBackAndForth,//飞机往返
    RHHotel,// 酒店
};

/// 日期显示范围
typedef NS_ENUM(NSInteger, RHDateRangeType)
{
    RHDateRangeLastType = 0,// 只显示当前月之前
    RHDateRangeMiddleType,// 前后各显示一半
    RHDateRangeNextType// 只显示当前月之后
};

/// 日期模型
@interface RHDateModel : NSObject

@property (nonatomic,assign)RHDateType modeType;//日期类型

/// 标题
@property (nonatomic,strong)NSString *title;


/// 选中开始日期下的文字
/// 例如：去程 入住
/// modelType = RHPlaneBackAndForth|RHHotel 生效
@property (nonatomic,strong)NSString *startStr;

/// 选中结束日期下的文字
/// 例如：返程 离店
@property (nonatomic,strong)NSString *endStr;

/// 开始时间
@property (nonatomic,assign)NSInteger startTime;
@property (nonatomic,strong)NSString *startTimeStr;
@property (nonatomic,strong)NSString *startWeek;

/// 结束时间
/// 单程没有结束时间
/// modelType = RHPlaneOneWay 不生效
@property (nonatomic,assign)NSInteger endTime;
@property (nonatomic,strong)NSString *endTimeStr;
@property (nonatomic,strong)NSString *endWeek;

/// 日期显示范围
@property (nonatomic,assign)RHDateRangeType dateRangeType;

/// 显示几个月的数据 默认 12 个月
@property (nonatomic,assign)NSInteger limitMonth;

/// 今天之后的日期是否可以点击 默认 YES 可以点击
@property (nonatomic,assign)BOOL afterTodayCanTouch;

/// 今天之前的日期是否可以点击 默认 YES 可以点击
@property (nonatomic,assign)BOOL beforeTodayCanTouch;

/// 是否展示农历节日 默认不展示
@property (nonatomic,assign)BOOL showChineseHoliday;

/// 是否展示农历 默认不展示
@property (nonatomic,assign)BOOL showChineseCalendar;


/// 时间戳转时间
/// @param date 时间戳
- (NSString *)timestampToDateStringkWithDate:(NSInteger)date;

///

/// 间隔时间计算 单位 晚
/// @param startTime 开始时间
/// @param endTime 结束时间
- (NSInteger)calculationTimeDifferenceWithStartTime:(NSInteger)startTime withEndTime:(NSInteger)endTime;

@end

NS_ASSUME_NONNULL_END
