
#import "RkyForgetPasswordModel.h"
#import <objc/runtime.h>
#import "LoginHeader.h"

@implementation RkyForgetPasswordModel

- (instancetype)initWithJSON:(NSDictionary *)JSON {
    self = [super init];
    if (self) {
        [JSON enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if (class_getProperty([self class], [key cStringUsingEncoding:NSUTF8StringEncoding])) {
                [self setValue:obj forKey:key];
            }
        }];
    }
    return self;
}

- (NSString *)msg {
    if (!_msg || (NSNull *)_msg == [NSNull null]) {
        return @"";
    }
    return _msg;
}

@end
