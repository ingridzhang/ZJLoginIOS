//
//  RkyCustomTextField.m
//  EasyJieApp
//
//  Created by ricky on 14-9-2.
//  Copyright (c) 2014年 easyjie. All rights reserved.
//

#import "RkyCustomTextField.h"
#import "LoginHeader.h"

@implementation RkyCustomTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (CGRect)leftViewRectForBounds:(CGRect)bounds;
{
    return UIEdgeInsetsInsetRect(bounds, self.cusLeftViewInsets);
}
- (CGRect)textRectForBounds:(CGRect)bounds
{
    return UIEdgeInsetsInsetRect(bounds, self.cusTextInsets);
}
- (CGRect)placeholderRectForBounds:(CGRect)bounds
{
    return UIEdgeInsetsInsetRect(bounds, self.cusTextInsets);
}
- (CGRect)editingRectForBounds:(CGRect)bounds
{
    return UIEdgeInsetsInsetRect(bounds, self.cusTextInsets);
}

- (void)drawPlaceholderInRect:(CGRect)rect
{
    //CGContextRef context = UIGraphicsGetCurrentContext();
    //CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
//    [[UIColor colorWithRed:1 green:1 blue:1 alpha:0.6] setFill];
    UIFont *font=[UIFont fontWithName:@"Palatino-Roman" size:12.0];
    //[[self placeholder] drawInRect:rect withFont:[UIFont systemFontOfSize:20]];
    NSDictionary *placeholderPropertyDic=[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,[UIColor colorWithRed:1 green:1 blue:1 alpha:0.6] ,NSForegroundColorAttributeName,nil];
    [[self placeholder]drawAtPoint:CGPointMake(5, (self.frame.size.height-12)/2) withAttributes:placeholderPropertyDic];
}
@end
