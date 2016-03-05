//
//  RkyUser.h
//  EasyJie
//
//  Created by ricky on 14-8-23.
//  Copyright (c) 2014年 rickycui. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSUInteger, RkyGenderOption) {
    RkyGenderOptionUnknown,
    RkyGenderOptionMan,
    RkyGenderOptionWoman,
};

@interface RkyUser : NSObject
@property(nonatomic, assign) long userID;
@property(nonatomic, assign) int sex;
@property(nonatomic, copy) NSString *openID;
@property(nonatomic, copy) NSString *email;
@property(nonatomic, copy) NSString *nickName;
@property(nonatomic, copy) NSString *password;
@property(nonatomic, copy) NSString *province;
@property(nonatomic, copy) NSString *city;
@property(nonatomic, copy) NSString *country;
@property(nonatomic, copy) NSString *headimgurl;
@property(nonatomic, copy) NSString *privilege;
@property(nonatomic, copy) NSString *unionid;
@property(nonatomic, copy) NSString *loginKey;
@property(nonatomic, assign) NSDate *registerTime;
@property(nonatomic, copy)NSString *photo;
@property(nonatomic,copy)NSString *loginToken;
@end
