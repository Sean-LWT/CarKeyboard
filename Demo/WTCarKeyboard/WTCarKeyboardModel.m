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
        //默认设置
        if (_type == UIDeviceOrientationLandscapeLeft || _type == UIDeviceOrientationLandscapeRight)
        {
            
            [self setDataForLandscape:YES];
            _type = [[UIDevice currentDevice] orientation];
        }
        else if(_type == UIDeviceOrientationPortrait || _type == UIDeviceOrientationPortraitUpsideDown)
        {
            [self setDataForLandscape:NO];
            _type = [[UIDevice currentDevice] orientation];
        }
        else
        {
            [self setDataForLandscape:NO];
            _type = UIDeviceOrientationPortrait;
        }
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged) name:UIDeviceOrientationDidChangeNotification object:nil];
    }
    return self;
}

/** 处理函数 */
-(void)orientationChanged;
{
    switch ([[UIDevice currentDevice] orientation])
    {
        case UIDeviceOrientationPortrait:case UIDeviceOrientationPortraitUpsideDown:
        {
            if (_type == UIDeviceOrientationLandscapeLeft || _type == UIDeviceOrientationLandscapeRight || (_type == UIDeviceOrientationPortraitUpsideDown && [[UIDevice currentDevice] orientation] == UIDeviceOrientationPortrait))
            {
                //设置
                [self setDataForLandscape:NO];
                if ([_delegate respondsToSelector:@selector(orientationDidChangeWithCarKeyboardModel:landscape:)])
                {
                    [_delegate orientationDidChangeWithCarKeyboardModel:self landscape:NO];
                }
            }
            _type = [[UIDevice currentDevice] orientation];
        }
            break;
        case UIDeviceOrientationLandscapeLeft:case UIDeviceOrientationLandscapeRight:
        {
            if (_type != UIDeviceOrientationLandscapeLeft && _type != UIDeviceOrientationLandscapeRight)
            {
                //设置
                [self setDataForLandscape:YES];
                if ([_delegate respondsToSelector:@selector(orientationDidChangeWithCarKeyboardModel:landscape:)])
                {
                    [_delegate orientationDidChangeWithCarKeyboardModel:self landscape:YES];
                }
            }
            _type = [[UIDevice currentDevice] orientation];
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
- (void)setDataForLandscape:(BOOL)isLandscape;
{
    //设置
    if (isLandscape)
    {
        _btnWidth = 38.0f;
    }
    else
    {
        if([[UIDevice currentDevice] orientation] == UIDeviceOrientationPortraitUpsideDown)
        {
            _btnWidth = 38.0f;
        }
        else
        {
            _btnWidth = 28.0f;
        }
    }
    _btnHeight = 45.0f;
    _btnHeightSpace = (216-_btnHeight*4)/5.0;
    _btnWidthSpace = (screenWidth-10*_btnWidth)/11.0;
    _viewFrame = CGRectMake(0, 0, screenWidth, 216);
}

- (void)dealloc;
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
