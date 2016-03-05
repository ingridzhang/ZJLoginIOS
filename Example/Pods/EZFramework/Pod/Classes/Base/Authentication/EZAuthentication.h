//
//  EZAuthentication.h
//  EZFramework_example
//
//  Created by sun on 15/10/10.
//  Copyright © 2015年 sunfei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EZAuthentication : NSObject

+ (BOOL)authenticationForUserWithMappingURL:(NSString *)url;

@end
