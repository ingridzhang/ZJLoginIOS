//
//  NSString+SplitOnCapital.m
//  EZFramework_example
//
//  Created by sun on 15/10/13.
//  Copyright © 2015年 sunfei. All rights reserved.
//

#import "NSString+SplitOnCapital.h"

@implementation NSString (SplitOnCapital)

- (NSString *)toCamelCase
{
    return [[[self capitalizedString] componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"] invertedSet]] componentsJoinedByString:@""];
}

- (NSString *)splitOnCapital {
    NSRange upcaseRange = NSMakeRange('A', 26);
    NSRange numberRange = NSMakeRange('0', 10);
    NSIndexSet *upcaseSet = [NSIndexSet indexSetWithIndexesInRange:upcaseRange];
    NSIndexSet *numberSet = [NSIndexSet indexSetWithIndexesInRange:numberRange];
    NSMutableString *result = [NSMutableString string];
    NSMutableString *oneWord = [NSMutableString string];
    BOOL prevLetterIsUc = NO;
    for (int i = 0; i < self.length; i++) {
        char oneChar = [self characterAtIndex:i];
        if ([upcaseSet containsIndex:oneChar]||[numberSet containsIndex:oneChar]) {
            if ( prevLetterIsUc ) {
            } else {
                if (result.length == 0) {
                    [result appendFormat:@"%@", [oneWord lowercaseString]];
                }else {
                    [result appendFormat:@"_%@", [oneWord lowercaseString]];
                }
                oneWord = [NSMutableString string];
            }
            prevLetterIsUc = YES;
        } else {
            prevLetterIsUc = NO;
        }
        [oneWord appendFormat:@"%c", oneChar];
    }
    if (oneWord.length > 0) {
        [result appendFormat:@"_%@", [oneWord lowercaseString]];
    }
    return result;
}

@end
