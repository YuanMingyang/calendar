//
//  Lunar.h
//  杰特贝林
//
//  Created by A589 on 2017/6/30.
//  Copyright © 2017年 A589. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Lunar : NSObject
/**
 *是否闰月
 */
@property(assign) BOOL isleap;
/**
 *农历 日
 */
@property(assign) int lunarDay;
/**
 *农历 月
 */
@property(assign) int lunarMonth;
/**
 *农历 年
 */
@property(assign) int lunarYear;
@end
