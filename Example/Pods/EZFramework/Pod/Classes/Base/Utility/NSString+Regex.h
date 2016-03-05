//
//  NSString+Regex.h
//  MyNewBlog
//
//  Created by apple on 15/9/4.
//  Copyright © 2015年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Regex)
- (void)hrefLink:(void(^)(NSString *link,NSString *text))completion;
@end
