//
//  RkyUserManager.h
//  testLogin
//
//  Created by sun on 15/10/29.
//  Copyright © 2015年 sunfei. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RkyUser.h"
#import "RkyAuthInfo.h"
#import "RkyLoginDefine.h"

@interface RkyLoginUserInfo : NSObject

+ (instancetype)sharedInstance;

@property (nonatomic, strong) RkyUser *userInfo;
@property (nonatomic, strong) RkyAuthInfo *authInfo;
@property (nonatomic) RkyLoginType loginType;

@end
