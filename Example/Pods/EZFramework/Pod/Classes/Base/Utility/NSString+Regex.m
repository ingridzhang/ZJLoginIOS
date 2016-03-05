//
//  NSString+Regex.m
//  MyNewBlog
//
//  Created by apple on 15/9/4.
//  Copyright © 2015年 itcast. All rights reserved.
//

#import "NSString+Regex.h"

@implementation NSString (Regex)
- (void)hrefLink:(void(^)(NSString *link,NSString *text))completion {
    NSString *pattern = @"<a href=\"(.*?)\".*?>(.*?)</a>";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionDotMatchesLineSeparators error:nil];
    NSTextCheckingResult *result = [regex firstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
    if (result != nil) {
        NSRange r1 = [result rangeAtIndex:1];
        NSRange r2 = [result rangeAtIndex:2];
        NSString *link = [self substringWithRange:r1];
        NSString *text = [self substringWithRange:r2];
        completion(link,text);
    }else {
        completion(nil,nil);
    }
    
}
@end
