
#import "RkyUser.h"
#import "LoginHeader.h"

@implementation RkyUser

- (NSString *)openID {
    if (!_openID || (NSNull *)_openID == [NSNull null]) {
        return @"";
    }
    return _openID;
}

- (NSString *)email {
    if (!_email || (NSNull *)_email == [NSNull null]) {
        return @"";
    }
    return _email;
}

- (NSString *)nickName {
    if (!_nickName || (NSNull *)_nickName == [NSNull null]) {
        return @"";
    }
    return _nickName;
}

- (NSString *)password {
    if (!_password || (NSNull *)_password == [NSNull null]) {
        return @"";
    }
    return _password;
}

- (NSString *)province {
    if (!_province || (NSNull *)_province == [NSNull null]) {
        return @"";
    }
    return _province;
}

- (NSString *)city {
    if (!_city || (NSNull *)_city == [NSNull null]) {
        return @"";
    }
    return _city;
}

- (NSString *)country {
    if (!_country || (NSNull *)_country == [NSNull null]) {
        return @"";
    }
    return _country;
}

- (NSString *)headimgurl {
    if (!_headimgurl || (NSNull *)_headimgurl == [NSNull null]) {
        return @"";
    }
    return _headimgurl;
}

- (NSString *)privilege {
    if (!_privilege || (NSNull *)_privilege == [NSNull null]) {
        return @"";
    }
    return _privilege;
}

- (NSString *)unionid {
    if (!_unionid || (NSNull *)_unionid == [NSNull null]) {
        return @"";
    }
    return _unionid;
}

- (NSString *)loginKey {
    if (!_loginKey || (NSNull *)_loginKey == [NSNull null]) {
        return @"";
    }
    return _loginKey;
}

- (NSString *)loginToken {
    if (!_loginToken || (NSNull *)_loginToken == [NSNull null]) {
        return @"";
    }
    return _loginToken;
}

- (NSString *)photo {
    if (!_photo || (NSNull *)_photo == [NSNull null]) {
        return @"";
    }
    return _photo;
}

- (NSDate *)registerTime {
    if (!_registerTime || (NSNull *)_registerTime == [NSNull null]) {
        return [NSDate date];
    }
    return _registerTime;
}

@end


