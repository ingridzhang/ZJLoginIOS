
#import "UIFont+RkySkin.h"
#import "LoginHeader.h"

@implementation UIFont (RkySkin)

+ (instancetype) fontForModule:(NSString *)module target:(NSString *)target
{
    return [self fontForModule:module target:target skinStyle:RkySkinStyleDefault];
}

+ (instancetype) fontForModule:(NSString *)module target:(NSString *)target skinStyle:(RkySkinStyle)skinStyle
{
    NSAssert(module.length > 0 && target.length > 0, @"module or target illegal");
    NSDictionary * resourceMap = [[RkySkinManager sharedInstance] resourceMapForSkinStyle:skinStyle];
    NSDictionary * dicFont = [[resourceMap objectForKey:module] objectForKey:target];
    
    NSString * fontName = dicFont[kSkinConfigKeyFontName];
    float fontSize = [dicFont[kSkinConfigKeyFontSize] floatValue];
    
    UIFont * font = nil;
    if (fontName.length <= 0) {
        fontName = kSkinStyleDefaultFontName;//Create font with default name
    }
    if (fontName.length > 0) {
        font = [UIFont fontWithName:fontName size:fontSize];
    }
#if DEBUG
    else
    {
        NSLog(@"not exist font for key %@", target);
    }
#endif
    
    return font;
}
@end
