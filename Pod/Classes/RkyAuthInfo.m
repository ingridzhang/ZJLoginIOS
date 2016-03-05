//
//  RkyAuthInfo.m
//  EasyJieApp
//
//  Created by ricky on 14-9-2.
//  Copyright (c) 2014年 easyjie. All rights reserved.
//

#import "RkyAuthInfo.h"
#import "LoginHeader.h"

@implementation RkyAuthInfo

- (NSString *)accessToken {
    if (!_accessToken || (NSNull *)_accessToken == [NSNull null]) {
        return @"";
    }
    return _accessToken;
}

- (NSString *)refreshToken {
    if (!_refreshToken || (NSNull *)_refreshToken == [NSNull null]) {
        return @"";
    }
    return _refreshToken;
}

- (NSString *)openID {
    if (!_openID || (NSNull *)_openID == [NSNull null]) {
        return @"";
    }
    return _openID;
}

- (NSString *)scope {
    if (!_scope || (NSNull *)_openID == [NSNull null]) {
        return @"";
    }
    return _scope;
}

- (NSDate *)lastRefresh {
    if (!_lastRefresh || (NSNull *)_lastRefresh == [NSNull null]) {
        return [NSDate date];
    }
    return _lastRefresh;
}

@end
