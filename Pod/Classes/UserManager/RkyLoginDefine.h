
#ifndef EasyJieApp_RkyLoginDefine_h
#define EasyJieApp_RkyLoginDefine_h

typedef NS_ENUM(NSInteger, RkyWeixinErrCode)
{
    ERR_OK = 0,                  // (用户同意)
    ERR_AUTH_DENIED = -4,        //（用户拒绝授权）
    ERR_USER_CANCEL = -2        //（用户取消）
};

typedef NS_ENUM(NSUInteger, RkyLoginType)
{
    RkyLoginTypeMail,
    RkyLoginTypeWeixin
};
#endif
