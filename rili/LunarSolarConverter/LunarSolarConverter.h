//
//  LunarSolarConverter.h
//  杰特贝林
//
//  Created by A589 on 2017/6/30.
//  Copyright © 2017年 A589. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Solar.h"
#import "Lunar.h"

@interface LunarSolarConverter : NSObject
/**
 *农历转公历
 */
+ (Solar *)lunarToSolar:(Lunar *)lunar;

/**
 *公历转农历
 */
+ (Lunar *)solarToLunar:(Solar *)solar;
@end
