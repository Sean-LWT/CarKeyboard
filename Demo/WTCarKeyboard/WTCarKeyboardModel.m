//
//  WTCarKeyboardModel.m
//  Demo
//
//  Created by Sean on 2016/12/9.
//  Copyright © 2016年 Sean. All rights reserved.
//

#import "WTCarKeyboardModel.h"

@interface WTCarKeyboardModel ()

@end

@implementation WTCarKeyboardModel

- (instancetype)init;
{
    self = [super init];
    if (self)
    {
        _type = [[UIDevice currentDevice] orientation];
        [self shareData];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged) name:UIDeviceOrientationDidChangeNotification object:nil];
    }
    return self;
}

/** 处理函数 */
-(void)orientationChanged;
{
    _type = [[UIDevice currentDevice] orientation];
    [self shareData];
    switch (_type)
    {
        case UIDeviceOrientationLandscapeLeft:case UIDeviceOrientationLandscapeRight:
        {
            //设置
            if ([_delegate respondsToSelector:@selector(orientationDidChangeWithCarKeyboardModel:landscape:)])
            {
                [_delegate orientationDidChangeWithCarKeyboardModel:self landscape:YES];
            }
        }
            break;
        case UIDeviceOrientationPortrait:
        {
            //设置
            if ([_delegate respondsToSelector:@selector(orientationDidChangeWithCarKeyboardModel:landscape:)])
            {
                [_delegate orientationDidChangeWithCarKeyboardModel:self landscape:NO];
            }
        }
            break;
        default:
        {
            ;
        }
            break;
    }
}

/** 设置数据 */
- (void)shareData;
{
    _btnWidth = (kCarKeyBoardScreenWidth-5*11.0)/10.0;
    if (@available(iOS 11.0,*))
    {
        UIEdgeInsets edge = [UIApplication sharedApplication].delegate.window.safeAreaInsets;
        _btnWidth = (kCarKeyBoardScreenWidth-edge.left-edge.right-5*11.0)/10.0;
    }
    _btnHeight = 45.0f;
    _btnHeightSpace = (216-_btnHeight*4)/5.0;
    _btnWidthSpace = 5;
}
- (CGRect)viewFrame;
{
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    CGRect theViewFrame = CGRectZero;
    if (@available(iOS 11.0,*))
    {
        UIEdgeInsets edge = [UIApplication sharedApplication].delegate.window.safeAreaInsets;
        if (orientation == UIDeviceOrientationLandscapeLeft || orientation == UIDeviceOrientationLandscapeRight)
        {
            theViewFrame = CGRectMake(edge.left, 0, kCarKeyBoardScreenWidth-edge.left-edge.right, 216+edge.bottom);
        }
        else
        {
            theViewFrame = CGRectMake(0, 0, kCarKeyBoardScreenWidth, 216+edge.bottom);
        }
    }
    else
    {
        theViewFrame = CGRectMake(0, 0, kCarKeyBoardScreenWidth, 216);
    }
    return theViewFrame;
}
- (CGRect)superViewFrame;
{
    CGRect theViewFrame = CGRectZero;
    if (@available(iOS 11.0,*))
    {
        UIEdgeInsets edge = [UIApplication sharedApplication].delegate.window.safeAreaInsets;
        theViewFrame = CGRectMake(0, 0, kCarKeyBoardScreenWidth, 216+edge.bottom);
    }
    else
    {
        theViewFrame = CGRectMake(0, 0, kCarKeyBoardScreenWidth, 216);
    }
    return theViewFrame;
}

- (void)dealloc;
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
