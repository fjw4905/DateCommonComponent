//
//  RHDateCommonComponentAlertView.m
//  DateCommonComponent
//
//  Created by 冯俊武 on 2022/3/17.
//

#import "RHDateCommonComponentAlertView.h"
#import "RHDateCommonComponentHeader.h"
#import "RHWeekHeaderView.h"
#import "RHDateItemCollectionViewCell.h"
#import "RHDateItemHeaderReusableView.h"
#import "RHHotelBottomView.h"
#import "RHPlaneBackAndForthBottomView.h"

/// <#Description#>
@interface RHDateCommonComponentAlertView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)UIView *bg_View;
@property (nonatomic,strong)UIView *white_View;

/// 标题
@property (nonatomic,strong)UILabel *titleLabel;

/// 关闭按钮
@property (nonatomic,strong)UIButton *closeBut;

/// 头部星期
@property (nonatomic,strong)RHWeekHeaderView *weekHeaderView;

/// collectionView
@property (nonatomic,strong)UICollectionView *collectionView;

/// 日期数据
@property (nonatomic,strong)NSMutableArray *dataArray;

/// 酒店数据view
@property (nonatomic,strong)RHHotelBottomView *hotelBottomView;

/// 飞机往返
@property (nonatomic,strong)RHPlaneBackAndForthBottomView *planeBackAndForthBottomView;

@end

@implementation RHDateCommonComponentAlertView

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

-(instancetype)initWithFrame:(CGRect)frame withDateModel:(RHDateModel *)dateModel{
    
    if (self = [super initWithFrame:frame]) {
     
        _dateModel = dateModel;
        
        //配置UI
        [self configUI:frame];
        
        //根据条件获取数据
        [self configDataSource];
        
    }
    
    return self;
}

-(void)configDataSource{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        MSSCalendarManager *manager = [[MSSCalendarManager alloc]initWithShowChineseHoliday:_dateModel.showChineseHoliday showChineseCalendar:_dateModel.showChineseCalendar startDate:_dateModel.startTime];
        NSArray *tempDataArray = [manager getCalendarDataSoruceWithLimitMonth:_dateModel.limitMonth type:_dateModel.dateRangeType];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.dataArray addObjectsFromArray:tempDataArray];
            [self.collectionView reloadData];
            [self showCollectionViewWithStartIndexPath:manager.startIndexPath];
        });
    });
}

- (void)showCollectionViewWithStartIndexPath:(NSIndexPath *)startIndexPath
{
    // 滚动到上次选中的位置
    if(startIndexPath)
    {
        [_collectionView scrollToItemAtIndexPath:startIndexPath atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
        _collectionView.contentOffset = CGPointMake(0, _collectionView.contentOffset.y - 44);
    }
    else
    {
        if(_dateModel.dateRangeType == RHDateRangeLastType){
            if([_dataArray count] > 0){
                [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:_dataArray.count - 1] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
            }
        }
        else if(_dateModel.dateRangeType == RHDateRangeMiddleType){
            if([_dataArray count] > 0){
                [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:(_dataArray.count - 1) / 2] atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
                _collectionView.contentOffset = CGPointMake(0, _collectionView.contentOffset.y - 44);
            }
        }
    }
}

-(void)configUI:(CGRect)frame{
    
    __weak typeof(self) weakself = self;
    
    //遮罩View
    UIControl *bg_View = [[UIControl alloc] initWithFrame:frame];
    bg_View.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4f];
    [bg_View addTarget:self action:@selector(bgClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bg_View];
    self.bg_View = bg_View;
    
    //需要显示的View
    UIView *white_View = [[UIView alloc] init];
    white_View.size = CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.75);
    white_View.backgroundColor = [UIColor whiteColor];
    [bg_View addSubview:white_View];
    _white_View = white_View;
    
    CAShapeLayer *cornerLayer = [CAShapeLayer layer];
    UIBezierPath *cornerPath = [UIBezierPath bezierPathWithRoundedRect:white_View.bounds byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(24, 24)];
    cornerLayer.path = cornerPath.CGPath;
    cornerLayer.frame = white_View.bounds;
    white_View.layer.mask = cornerLayer;
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = self.dateModel.title;
    self.titleLabel.font = FONT17B;
    self.titleLabel.textColor = RHColor_Black;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [white_View addSubview:self.titleLabel];
    
    self.closeBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeBut setImage:[UIImage imageNamed:@"date_close_but"] forState:UIControlStateNormal];
    [self.closeBut addTarget:self action:@selector(bgClick:) forControlEvents:UIControlEventTouchUpInside];
    [white_View addSubview:self.closeBut];
    
    self.weekHeaderView = [[RHWeekHeaderView alloc] init];
    [white_View addSubview:self.weekHeaderView];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@0);
        make.left.equalTo(@50);
        make.right.equalTo(@-50);
        make.height.equalTo(@56);
    }];
    
    [self.closeBut mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(@0);
        make.width.equalTo(@60);
        make.height.equalTo(@56);
    }];
    
    [self.weekHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.titleLabel.mas_bottom);
        make.left.right.equalTo(@0);
        make.height.equalTo(@38);
    }];
    
    CGFloat width = ([UIScreen mainScreen].bounds.size.width - 14) / 7.0;
    NSInteger height = 50;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(floorf(width), height);
    flowLayout.headerReferenceSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 44);
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [white_View addSubview:_collectionView];
    
    //cell
    [_collectionView registerClass:[RHDateItemCollectionViewCell class] forCellWithReuseIdentifier:@"RHDateItemCollectionViewCell"];
    [_collectionView registerClass:[RHDateItemHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"RHDateItemHeaderReusableView"];
    
    
    
    
    //酒店
    if (_dateModel.modeType == RHHotel) {
        
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.weekHeaderView.mas_bottom);
            make.centerX.equalTo(weakself.white_View.mas_centerX);
            make.width.equalTo(@(floorf(width) * 7));
            make.bottom.equalTo(@-145);
        }];
        
        self.hotelBottomView = [[RHHotelBottomView alloc] init];
        [self.hotelBottomView.submitBut addTarget:self action:@selector(hotelSubmitBut:) forControlEvents:UIControlEventTouchUpInside];
        [white_View addSubview:self.hotelBottomView];
        
        [self.hotelBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(white_View.mas_bottom);
            make.left.right.equalTo(@0);
            make.height.equalTo(@145);
        }];
    }else if(_dateModel.modeType == RHPlaneBackAndForth){
        //飞机往返
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.weekHeaderView.mas_bottom);
            make.centerX.equalTo(weakself.white_View.mas_centerX);
            make.width.equalTo(@(floorf(width) * 7));
            make.bottom.equalTo(@-100);
        }];
        
        self.planeBackAndForthBottomView = [[RHPlaneBackAndForthBottomView alloc] init];
        [self.planeBackAndForthBottomView.submitBut addTarget:self action:@selector(planeBackAndForthSubmitBut:) forControlEvents:UIControlEventTouchUpInside];
        [white_View addSubview:self.planeBackAndForthBottomView];
        
        [self.planeBackAndForthBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(white_View.mas_bottom);
            make.left.right.equalTo(@0);
            make.height.equalTo(@100);
        }];
        
    }else{
        //飞机单程
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakself.weekHeaderView.mas_bottom);
            make.centerX.equalTo(weakself.white_View.mas_centerX);
            make.width.equalTo(@(floorf(width) * 7));
            make.bottom.equalTo(white_View.mas_safeAreaLayoutGuideBottom);
        }];
    }
    
}


#pragma mark-
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [_dataArray count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    MSSCalendarHeaderModel *headerItem = _dataArray[section];
    return headerItem.calendarItemArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    RHDateItemCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"RHDateItemCollectionViewCell" forIndexPath:indexPath];
    if(cell)
    {
        MSSCalendarHeaderModel *headerItem = _dataArray[indexPath.section];
        MSSCalendarModel *calendarItem = headerItem.calendarItemArray[indexPath.row];
        cell.dateLabel.text = @"";
        cell.dateLabel.textColor = RHColor_Black_Text;
        cell.holidayLabel.text = @"";
        cell.holidayLabel.textColor = RHColor_Orange;
        cell.tagLabel.text = @"";
        cell.tagLabel.textColor = RHColor_White;
        cell.backgroundColor = RHColor_White;
//        cell.isSelected = NO;
        cell.userInteractionEnabled = NO;
        if(calendarItem.day > 0)
        {
            cell.dateLabel.text = [NSString stringWithFormat:@"%ld",(long)calendarItem.day];
            cell.userInteractionEnabled = YES;
        }
        //是否展示农历
        if(_dateModel.showChineseCalendar)
        {
            cell.holidayLabel.text = calendarItem.chineseCalendar;
        }
        
        // 开始日期
        if(calendarItem.dateInterval == _dateModel.startTime)
        {
            cell.dateLabel.textColor = RHColor_White;
            cell.holidayLabel.textColor = RHColor_White;
            cell.backgroundColor = RHColor_DarkBlue;
            if (_dateModel.modeType == RHHotel || _dateModel.modeType == RHPlaneBackAndForth) {
                cell.tagLabel.text = _dateModel.startStr;
            }
            self.dateModel.startWeek = [NSString stringWithFormat:@"星期%@",calendarItem.week];
            self.dateModel.startTimeStr = [self.dateModel timestampToDateStringkWithDate:_dateModel.startTime];
        }
        // 结束日期
        else if (calendarItem.dateInterval == _dateModel.endTime)
        {
            
//            cell.isSelected = YES;
            cell.dateLabel.textColor = RHColor_White;
            cell.holidayLabel.textColor = RHColor_White;
            cell.backgroundColor = RHColor_DarkBlue;
            if (_dateModel.modeType == RHHotel || _dateModel.modeType == RHPlaneBackAndForth) {
                cell.tagLabel.text = _dateModel.endStr;
            }
            
            self.dateModel.endWeek = [NSString stringWithFormat:@"星期%@",calendarItem.week];
            self.dateModel.endTimeStr = [self.dateModel timestampToDateStringkWithDate:_dateModel.endTime];
            
        }
        // 开始和结束之间的日期
        else if(calendarItem.dateInterval > _dateModel.startTime && calendarItem.dateInterval < _dateModel.endTime)
        {
            
//            cell.isSelected = YES;
            cell.holidayLabel.textColor = RHColor_Orange;
            cell.dateLabel.textColor = RHColor_Black_Text;
            cell.backgroundColor = RHColor_LightBlue;
        }
        else
        {
            if(calendarItem.week == 0 || calendarItem.week == 6)
            {
                
//                cell.dateLabel.textColor = MSS_WeekEndTextColor;
//                cell.holidayLabel.textColor = MSS_WeekEndTextColor;
            }
            if(calendarItem.holiday.length > 0)
            {
                cell.holidayLabel.text = calendarItem.holiday;
//                if(_showHolidayDifferentColor)
//                {
//                    cell.dateLabel.textColor = MSS_HolidayTextColor;
//                    cell.holidayLabel.textColor = MSS_HolidayTextColor;
//                }
            }
        }
        
        if(!_dateModel.afterTodayCanTouch)
        {
            if(calendarItem.type == MSSCalendarNextType)
            {
//                cell.dateLabel.textColor = MSS_TouchUnableTextColor;
//                cell.subLabel.textColor = MSS_TouchUnableTextColor;
                cell.userInteractionEnabled = NO;
            }
        }
        if(!_dateModel.beforeTodayCanTouch)
        {
            if(calendarItem.type == MSSCalendarLastType)
            {
//                cell.dateLabel.textColor = MSS_TouchUnableTextColor;
//                cell.subLabel.textColor = MSS_TouchUnableTextColor;
                cell.userInteractionEnabled = NO;
            }
        }
    }
    return cell;
}

// 添加header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        RHDateItemHeaderReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"RHDateItemHeaderReusableView" forIndexPath:indexPath];
        MSSCalendarHeaderModel *headerItem = _dataArray[indexPath.section];
        headerView.titleLabel.text = headerItem.headerText;
        return headerView;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MSSCalendarHeaderModel *headerItem = _dataArray[indexPath.section];
    MSSCalendarModel *calendaItem = headerItem.calendarItemArray[indexPath.row];
    // 当开始日期为空时
    if(_dateModel.startTime == 0)
    {
        
        _dateModel.startTime = calendaItem.dateInterval;
        
        self.dateModel.startWeek = [NSString stringWithFormat:@"星期%@",calendaItem.week];
        self.dateModel.startTimeStr = [self.dateModel timestampToDateStringkWithDate:_dateModel.startTime];
        
        if (self.dateModel.modeType == RHPlaneOneWay) {
            self.completeBlock(self.dateModel);
            [self hide];
        }
        
//        [self showPopViewWithIndexPath:indexPath];
    }
    // 当开始日期和结束日期同时存在时(点击为重新选时间段)
    else if(_dateModel.startTime > 0 && _dateModel.endTime > 0)
    {
        _dateModel.startTime = calendaItem.dateInterval;
        _dateModel.endTime = 0;
        self.dateModel.startWeek = [NSString stringWithFormat:@"星期%@",calendaItem.week];
        self.dateModel.startTimeStr = [self.dateModel timestampToDateStringkWithDate:_dateModel.startTime];
        
        self.dateModel.endWeek = @"";
        self.dateModel.endTimeStr = @"";
        
//        [self showPopViewWithIndexPath:indexPath];
    }
    else
    {
        // 判断第二个选择日期是否比现在开始日期大
        if(_dateModel.startTime < calendaItem.dateInterval)
        {
            _dateModel.endTime = calendaItem.dateInterval;
            
            self.dateModel.endWeek = [NSString stringWithFormat:@"星期%@",calendaItem.week];
            self.dateModel.endTimeStr = [self.dateModel timestampToDateStringkWithDate:_dateModel.endTime];
        }
        else
        {
            _dateModel.startTime = calendaItem.dateInterval;
            self.dateModel.startWeek = [NSString stringWithFormat:@"星期%@",calendaItem.week];
            self.dateModel.startTimeStr = [self.dateModel timestampToDateStringkWithDate:_dateModel.startTime];

        }
    }
    
    if (self.dateModel.modeType == RHHotel) {
        self.hotelBottomView.leftContent.text = [NSString stringWithFormat:@"%@",self.dateModel.startTimeStr];
        self.hotelBottomView.rightContent.text = [NSString stringWithFormat:@"%@",self.dateModel.endTimeStr.length > 0 ? self.dateModel.endTimeStr : @"- -"];
        
        if (self.dateModel.startTime > 0 && self.dateModel.endTime > 0) {
            [self.hotelBottomView.submitBut setTitle:[NSString stringWithFormat:@"确认%ld晚",[self.dateModel calculationTimeDifferenceWithStartTime:self.dateModel.startTime withEndTime:self.dateModel.endTime]] forState:UIControlStateNormal];
        }else{
            [self.hotelBottomView.submitBut setTitle:[NSString stringWithFormat:@"确认-晚"] forState:UIControlStateNormal];
        }
        
    }
    
    [_collectionView reloadData];
}


/// 酒店
-(void)hotelSubmitBut:(UIButton *)sender{
    
    if (self.dateModel.startTime <= 0) {
        [XProgressHUD showTitle:@"酒店入住日期不能为空" toView:self];
    }else if(self.dateModel.endTime <= 0){
        [XProgressHUD showTitle:@"酒店离店日期不能为空" toView:self];
    }else{
        self.completeBlock(self.dateModel);
        [self hide];
    }
    
}

/// 飞机往返
-(void)planeBackAndForthSubmitBut:(UIButton *)sender{
    
    if (self.dateModel.startTime <= 0) {
        [XProgressHUD showTitle:@"飞机去程日期不能为空" toView:self];
    }else if(self.dateModel.endTime <= 0){
        [XProgressHUD showTitle:@"飞机返程日期不能为空" toView:self];
    }else{
        self.completeBlock(self.dateModel);
        [self hide];
    }
}


#pragma mark- 弹框配置
-(void)bgClick:(id)sender{
    [self hide];
}

-(void)showInView:(UIView *)view{
    [view addSubview:self];
    self.bg_View.backgroundColor = [UIColor clearColor];
    __weak typeof(self) weakself = self;
    weakself.white_View.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, weakself.white_View.bounds.size.width, weakself.white_View.bounds.size.height);
    [UIView animateWithDuration:0.25 animations:^{
        weakself.bg_View.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4f];
        weakself.white_View.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - weakself.white_View.bounds.size.height, weakself.white_View.bounds.size.width, weakself.white_View.bounds.size.height);
    }];
}

-(void)hide{
    __weak typeof(self) weakself = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakself.bg_View.backgroundColor = [UIColor clearColor];
        weakself.white_View.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height , weakself.white_View.bounds.size.width, weakself.white_View.bounds.size.height);
    }completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


+(void)showInView:(UIView *)view withDateModel:(RHDateModel *)dateModel completeBlock:(void (^)(RHDateModel * _Nonnull))completeBlock{
    
    RHDateCommonComponentAlertView *alertView = [[RHDateCommonComponentAlertView alloc] initWithFrame:[UIScreen mainScreen].bounds withDateModel:dateModel];
    alertView.completeBlock = completeBlock;
    [alertView showInView:view];
}


@end
