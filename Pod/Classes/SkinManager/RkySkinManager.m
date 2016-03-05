//
//  RkySkinManager.m
//  EasyJie
//
//  Created by ricky on 14-8-23.
//  Copyright (c) 2014年 rickycui. All rights reserved.
//

#import "RkySkinManager.h"
#import "LoginHeader.h"

@interface RkySkinStyleItem : NSObject <NSCoding>
@property (nonatomic, strong) NSNumber * styleID;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * filePath;
@property (nonatomic, strong) NSNumber * version;
@end

@implementation RkySkinStyleItem


- (void) encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.styleID forKey:@"ID"];
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.filePath forKey:@"filepath"];
    [aCoder encodeObject:self.version forKey:@"version"];
}

- (id) initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.styleID = [aDecoder decodeObjectForKey:@"ID"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.filePath = [aDecoder decodeObjectForKey:@"filepath"];
        self.version = [aDecoder decodeObjectForKey:@"version"];
    }
    return self;
}

@end

@interface RkySkinManager ()
@property (nonatomic, strong) NSMutableDictionary *styleItemMaps;
@property (nonatomic, strong) NSMutableDictionary *resourceMaps;
@property (nonatomic, strong) NSMutableDictionary *imageCacheMaps;
@end

@implementation RkySkinManager

+ (instancetype) sharedInstance
{
    static RkySkinManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (instancetype) init
{
    if (self = [super init]) {
        self.resourceMaps = [NSMutableDictionary dictionary];
        self.imageCacheMaps = [NSMutableDictionary dictionary];
       
        int styles[2] = {RkySkinStyleDefault,RkySkinStyleNight};
        for (int i = 0; i < 2; i++) {
            NSString * filePath = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:[self bundleNameForSkinStyle:(RkySkinStyle)styles[i]]];
            
            RkySkinStyleItem * item = [[RkySkinStyleItem alloc] init];
            item.styleID = [NSNumber numberWithInt:(RkySkinStyle)styles[i]];
            item.filePath = filePath;
            item.version = @(1.0);
            item.name = [self styleKeyForSkinStyle:(RkySkinStyle)styles[i]];
            [self.styleItemMaps setObject:item forKey:item.name];
            [self resourceMapForSkinStyle:(RkySkinStyle)styles[i]];
        }
        
        NSData * styleItemMapData = [NSKeyedArchiver archivedDataWithRootObject:self.styleItemMaps];
        [[NSUserDefaults standardUserDefaults] setObject:styleItemMapData forKey:kSkinStyleItemMapCacheKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        _currentStyle = RkySkinStyleDefault;

    }
    return self;
}

- (NSMutableDictionary *) styleItemMaps
{
    if (!_styleItemMaps) {
        NSData * styleItemMapData = [[NSUserDefaults standardUserDefaults] objectForKey:kSkinStyleItemMapCacheKey];
        _styleItemMaps = [NSKeyedUnarchiver unarchiveObjectWithData:styleItemMapData];
        if (!_styleItemMaps) {
            _styleItemMaps = [NSMutableDictionary dictionary];
        }
    }
    return _styleItemMaps;
}

#pragma mark - Config

- (NSString *) bundleNameForSkinStyle: (RkySkinStyle) skinStyle
{
    switch (skinStyle) {
        case RkySkinStyleDefault:
            return kSkinDefaultsBundleName;
            break;
        case RkySkinStyleNight:
            return kSkinNightBundleName;
            break;
        default:
            break;
    }
    return kSkinDefaultsBundleName;
}

- (NSDictionary *) resourceMapForSkinStyle:(RkySkinStyle)skinStyle
{
    NSString * styleKey = [self styleKeyForSkinStyle:skinStyle];
    NSDictionary * resourceMap = [self.resourceMaps objectForKey: styleKey];
    
    if (!resourceMap) {
        NSBundle * bundle = [self bundleForSkinStyle:skinStyle];
        NSString * plistPath = [bundle pathForResource:kSkinStyleConfigPlistName ofType:@"plist"];
        resourceMap = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
        
        if (resourceMap) {
            [self.resourceMaps setObject:resourceMap forKey:styleKey];
        }
    }
    return resourceMap;
    
}

- (NSBundle *) bundleForSkinStyle:(RkySkinStyle)skinStyle
{
    RkySkinStyleItem * item = self.styleItemMaps[[self styleKeyForSkinStyle:skinStyle]];
    NSString *bundlePath = item.filePath;
    NSBundle * bundle;
    if (bundlePath.length > 0) {
        bundle = [NSBundle bundleWithPath:bundlePath];
    }
    return bundle;
}

- (NSString *) styleKeyForSkinStyle: (RkySkinStyle) skinStyle
{
    switch (skinStyle) {
        case RkySkinStyleDefault:
            return @"default";
            break;
        case RkySkinStyleNight:
            return @"night";
            break;
        default:
            break;
    }
    return @"default";
}

#pragma mark - Caching

- (NSCache *) imageCacheForStyle:(RkySkinStyle)skinStyle;
{
    NSString * imageCacheKey = [self styleKeyForSkinStyle:skinStyle];
    NSCache * imageCache = self.imageCacheMaps[imageCacheKey];
    if (!imageCache) {
        imageCache = [[NSCache alloc]init];
        self.imageCacheMaps[imageCacheKey] = imageCache;
    }
    return imageCache;
}

#pragma mark - Switch Style

- (BOOL) containsStyle:(RkySkinStyle) skinStyle
{
    NSString * styleKey = [self styleKeyForSkinStyle:skinStyle];
    if ([self.styleItemMaps objectForKey:styleKey] && [self.resourceMaps objectForKey:styleKey]) {
        return YES;
    }
    return NO;
}
- (void) switchToStyle:(RkySkinStyle)skinStyle completion:(void (^)(BOOL))completionHandler
{
    if (![self containsStyle:skinStyle]) {
        if (completionHandler) {
            completionHandler(NO);
        }
        return;
    }
    _currentStyle = skinStyle;
    if (completionHandler) {
        completionHandler(YES);
    }
}
@end
