//
//  WTCarKeyboard.h
//
//  Created by Sean on 2016/12/7.
//  Copyright © 2016年 Sean. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTCarKeyboardModel.h"
@class WTCarKeyboard;

@protocol WTCarKeyboardDelegate <NSObject>

@optional
/** 输入文字改变代理 */
- (void)carKeyboard:(WTCarKeyboard* )carKeyboard didChangeWithText:(NSString* )textStr;

@end

@interface WTCarKeyboard : UIView

/** WTCarKeyboard代理 */
@property (nonatomic,weak)id <WTCarKeyboardDelegate>delegate;

/** 键盘输入block(使用代理方法则不执行block) */
@property (nonatomic,copy)void(^inputBlock)(NSString* textStr);

@end
