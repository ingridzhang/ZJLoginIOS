//
//  RkyMacros.h
//  EasyJieApp
//
//  Created by eson on 14-8-30.
//  Copyright (c) 2014年 easyjie. All rights reserved.
//

#ifndef EasyJieApp_RkyMacros_h
#define EasyJieApp_RkyMacros_h


#define RKCallBlockSafely(block, ...) \
    do {\
    if (block) {\
        block(__VA_ARGS__);\
        }\
    } while (0);

//Auto Encoder && Decoder
#define RkyImplementAutoCodingMethod \
\
- (instancetype)initWithCoder:(NSCoder *)aDecoder\
{\
    [self setWithCoder:aDecoder];\
    return self;\
}\
\
- (void)encodeWithCoder:(NSCoder *)aCoder\
{\
    for (NSString *key in [self codableProperties])\
    {\
        id object = [self valueForKey:key];\
        if (object) [aCoder encodeObject:object forKey:key];\
    }\
}\

//Initial UI Elements For Key
#define RykInitialLabelForKey(label,moduleKey,targetKey)\
    do {\
        label.font = [UIFont fontForModule:moduleKey target:targetKey];\
        label.textColor = [UIColor colorForModule:moduleKey target:targetKey];\
    } while (0);

#define RykInitialButtonForKey(button,moduleKey,targetKey)\
    do {\
        button.titleLabel.font = [UIFont fontForModule:moduleKey target:targetKey];\
        [button setTitleColor:[UIColor colorForModule:moduleKey target:targetKey] forState:UIControlStateNormal];\
        UIColor *highlightedColor = [UIColor colorForModule:moduleKey target:targetKey colorType:RkyColorTypeHighlighted];\
        if (highlightedColor) {\
            [button setTitleColor:highlightedColor forState:UIControlStateHighlighted];\
        }\
    } while (0);

#define RykInitialTextFieldForKey(textField,moduleKey,targetKey)\
    do {\
        textField.font = [UIFont fontForModule:moduleKey target:targetKey];\
    } while (0);


#define RykInitialTextViewForKey(textView,moduleKey,targetKey)\
    do {\
        textView.font = [UIFont fontForModule:moduleKey target:targetKey];\
        textView.textColor = [UIColor colorForModule:moduleKey target:targetKey];\
    } while (0);



//DEBUG LOG LEVEL
#define LOGLEVEL_INFO     5
#define LOGLEVEL_WARN     3
#define LOGLEVEL_ERROR    1

#ifndef MAXLOGLEVEL
#define MAXLOGLEVEL LOGLEVEL_INFO
#endif

/***************************************************************/
#ifdef DEBUG
#define RPRINT(xx, ...) NSLog((@"-%d %s\n" xx "\n-----------------------------------------\n"),  __LINE__ , __FUNCTION__, ##__VA_ARGS__);
#else
#define RPRINT(xx, ...)  ((void)0)
#endif


#if LOGLEVEL_ERROR <= MAXLOGLEVEL
#define RERROR(xx, ...) RPRINT(xx, ##__VA_ARGS__)
#else
#define RERROR(xx, ...)  ((void)0)
#endif

#if LOGLEVEL_WARN <= MAXLOGLEVEL
#define RWARN(xx, ...)  RPRINT(xx, ##__VA_ARGS__)
#else
#define RWARN(xx, ...)  ((void)0)
#endif

#if LOGLEVEL_INFO <= MAXLOGLEVEL
#define RINFO(xx, ...)  RPRINT(xx, ##__VA_ARGS__)
#else
#define RINFO(xx, ...)  ((void)0)
#endif

inline static CGRect CGRectEdgeInset(CGRect rect, UIEdgeInsets insets)
{
    return CGRectMake(CGRectGetMinX(rect) + insets.left,
                      CGRectGetMinY(rect) + insets.top,
                      CGRectGetWidth(rect) - insets.left - insets.right,
                      CGRectGetHeight(rect) - insets.top - insets.bottom);
}

#define kDeviceWidth                ([[UIScreen mainScreen] bounds].size.width)
#define kDeviceHeight               ([[UIScreen mainScreen] bounds].size.height)

#define IPHONE5 CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)

//字符串不为空
#define IS_NOT_EMPTY(string) (string !=nil && ![string isKindOfClass:[NSNull class]] && ![string isEqualToString:@""] && ![string isEqualToString:@"(null)"])

#endif
