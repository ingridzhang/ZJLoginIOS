//
//  RkyNameView.h
//  EasyJieApp
//
//  Created by 李世乾 on 15/7/23.
//  Copyright (c) 2015年 easyjie. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "RkyCustomTextField.h"

@class RkyNameView;

@protocol RkyNameViewDelegate <NSObject>

- (void) registerInputViewHeightChange: (RkyNameView *) inputView withOffset:(CGFloat) offset;
- (void) registerInputViewCommit: (RkyNameView *) inputView;
- (void) hideLogoImageAlpha:(BOOL)alphaYN;
@end


@interface RkyNameView : UIView
@property (nonatomic, strong, readonly) RkyCustomTextField * nickNameInput;

@property (nonatomic, strong, readonly) RkyCustomTextField * passwordInput;
@property (nonatomic, weak) id<RkyNameViewDelegate> delegate;

- (void)didTouchMaskView;

@end
