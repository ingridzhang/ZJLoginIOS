//
//  UIImage+RkySkin.m
//  EasyJie
//
//  Created by ricky on 14-8-23.
//  Copyright (c) 2014年 rickycui. All rights reserved.
//
#import "LoginHeader.h"
#import "UIImage+RkySkin.h"

@implementation UIImage (RkySkin)

+ (instancetype) imageForKey:(NSString *)key
{
    return [self imageForKey:key skinStyle:[[RkySkinManager sharedInstance] currentStyle]];
}

+ (instancetype) imageForKey:(NSString *)key skinStyle:(RkySkinStyle)skinStyle cache:(BOOL)cache
{
    NSAssert(key.length, @"image key is illegal");
    
    NSCache * iamgeCache = [[RkySkinManager sharedInstance] imageCacheForStyle:skinStyle];
    UIImage * image = [iamgeCache objectForKey:key];
    if (!image) {
        NSBundle * bundle = [[RkySkinManager sharedInstance] bundleForSkinStyle:skinStyle];
        image = [self imageForKey:key inBundle:bundle];
        if (!image&&[[RkySkinManager sharedInstance] currentStyle] != RkySkinStyleDefault) {
            
            NSBundle * bundle = [[RkySkinManager sharedInstance] bundleForSkinStyle:RkySkinStyleDefault];
            image = [self imageForKey:key inBundle:bundle];
        }
        if (image && cache) {
            [iamgeCache setObject:image forKey:key];
        }
    }
#if DEBUG
    if (!image) {
        NSLog(@"!!!Can not found image for key:%@",key);
    }
#endif

    return image;
}

+ (instancetype)imageForKey: (NSString *)key skinStyle:(RkySkinStyle) skinStyle
{
    return [self imageForKey:key skinStyle:skinStyle cache:YES];
}

+ (UIImage *) imageForKey: (NSString*)key inBundle:(NSBundle *) bundle
{
    key = [key stringByDeletingPathExtension];
    
    NSString * picType = @"png";
    NSString * imagePath = [bundle pathForResource:[NSString stringWithFormat:@"%@@2x", key] ofType:picType];
    if (![[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
        imagePath = [bundle pathForResource:key ofType:picType];
    }
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:imagePath]) {
        imagePath = [bundle pathForResource:key ofType:@"jpg"];
    }
    
    return  [UIImage imageWithContentsOfFile:imagePath];
    
}
@end
