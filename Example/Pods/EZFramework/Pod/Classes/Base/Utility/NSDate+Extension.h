//
//  NSDate+Extension.h
//  MyNewBlog
//
//  Created by apple on 15/9/4.
//  Copyright © 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
+ (NSDate *)sinaDate:(NSString *)string;
- (NSString *)dateDescription;
@end
