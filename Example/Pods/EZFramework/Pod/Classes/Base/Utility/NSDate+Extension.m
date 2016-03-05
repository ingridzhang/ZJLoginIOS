//
//  NSDate+Extension.m
//  MyNewBlog
//
//  Created by apple on 15/9/4.
//  Copyright © 2015年 itcast. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)
+ (NSDate *)sinaDate:(NSString *)string {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.locale = [NSLocale localeWithLocaleIdentifier:@"en"];
    df.dateFormat = @"EEE MMM dd HH:mm:ss zzz yyyy";
    return [df dateFromString:string];
}

/*
 刚刚(一分钟内)
 X分钟前(一小时内)
 X小时前(当天)
 昨天 HH:mm(昨天)
 MM-dd HH:mm(一年内)
 yyyy-MM-dd HH:mm(更早期)
 */

- (NSString *)dateDescription {
    NSCalendar *cal = [NSCalendar currentCalendar];
    if ([cal isDateInToday:self]) {
        int delta = [[[NSDate alloc] init] timeIntervalSinceDate:self];
        if (delta < 60) {
            return @"刚刚";
        }
        if (delta < 3600) {
            return [NSString stringWithFormat:@"%d分钟前",delta/60];
        }
        return [NSString stringWithFormat:@"%d小时前",delta/3600];
    }
    NSMutableString *fmtStr = [NSMutableString stringWithString:@" HH:mm"];
    if ([cal isDateInYesterday:self]) {
        fmtStr = [NSMutableString stringWithFormat:@"昨天 %@",fmtStr];
    }else {
        fmtStr = [NSMutableString stringWithFormat:@"MM-dd %@",fmtStr];
        NSDateComponents *coms = [cal components:NSCalendarUnitYear fromDate:self toDate:[NSDate date] options:0];
        if (coms.year > 0) {
            fmtStr = [NSMutableString stringWithFormat:@"yyyy-%@",fmtStr];
        }
    }
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.locale = [NSLocale localeWithLocaleIdentifier:@"en"];
    df.dateFormat = fmtStr;
    return [df stringFromDate:self];
}
@end