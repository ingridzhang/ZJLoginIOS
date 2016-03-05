//
//  UIDevice+EZDeviceName.m
//  EasyJieApp
//
//  Created by sun on 15/9/15.
//  Copyright (c) 2015年 easyjie. All rights reserved.
//

#import "UIDevice+DeviceName.h"
#import <sys/utsname.h>

@implementation UIDevice (DeviceName)

- (NSString *)deviceName {
    struct utsname systemInfo;
    uname(&systemInfo);
    return [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
}

- (NSString *)platformString {
    NSDictionary *mapping = @{@"i386":@"32-bit Simulator", @"x86_64":@"64-bit Simulator", @"iPod1,1":@"iPod Touch", @"iPod2,1":@"iPod Touch Second Generation", @"iPod3,1":@"iPod Touch Third Generation", @"iPod4,1":@"iPod Touch Fourth Generation", @"iPhone1,1":@"iPhone", @"iPhone1,2":@"iPhone 3G", @"iPhone2,1":@"iPhone 3GS", @"iPad1,1":@"iPad", @"iPad2,1":@"iPad 2", @"iPad3,1":@"3rd Generation iPad", @"iPhone3,1":@"iPhone 4 (GSM)", @"iPhone3,3":@"iPhone 4 (CDMA/Verizon/Sprint)", @"iPhone4,1":@"iPhone 4S", @"iPhone5,1":@"iPhone 5 (model A1428, AT&T/Canada)", @"iPhone5,2":@"iPhone 5 (model A1429, everything else)", @"iPad3,4":@"4th Generation iPad" , @"iPad2,5":@"iPad Mini", @"iPhone5,3":@"iPhone5,3", @"iPhone5,4":@"iPhone 5c (model A1507, A1516, A1526 (China), A1529 | Global)" ,@"iPhone6,1":@"iPhone 5s (model A1433, A1533 | GSM)", @"iPhone6,2":@"iPhone 5s (model A1457, A1518, A1528 (China), A1530 | Global)", @"iPad4,1":@"5th Generation iPad (iPad Air) - Wifi", @"iPad4,2":@"5th Generation iPad (iPad Air) - Cellular", @"iPad4,4":@"2nd Generation iPad Mini - Wifi", @"iPad4,5":@"2nd Generation iPad Mini - Cellular", @"iPhone7,1":@"iPhone 6 Plus", @"iPhone7,2":@"iPhone 6", @"iPhone8,1":@"iPhone 6S", @"iPhone8,2":@"iPhone 6S Plus"};
    return mapping[[self deviceName]] ?: [self deviceName];
}

@end
