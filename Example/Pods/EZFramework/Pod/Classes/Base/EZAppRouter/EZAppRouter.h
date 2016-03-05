//
//  EZRouter.h
//  EZFramework_example
//
//  Created by sun on 15/10/12.
//  Copyright © 2015年 sunfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EZAppRouter : NSObject

+ (instancetype)standardRouter;

- (void)jump:(NSString *)url;
- (void)jump:(NSString *)url userInfo:(NSDictionary *)userInfo;

@end
