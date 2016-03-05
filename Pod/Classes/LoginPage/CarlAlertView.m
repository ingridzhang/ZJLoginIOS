//
//  CarlAlertView.m
//  TextIOS
//
//  Created by 李世乾 on 15/7/23.
//  Copyright (c) 2015年 李世乾. All rights reserved.
//

#import "CarlAlertView.h"

@implementation CarlAlertView
+(void)showAlertView:(NSString *)str
{
    if (!str.length) {
        return;
    }    
    UIView *praiseView = [[UIView alloc] init];
    praiseView.width = 120;
    praiseView.backgroundColor = HexColorWithAlpha(@"222222", 0.8); // [UIColor colorWithHexString:@"#222222" alpha:0.8];
    praiseView.layer.masksToBounds = YES;
    praiseView.layer.cornerRadius = 2;
    praiseView.alpha = 0;
    //动画效果
    [UIView animateWithDuration:0 animations:^{
        
        praiseView.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2.0 animations:^{
            praiseView.alpha = 0;
        } completion:^(BOOL finished) {
            [praiseView removeFromSuperview];
        }];
    }];
    
    UILabel *praiseLabel = [[UILabel alloc]init];
    //如果str为NULL则返回网络异常，否则直接返回
    praiseLabel.text = ((NSNull *)str == [NSNull null]) ? (str = @"网络异常，请稍后重试", str) : str;
    praiseLabel.textColor = [UIColor whiteColor];
    praiseLabel.font = [UIFont fontWithName:@"Arial" size:12];
    praiseLabel.textAlignment = NSTextAlignmentCenter;
    praiseLabel.layer.masksToBounds = YES;
    praiseLabel.layer.cornerRadius = 2;
    [praiseView addSubview:praiseLabel];
    //自动折行设置
    praiseLabel.lineBreakMode = NSLineBreakByWordWrapping;
    praiseLabel.numberOfLines = 0;
    CGRect rect = [str boundingRectWithSize:
                    CGSizeMake(praiseView.width, CGFLOAT_MAX)
                                            options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:[NSDictionary dictionaryWithObjectsAndKeys:praiseLabel.font,NSFontAttributeName, nil] context:nil];
    praiseLabel.frame = rect;
    praiseView.frame = CGRectMake(0, 0, rect.size.width+20, rect.size.height+20);
    praiseLabel.top = praiseView.top+10;
    praiseLabel.left = praiseView.left+10;
    praiseView.centerX = [UIScreen mainScreen].bounds.size.width/2;
    praiseView.top = [UIScreen mainScreen].bounds.size.height - 80;
    
    [[UIApplication sharedApplication].keyWindow addSubview:praiseView];
}


+(void)showAlertView:(NSString *)str position:(ShowPositionType)type
{
    UIView *praiseView = [[UIView alloc] init];
    praiseView.width = 120;
    praiseView.backgroundColor = HexColorWithAlpha(@"222222", 0.8); //[UIColor colorWithHexString:@"#222222" alpha:0.8];
    praiseView.layer.masksToBounds = YES;
    praiseView.layer.cornerRadius = 2;
    praiseView.alpha = 0;
    //动画效果
    [UIView animateWithDuration:0 animations:^{
        
        praiseView.alpha = 1.0;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:2.0 animations:^{
            praiseView.alpha = 0;
        } completion:^(BOOL finished) {
            [praiseView removeFromSuperview];
        }];
    }];
    
    UILabel *praiseLabel = [[UILabel alloc]init];
    //如果str为NULL则返回网络异常，否则直接返回
    praiseLabel.text = ((NSNull *)str == [NSNull null]) ? (str = @"网络异常，请稍后重试", str) : str;
    praiseLabel.textColor = [UIColor whiteColor];
    praiseLabel.font = [UIFont fontWithName:@"Arial" size:12];
    praiseLabel.textAlignment = NSTextAlignmentCenter;
    praiseLabel.layer.masksToBounds = YES;
    praiseLabel.layer.cornerRadius = 2;
    [praiseView addSubview:praiseLabel];
    //自动折行设置
    praiseLabel.lineBreakMode = NSLineBreakByWordWrapping;
    praiseLabel.numberOfLines = 0;
    CGRect rect = [str boundingRectWithSize:
                   CGSizeMake(praiseView.width, CGFLOAT_MAX)
                                    options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                 attributes:[NSDictionary dictionaryWithObjectsAndKeys:praiseLabel.font,NSFontAttributeName, nil] context:nil];
    praiseLabel.frame = rect;
    praiseView.frame = CGRectMake(0, 0, rect.size.width+20, rect.size.height+20);
    praiseLabel.top = praiseView.top+10;
    praiseLabel.left = praiseView.left+10;
    praiseView.centerX = [UIScreen mainScreen].bounds.size.width/2;
    if (type == ShowPositionBottomType) {
        praiseView.top = [UIScreen mainScreen].bounds.size.height - 80;
    }else if(type == ShowPositionMiddleType) {
        praiseView.top = [UIScreen mainScreen].bounds.size.height/2;
    }
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:praiseView];
}

@end
