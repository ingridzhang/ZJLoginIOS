

#ifndef EasyAdaptationDefine_h
#define EasyAdaptationDefine_h

//basic

//适配用的固定值，基于5s
#define kAdaptScreenHeight 568.0
#define kAdaptScreenWidth 320.0

#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

#define IPHONE_6_SCREEN_RADIO ((SCREEN_RADIO) / (375.0/320))
#define SCREEN_RADIO (IS_IPHONE_6 ? (375.0/320) : (IS_IPHONE_6P ? (414.0/320) : 1.0))
#define CGRECTMAKE(LEFT, TOP, WIDTH, HEIGHT) CGRectMake((LEFT)*SCREEN_RADIO, (TOP)*SCREEN_RADIO, (WIDTH)*SCREEN_RADIO, (HEIGHT)*SCREEN_RADIO)

#define CGSIZEMAKE(WIDTH, HEIGHT) CGSizeMake((WIDTH)*SCREEN_RADIO, (HEIGHT)*SCREEN_RADIO)
#define CGSizeMakeWithSize(size) CGSizeMake((size.width)*SCREEN_RADIO, (size.height)*SCREEN_RADIO)
#define IPHONE6RECTMAKE(LEFT, TOP, WIDTH, HEIGHT) CGRectMake((int)((LEFT)*IPHONE_6_SCREEN_RADIO), (int)((TOP)*IPHONE_6_SCREEN_RADIO), (int)((WIDTH)*IPHONE_6_SCREEN_RADIO), (int)((HEIGHT)*IPHONE_6_SCREEN_RADIO))

#define GRAVITY_MOVE_OFFSET 10 * IPHONE_6_SCREEN_RADIO
#define KTABBAR_HEIGHT 49 * SCREEN_RADIO


#endif /* EasyAdaptationDefine_h */
