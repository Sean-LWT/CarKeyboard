//
//  WTCarKeyboardModel.h
//  Demo
//
//  Created by Sean on 2016/12/9.
//  Copyright © 2016年 Sean. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class WTCarKeyboardModel;

@protocol WTCarKeyboardModelDelegate <NSObject>

@optional
- (void)orientationDidChangeWithCarKeyboardModel:(WTCarKeyboardModel* )carKeyboardModel landscape:(BOOL)isLandscape;

@end

#define kCarKeyBoardScreenWidth [UIScreen mainScreen].bounds.size.width
#define kCarKeyBoardScreenHeight [UIScreen mainScreen].bounds.size.height

@interface WTCarKeyboardModel : NSObject

@property (nonatomic,weak)id <WTCarKeyboardModelDelegate>delegate;

@property (nonatomic,assign,readonly)UIDeviceOrientation type; //屏幕方向

@property (nonatomic,assign)CGFloat btnHeight; //按钮高度
@property (nonatomic,assign)CGFloat btnWidth; //按钮宽度
@property (nonatomic,assign)CGFloat btnHeightSpace; //按钮上下间隔
@property (nonatomic,assign)CGFloat btnWidthSpace; //按钮左右间隔
@property (nonatomic,assign,readonly)CGRect viewFrame; //背景界面frame
@property (nonatomic,assign,readonly)CGRect superViewFrame;

@end
