//
//  MonthView.m
//  rili
//
//  Created by Yang on 2017/8/15.
//  Copyright © 2017年 A589. All rights reserved.
//

#import "MonthView.h"
#import "DayCell.h"
#import "NSDate+GFCalendar.h"
#import "Solar.h"
#import "Lunar.h"
#import "LunarSolarConverter.h"
#define WIDTH [UIScreen mainScreen].bounds.size.width
#define HEIGHT [UIScreen mainScreen].bounds.size.height

@interface MonthView ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)NSDate *currentDate;

@property(nonatomic,strong)UICollectionView *collectionView;
@end

@implementation MonthView
-(void)refreshWith:(NSDate *)date{
    self.currentDate = date;
    self.backgroundColor = [UIColor whiteColor];
    [self RefreshcollectionView];
}


-(void)RefreshcollectionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake((WIDTH-40)/7-0.5, 100);
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"DayCell" bundle:nil] forCellWithReuseIdentifier:@"DayCell"];
    [self addSubview:self.collectionView];

    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 42;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    DayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DayCell" forIndexPath:indexPath];
    cell.layer.borderColor = [UIColor redColor].CGColor;
    cell.layer.borderWidth = 0.5;
    cell.layer.masksToBounds = YES;
    NSInteger week = [self.currentDate firstWeekDayInMonth];
    if (week==7) {
        week=0;
    }
    
    if (indexPath.row<week) {
        cell.labelOne.hidden = YES;
        cell.labelTwo.hidden = YES;
    }else{
        cell.labelOne.hidden = NO;
        cell.labelTwo.hidden = NO;
        cell.labelOne.text = [NSString stringWithFormat:@"%lu",indexPath.row-week+1];
        /** 公历转换为农历 */
        NSDateFormatter *DateFormatter = [[NSDateFormatter alloc] init];
        DateFormatter.dateFormat = @"yyyyMM";
        NSString *dateStr = [DateFormatter stringFromDate:self.currentDate];
        Solar *solar = [[Solar alloc] init];
        solar.solarDay = [cell.labelOne.text intValue];
        solar.solarMonth = [[dateStr substringFromIndex:4] intValue];
        solar.solarYear = [[dateStr substringToIndex:4] intValue];
        Lunar *lunar = [LunarSolarConverter solarToLunar:solar];
        cell.labelTwo.text = [self formatlunarWithYear:lunar.lunarYear AndMonth:lunar.lunarMonth AndDay:lunar.lunarDay];
        
        
        if (indexPath.row-week+1>[self.currentDate totalDaysInMonth]) {
            //下个月的
            cell.labelOne.hidden = YES;
            cell.labelTwo.hidden = YES;
        }else{
            cell.labelOne.hidden = NO;
            cell.labelTwo.hidden = NO;
        }
    }
    return cell;
}


- (NSString *)formatlunarWithYear:(int)year AndMonth:(int)month AndDay:(int)day{
    NSArray *chineseMonths=[NSArray arrayWithObjects:
                            @"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",
                            @"九月", @"十月", @"冬月", @"腊月", nil];
    NSArray *chineseDays=[NSArray arrayWithObjects:
                          @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
                          @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                          @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十",  nil];
    if (day==1) {
        return [NSString stringWithFormat:@"%@",chineseMonths[month - 1]];
    }else{
        return [NSString stringWithFormat:@"%@",chineseDays[day - 1]];
    }
}

@end
