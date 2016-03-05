
#import "RkyWeixinHandler.h"
#import "RkyLoginDefine.h"
#import "RkyLoginService.h"
#import "EZProgressHUD.h"
#import "LoginHeader.h"

@interface RkyWeixinHandler () 
@property (nonatomic, strong) NSTimer *refreshTimer;

@property (nonatomic, strong) NSURLSessionDataTask *accessTokenDataTask;
@property (nonatomic, strong) NSURLSessionDataTask *refreshTokenDataTask;
@property (nonatomic, strong) NSURLSessionDataTask *getUserInfoDataTask;
@property (nonatomic, strong) NSURLSessionDataTask *weixinLoginDataTask;
@property (nonatomic, strong) NSURLSessionDataTask *weChatLoginDataTask;

@property (nonatomic, strong) void(^successLogin)(id model);
@property (nonatomic, strong) void(^failureLogin)(NSError *error);

@end

@implementation RkyWeixinHandler

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self stopRefreshTimer];
    
    [self.accessTokenDataTask cancel];
    [self.refreshTokenDataTask cancel];
    [self.getUserInfoDataTask cancel];
    [self.weixinLoginDataTask cancel];
}

+ (instancetype) sharedInstance
{
    static dispatch_once_t once;
    static RkyWeixinHandler   *_sharedInstance;
    
    dispatch_once(&once, ^{
        _sharedInstance = [[RkyWeixinHandler alloc] init];
    });
    return _sharedInstance;
}

- (instancetype) init
{
    if (self = [super init]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willEnterforeground:) name:UIApplicationWillEnterForegroundNotification object:nil];
    }
    return self;
}

#pragma mark - public
-(void)loginWithSuccess:(void(^)(id model))success failure:(void(^)(NSError *error))failrue
{
    if (success) {
        self.successLogin = success;
    }
    if (failrue) {
        self.failureLogin = failrue;
    }
    //构造SendAuthReq结构体
    SendAuthReq* req =[[SendAuthReq alloc] init];
    req.scope = @"snsapi_userinfo" ;
    req.state = @"sss" ;
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendReq:req];
}

- (void)loginOutWithSuccess:(void (^)(id model))success failure:(void (^)(void))failure
{
    [self stopRefreshTimer];
    if (success) {
        success(nil);
    }
}

#pragma mark - WXApiDelegate
-(void) onReq:(BaseReq*)req
{
    if ([req isKindOfClass:[GetMessageFromWXReq class]]) {
    
    }
    else if ([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
//        RINFO(@"ShowMessageFromWXReq  req");
    }
    else if ([req isKindOfClass:[LaunchFromWXReq class]])
    {
//        RINFO(@"LaunchFromWXReq  req");
    }
}
-(void) onResp:(BaseResp*)resp
{
    if ([resp isKindOfClass:[GetMessageFromWXResp class]]) {
//        RINFO(@"GetMessageFromWXResp resp");
    }
    
    if ([resp isKindOfClass:[SendAuthResp class]])
    {
        if (resp.errCode == ERR_OK)
        {
             [self getAccessToken:((SendAuthResp *)resp).code];
        }
        else
        {
            
        }
    }
    else {
        
    }
}

#pragma mark - access & refresh token
- (void) getAccessToken:(NSString *) code
{
    [self.accessTokenDataTask cancel];
    self.accessTokenDataTask = [RkyLoginService getAccessToken:code success:^(id model) {
        [RkyLoginUserInfo sharedInstance].authInfo = model;
        [RkyLoginUserInfo sharedInstance].loginType = RkyLoginTypeWeixin;
        [self weixinLogin];
    } failure:^{
        if (self.failureLogin) {
            NSError *error = [NSError errorWithDomain:@"获取微信AccessToken失败" code:1000 userInfo:nil];
            self.failureLogin(error);
        }
    }];
}

- (void) refreshToken
{
    [self stopRefreshTimer];
    
    RkyAuthInfo * authInfo = [[RkyLoginUserInfo sharedInstance] authInfo];
    if (!authInfo || !authInfo.refreshToken) {
        return;
    }
    
    [self.refreshTokenDataTask cancel];
    self.refreshTokenDataTask = [RkyLoginService refreshAccessToken:authInfo.refreshToken success:^(id model) {
        [self startRefreshTimer];
        [RkyLoginUserInfo sharedInstance].authInfo = model;
    } failure:^{
        
    }];
}


- (void) weixinLogin
{
    NSString *token  =[RkyLoginUserInfo sharedInstance].authInfo.accessToken;
    NSString *openId = [RkyLoginUserInfo sharedInstance].authInfo.openID;
    [self.weChatLoginDataTask cancel];
    self.weChatLoginDataTask = [RkyLoginService weChatLogin:@{@"access_token":token, @"openid":openId} success:^(RkyUser *loginUser) {
        [RkyLoginUserInfo sharedInstance].userInfo = loginUser;
        [[EZApp shareInstance] setLoginUserInfo:[@(loginUser.userID) stringValue] loginKey:loginUser.loginKey];
        [RkyLoginUserInfo sharedInstance].loginType = RkyLoginTypeWeixin;
        
        SEL sel = @selector(profileSignInWithPUID:);
        [self.MobClick performSelector:sel withObject:[@(loginUser.userID) stringValue] withObject:@"WX"];
        
//        [MobClick profileSignInWithPUID:[@(loginUser.userID) stringValue] provider:@"WX"];
        if (self.successLogin) {
            self.successLogin(loginUser);
        }
    } failure:^(NSError *error){
        if (self.failureLogin) {
            NSError *error = [NSError errorWithDomain:@"微信登录授权失败，请重新登录" code:1001 userInfo:nil];
            self.failureLogin(error);
        }
    }];
}

- (void) getWeixinUserInfo
{
    [self.getUserInfoDataTask cancel];
    self.getUserInfoDataTask = [RkyLoginService getWeChatUserInfo:[RkyLoginUserInfo sharedInstance].authInfo.accessToken openId:[RkyLoginUserInfo sharedInstance].authInfo.openID success:^(RkyUser *userinfo) {
        [RkyLoginUserInfo sharedInstance].userInfo = userinfo;
        [[EZApp shareInstance] setLoginUserInfo:[@(userinfo.userID) stringValue] loginKey:userinfo.loginKey];
//        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLoginSuccess object:nil];
    } failure:^{
//        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLoginSuccess object:nil];
    }];
}

#pragma mark - refresh strategy

- (void) handleRefreshToken
{
    RkyAuthInfo * authInfo = [[RkyLoginUserInfo sharedInstance] authInfo];
    if (authInfo)
    {
        if ([self shouldRefresh])
        {
            [self stopRefreshTimer];
            [self refreshToken];
        }
        else
        {
            [self startRefreshTimer];
        }
    }
}

- (void)startRefreshTimer
{
    [self stopRefreshTimer];
    self.refreshTimer = [NSTimer scheduledTimerWithTimeInterval:1200 target:self selector:@selector(onRefreshTimer:) userInfo:nil repeats:YES];
}

- (void)stopRefreshTimer
{
    [self.refreshTimer invalidate];
    self.refreshTimer = nil;
}

- (BOOL)shouldRefresh
{
    RkyAuthInfo * authInfo = [[RkyLoginUserInfo sharedInstance] authInfo];
    if (authInfo)
    {
        NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:authInfo.lastRefresh];
        return interval > authInfo.expireSec - 1200 - 100;
    }
    return NO;
}

- (void)onRefreshTimer:(id)userInfo
{
    if ([self shouldRefresh])
    {
        [self stopRefreshTimer];
        [self refreshToken];
    }
}

#pragma mark - notification

- (void)willEnterforeground:(NSNotification *)notification
{
    [self handleRefreshToken];
}

@end
