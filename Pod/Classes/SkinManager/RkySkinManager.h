
#import <Foundation/Foundation.h>
#import "LoginHeader.h"

@interface RkySkinManager : NSObject

@property (nonatomic, readonly) RkySkinStyle currentStyle;
@property (nonatomic, readonly) NSCache *imageCache;

+ (instancetype) sharedInstance;

- (NSBundle *)bundleForSkinStyle:(RkySkinStyle)skinStyle;
- (NSDictionary *)resourceMapForSkinStyle:(RkySkinStyle)skinStyle;
- (void) switchToStyle:(RkySkinStyle) skinStyle completion:(void (^)(BOOL isFinished))completionHandler;

- (NSCache *) imageCacheForStyle: (RkySkinStyle) skinStyle;
@end
