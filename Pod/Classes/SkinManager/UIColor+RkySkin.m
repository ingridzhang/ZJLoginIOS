
#import "UIColor+RkySkin.h"

@implementation UIColor (RkySkin)

+ (instancetype)colorForModule:(NSString *)module target:(NSString *)target
{
    return [self colorForModule:module target:target skinStyle:[[RkySkinManager sharedInstance] currentStyle]];
}

+ (instancetype)colorForModule:(NSString *)module target:(NSString *)target colorType:(RkyColorType) colorType
{
    return [self colorForModule:module target:target skinStyle:RkySkinStyleDefault colorType:colorType];
}

+ (instancetype)colorForModule:(NSString *)module target:(NSString *)target skinStyle:(RkySkinStyle) skinStyle
{
    return [self colorForModule:module target:target skinStyle:skinStyle colorType:RkyColorTypeNormal];
}

+ (instancetype)colorForModule:(NSString *)module target:(NSString *)target skinStyle:(RkySkinStyle) skinStyle  colorType:(RkyColorType) colorType
{
    NSAssert(module.length > 0 && target.length > 0, @"module or target is illegal");
    NSDictionary * resourceMap = [[RkySkinManager sharedInstance] resourceMapForSkinStyle:skinStyle];
    NSDictionary * dicMember = [[resourceMap objectForKey:module] objectForKey:target];
    if (!dicMember&&[RkySkinManager sharedInstance].currentStyle!=RkySkinStyleDefault) {
        
        resourceMap = [[RkySkinManager sharedInstance] resourceMapForSkinStyle:RkySkinStyleDefault];
        dicMember = [[resourceMap objectForKey:module] objectForKey:target];
    }
    NSString * colorString = nil;
    switch (colorType) {
        case RkyColorTypeNormal:
        {
            colorString = dicMember[kSkinConfigKeyColorNormal];
            break;
        }
        case RkyColorTypeHighlighted:
        {
            colorString = dicMember[kSkinConfigKeyColorHighlighted];
            break;
        }
        case RkyColorTypeSelected:
        {
            colorString = dicMember[kSkinConfigKeyColorSelected];
            break;
        }
        case RkyColorTypeDisabled:
        {
            colorString = dicMember[kSkinConfigKeyColorDisabled];
            break;
        }
        case RkyColorTypeShadow:{
            colorString = dicMember[kSkinConfigKeyColorShadow];
        } break;
        default:
            colorString = dicMember[kSkinConfigKeyColorNormal];
            break;
    }
    
    CGFloat redValue;
    CGFloat greenValue;
    CGFloat blueValue;
    CGFloat alphaValue = 1.0f;
    
    UIColor *color = nil;
    
    if ([colorString hasPrefix:@"#"] || [colorString hasPrefix:@"0x"]) {
        uint colorHexValue;
        colorString = [colorString stringByReplacingOccurrencesOfString:@"#" withString:@""];
        colorString = [colorString stringByReplacingOccurrencesOfString:@"0x" withString:@""];
        [[NSScanner scannerWithString:colorString] scanHexInt:&colorHexValue];
        color = [self colorWithValue:colorHexValue];
    }
    else
    {
        NSArray *colorArray = [colorString componentsSeparatedByString:@","];
        if (colorArray.count >= 3 ) {
            redValue = [colorArray[0] floatValue];
            greenValue = [colorArray[1] floatValue];
            blueValue = [colorArray[2] floatValue];
        }
        
        if (colorArray.count >= 4 ) {
            alphaValue = [colorArray[3] floatValue];
        }
        
        color = [UIColor colorWithRed:redValue/255.0f green:greenValue/255.0f blue:blueValue/255.0f alpha:alphaValue];
    }
#if DEBUG
    if (!color) {
        NSLog(@"!!!Can not found color for module:%@ target:%@",module,target);
    }
#endif
    
    return  color;
}


+ (UIColor *)colorWithValue:(NSInteger)colorValue
{
	if (colorValue > 0xFFFFFF) {
		return [UIColor colorWithRed:((float)((colorValue & 0xFF0000) >> 16)) / 255.0
							   green:((float)((colorValue & 0xFF00) >> 8)) / 255.0
								blue:((float)((colorValue & 0xFF) >> 0)) / 255.0
							   alpha:((float)((colorValue & 0xFF000000) >> 24)) / 255.0];
        
	}
    
	return [UIColor colorWithRed:((float)((colorValue & 0xFF0000) >> 16)) / 255.0
						   green:((float)((colorValue & 0xFF00) >> 8)) / 255.0
							blue:((float)(colorValue & 0xFF)) / 255.0
						   alpha:1];
}

+ (UIColor *)colorWithValue:(NSInteger)colorValue alpha:(float)alpha
{
    if (colorValue > 0xFFFFFF) {
        return [UIColor colorWithRed:((float)((colorValue & 0xFF0000) >> 16)) / 255.0
                               green:((float)((colorValue & 0xFF00) >> 8)) / 255.0
                                blue:((float)((colorValue & 0xFF) >> 0)) / 255.0
                               alpha:((float)((colorValue & 0xFF000000) >> 24)) / 255.0];
        
    }
    
    return [UIColor colorWithRed:((float)((colorValue & 0xFF0000) >> 16)) / 255.0
                           green:((float)((colorValue & 0xFF00) >> 8)) / 255.0
                            blue:((float)(colorValue & 0xFF)) / 255.0
                           alpha:alpha];
}

@end
