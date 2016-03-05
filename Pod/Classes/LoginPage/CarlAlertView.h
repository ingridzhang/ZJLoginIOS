//
//  CarlAlertView.h
//  TextIOS
//
//  Created by 李世乾 on 15/7/23.
//  Copyright (c) 2015年 李世乾. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIView+Frame.h"
#import "LoginHeader.h"

typedef NS_ENUM(NSUInteger, ShowPositionType){
    
    ShowPositionBottomType,  //底部显示
    ShowPositionMiddleType   //中间显示
};

@interface CarlAlertView : NSObject
+(void)showAlertView:(NSString *)str;
+(void)showAlertView:(NSString *)str position:(ShowPositionType)type;
@end
