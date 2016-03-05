//
//  EZDispatchCenter.h
//  EZFramework_example
//
//  Created by sun on 15/10/12.
//  Copyright © 2015年 sunfei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EZDispatchCenter : NSObject

+ (instancetype)defaultDispatchCenter;

@property (nonatomic, strong) Class jumpController;
@property (nonatomic, strong) NSDictionary *parameters;
@property (nonatomic, strong) NSString *module;
@property (nonatomic, strong) NSDictionary *userInfo;

@property (nonatomic, strong) NSString *url;


@property (nonatomic, strong) BOOL(^authenticationFailure)(void);

- (BOOL)jumpToViewController;

@end
