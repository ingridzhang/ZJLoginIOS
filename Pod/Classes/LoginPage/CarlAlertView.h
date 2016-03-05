
#import <Foundation/Foundation.h>
#import "UIView+Frame.h"
#import "LoginHeader.h"

typedef NS_ENUM(NSUInteger, ShowPositionType){
    
    ShowPositionBottomType,  //底部显示
    ShowPositionMiddleType   //中间显示
};

@interface CarlAlertView : NSObject
+(void)showAlertView:(NSString *)str;
+(void)showAlertView:(NSString *)str position:(ShowPositionType)type;
@end
