//
//  ViewController.m
//  rili
//
//  Created by Yang on 2017/8/15.
//  Copyright © 2017年 A589. All rights reserved.
//

#import "ViewController.h"
#import "MonthView.h"
#import "NSDate+GFCalendar.h"
#define SWIDTH self.scrollView.bounds.size.width
#define SHEIGHT self.scrollView.bounds.size.height


@interface ViewController ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property(nonatomic,strong)MonthView *leftView;
@property(nonatomic,strong)MonthView *centerView;
@property(nonatomic,strong)MonthView *rightView;


@property(nonatomic,strong)NSDate *currentDate;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(SWIDTH*3, SHEIGHT);
    self.scrollView.contentOffset = CGPointMake(SWIDTH, 0);
    self.currentDate = [NSDate date];
    [self configDateView];
    
}

-(void)configDateView{
    self.leftView = [[MonthView alloc] initWithFrame:CGRectMake(0, 0, SWIDTH, SHEIGHT)];
    [self.leftView refreshWith:[self.currentDate previousMonthDate]];
    [self.scrollView addSubview:self.leftView];
    
    self.centerView = [[MonthView alloc] initWithFrame:CGRectMake(SWIDTH, 0, SWIDTH, SHEIGHT)];
    [self.centerView refreshWith:self.currentDate];
    [self.scrollView addSubview:self.centerView];
    
    self.rightView = [[MonthView alloc] initWithFrame:CGRectMake(SWIDTH*2, 0, SWIDTH, SHEIGHT)];
    [self.rightView refreshWith:[self.currentDate nextMonthDate]];
    [self.scrollView addSubview:self.rightView];
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGPoint offset = [scrollView contentOffset];
    if (offset.x==0) {
        self.currentDate = [self.currentDate previousMonthDate];
    }else if (offset.x==SWIDTH*2){
        self.currentDate = [self.currentDate nextMonthDate];
    }
    [self.leftView refreshWith:[self.currentDate previousMonthDate]];
    [self.centerView refreshWith:self.currentDate];
    [self.rightView refreshWith:[self.currentDate nextMonthDate]];
    self.scrollView.contentOffset = CGPointMake(SWIDTH, 0);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyyMM";
    NSString *dateStr = [dateFormatter stringFromDate:self.currentDate];
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@年%@月",[dateStr substringToIndex:4],[dateStr substringFromIndex:4]];
}

@end
