//
//  RkyAuthInfo.h
//  EasyJieApp
//
//  Created by ricky on 14-9-2.
//  Copyright (c) 2014年 easyjie. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RkyAuthInfo : NSObject
@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, assign) NSInteger expireSec;
@property (nonatomic, copy) NSString *refreshToken;
@property (nonatomic, copy) NSString *openID;
@property (nonatomic, copy) NSString *scope;
@property (nonatomic, strong) NSDate *lastRefresh;

@end
