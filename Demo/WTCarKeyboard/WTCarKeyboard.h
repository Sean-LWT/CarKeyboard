//
//  WTCarKeyboard.h
//
//  Created by Sean on 2016/12/7.
//  Copyright © 2016年 Sean. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WTCarKeyboard: UIView

+ (instancetype)shareWithTextInput:(UITextField* )inputView;

- (instancetype)initWithTextInput:(UITextField* )inputView;

@end
