//
//  EZCollectionDefault.h
//  Pods
//
//  Created by sun on 15/10/9.
//
//

#import <Foundation/Foundation.h>

@interface EZCollectionDefault : NSObject

+ (instancetype)shareInstance;

@property (nonatomic, readonly) NSDictionary *header;

@property (nonatomic, readonly) NSString *device;
@property (nonatomic, readonly) NSString *deviceToken;
@property (nonatomic, readonly) NSString *system;
@property (nonatomic, readonly) NSString *appName;
@property (nonatomic, readonly) NSString *loginKey;
@property (nonatomic, readonly) NSString *uid;

@property (nonatomic, readonly) NSString *deviceId;

@property (nonatomic, readonly) NSString *systemVersion;
@property (nonatomic, readonly) NSString *appVersion;
@property (nonatomic, readonly) NSString *versionCode;
@property (nonatomic, readonly) NSString *nationality;

@property (nonatomic, readonly) NSString *openUDID;

@property (nonatomic) BOOL isLoginedAtCurrentRequest;
@property (nonatomic) BOOL isCommunityBanned;

@end
