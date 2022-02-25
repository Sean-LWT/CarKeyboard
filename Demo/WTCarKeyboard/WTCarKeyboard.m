//
//  WTCarKeyboard.m
//
//  Created by Sean on 2016/12/7.
//  Copyright © 2016年 Sean. All rights reserved.
//

#import "WTCarKeyboard.h"
#import "WTCarKeyboardModel.h"

@interface WTCarKeyboard ()<WTCarKeyboardModelDelegate>

/// 输入框
@property (nonatomic, weak) UITextField* inputView;

/// 省简称数据
@property (nonatomic, copy) NSArray* carTypeArr;
/// 字母和数字界面数据
@property (nonatomic, copy) NSArray* numTypeArr;

/// 选择省简称界面
@property (nonatomic, strong) UIView* carInputView;
/// 选择字母和数字界面
@property (nonatomic, strong) UIView* numInputView;
/// 选项背景图片
@property (nonatomic, copy) UIImage* itemWhiteBackgroundImage;

/// 显示控制
@property (nonatomic, strong) WTCarKeyboardModel* model;

@end

@implementation WTCarKeyboard

#pragma mark - 初始化

+ (instancetype)shareWithTextInput:(UITextField* )inputView {
    return [[self alloc] initWithTextInput:inputView];
}

- (instancetype)initWithTextInput:(UITextField* )inputView {
    self = [super init];
    if (self) {
        self.bounds = _model.superViewFrame;
        inputView.inputView = self;
        _inputView = inputView;
        // 设置默认数据
        _carTypeArr = @[@"京",@"沪",@"津",@"渝",@"冀",@"晋",@"蒙",@"辽",@"吉",@"黑",@"苏",@"浙",@"皖",@"闽",@"赣",@"鲁",@"豫",@"鄂",@"湘",@"粤",@"桂",@"琼",@"川",@"贵",@"云",@"藏",@"陕",@"甘",@"青",@"宁",@"新",@"台",@"澳",@"港"];
        _numTypeArr = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"0",@"Q",@"W",@"E",@"R",@"T",@"Y",@"U",@"I",@"O",@"P",@"A",@"S",@"D",@"F",@"G",@"H",@"J",@"K",@"L",@"Z",@"X",@"C",@"V",@"B",@"N",@"M"];
        // 显示控制
        _model = [WTCarKeyboardModel new];
        _model.delegate = self;
        // 设置UI
        self.itemWhiteBackgroundImage = [self createWhiteBackgroundImage];
        [self setInputView];
    }
    return self;
}

#pragma mark - 设置UI

/// 创建白色背景图片
- (UIImage* )createWhiteBackgroundImage {
    UIView* view = [UIView new];
    view.frame = CGRectMake(0, 0, 50, 50);
    view.layer.backgroundColor = [UIColor whiteColor].CGColor;
    view.layer.cornerRadius = 6;
    view.layer.masksToBounds = YES;
    // 绘制
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, YES, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:209/255.0 green:213/255.0 blue:218/255.0 alpha:1].CGColor);
    CGContextFillRect(context, view.bounds);
    [view.layer renderInContext:context];
    UIImage* image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(6, 6, 6, 6) resizingMode:UIImageResizingModeStretch];;
}

/// 创建界面
- (void)setInputView {
    self.bounds = _model.superViewFrame;
    
    // 创建输入子界面
    _carInputView = [UIView new];
    _numInputView = [UIView new];
    [self addSubview:_carInputView];
    [self addSubview:_numInputView];
    _carInputView.frame = _model.viewFrame;
    _numInputView.frame = _model.viewFrame;
    _carInputView.backgroundColor = [UIColor colorWithRed:209/255.0 green:213/255.0 blue:218/255.0 alpha:1];
    _numInputView.backgroundColor = [UIColor colorWithRed:209/255.0 green:213/255.0 blue:218/255.0 alpha:1];
    
    // 排列省简称输入按钮位置
    [self setCarinputViewBtn];
    // 排列字母和数字输入按钮位置
    [self setNumInputViewBtn];
    
    // 判断两种类型键盘hiden
    [self setKeyboardHidden];
}
/// 排列省简称输入按钮位置
- (void)setCarinputViewBtn {
    for (int i = 0; i<_carTypeArr.count; i++) {
        UIButton* item = [UIButton buttonWithType:UIButtonTypeCustom];
        [_carInputView addSubview:item];
        [item setBackgroundImage:self.itemWhiteBackgroundImage forState:UIControlStateNormal];
        [item setTitle:_carTypeArr[i] forState:UIControlStateNormal];
        [item setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        item.titleLabel.font = [UIFont systemFontOfSize:15];
        item.accessibilityIdentifier = _carTypeArr[i];
        item.tag = i+10;
        // 位置排列
        if (i < 20) {
            int horizontal = i%10;
            int vertical = i/10;
            [self setBtnFrameWithBtn:item horizontal:horizontal vertical:vertical];
        } else if (i >= 20 && i < 28) {
            int horizontal = i%10+1;
            int vertical = 2;
            [self setBtnFrameWithBtn:item horizontal:horizontal vertical:vertical];
        } else {
            int horizontal = (i+2)%10+2;
            int vertical = 3;
            [self setBtnFrameWithBtn:item horizontal:horizontal vertical:vertical];
        }
        [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self setChangeAndDeleteBtnInView:_carInputView btnTitle:@"123" tag:8];
}
/// 排列字母和数字输入按钮位置
- (void)setNumInputViewBtn {
    for (int i = 0; i<_numTypeArr.count; i++) {
        UIButton* item = [UIButton buttonWithType:UIButtonTypeCustom];
        [_numInputView addSubview:item];
        [item setBackgroundImage:self.itemWhiteBackgroundImage forState:UIControlStateNormal];
        [item setTitle:_numTypeArr[i] forState:UIControlStateNormal];
        [item setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        item.titleLabel.font = [UIFont systemFontOfSize:15];
        item.accessibilityIdentifier = _numTypeArr[i];
        item.tag = i+100;
        // 位置排列
        if (i < 30) {
            int horizontal = i%10;
            int vertical = i/10;
            [self setBtnFrameWithBtn:item horizontal:horizontal vertical:vertical];
        } else {
            int horizontal = i%10+2;
            int vertical = 3;
            [self setBtnFrameWithBtn:item horizontal:horizontal vertical:vertical];
        }
        [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    [self setChangeAndDeleteBtnInView:_numInputView btnTitle:@"省" tag:98];
}
/// 设置按钮位置
- (void)setBtnFrameWithBtn:(UIButton* )btn horizontal:(int)horizontal vertical:(int)vertical {
    btn.frame = CGRectMake((_model.btnWidthSpace+_model.btnWidth)*horizontal+_model.btnWidthSpace, (_model.btnHeightSpace+_model.btnHeight)*vertical+_model.btnHeightSpace, _model.btnWidth, _model.btnHeight);
}
/// 添加切换和删除按钮
- (void)setChangeAndDeleteBtnInView:(UIView* )inView btnTitle:(NSString* )titleStr tag:(NSInteger)tag {
    // 切换按钮设置
    UIButton* changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [inView addSubview:changeBtn];
    [changeBtn addTarget:self action:@selector(changeClick:) forControlEvents:UIControlEventTouchUpInside];
    [changeBtn setTitle:titleStr forState:UIControlStateNormal];
    [changeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    changeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    changeBtn.frame = CGRectMake(_model.btnWidthSpace, (_model.btnHeightSpace+_model.btnHeight)*3+_model.btnHeightSpace, _model.btnWidth+_model.btnWidthSpace, _model.btnHeight);
    [changeBtn setBackgroundImage:self.itemWhiteBackgroundImage forState:UIControlStateNormal];
    changeBtn.tag = tag;
    
    // 删除按钮
    UIButton* deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [inView addSubview:deleteBtn];
    [deleteBtn addTarget:self action:@selector(deleteClick:) forControlEvents:UIControlEventTouchUpInside];
    deleteBtn.frame = CGRectMake((_model.btnWidthSpace+_model.btnWidth)*9, (_model.btnHeightSpace+_model.btnHeight)*3+_model.btnHeightSpace, _model.btnWidth+_model.btnWidthSpace, _model.btnHeight);
    [deleteBtn setBackgroundImage:self.itemWhiteBackgroundImage forState:UIControlStateNormal];
    [deleteBtn setImage:[UIImage imageNamed:@"WTCarKeyboardBack"] forState:UIControlStateNormal];
    
    CGFloat deleteBtnWidth = 18;
    CGFloat deleteBtnHeight = 34*18/45.0;
    deleteBtn.imageEdgeInsets = UIEdgeInsetsMake((_model.btnHeight-deleteBtnHeight)/2.0, (_model.btnWidth+_model.btnWidthSpace-deleteBtnWidth)/2.0, (_model.btnHeight-deleteBtnHeight)/2.0, (_model.btnWidth+_model.btnWidthSpace-deleteBtnWidth)/2.0); //删除按钮大小45*34
    deleteBtn.tag = tag+1;
}
/// 判断两种类型键盘hiden
- (void)setKeyboardHidden {
    if (_inputView.hasText) {
        _carInputView.hidden = YES;
        _numInputView.hidden = NO;
    } else {
        _carInputView.hidden = NO;
        _numInputView.hidden = YES;
    }
}

#pragma mark - 代理

- (void)orientationDidChangeWithCarKeyboardModel:(WTCarKeyboardModel *)carKeyboardModel landscape:(BOOL)isLandscape {
    self.bounds = _model.superViewFrame;
    _carInputView.frame = _model.viewFrame;
    _numInputView.frame = _model.viewFrame;
    for (int i = 0; i<_carTypeArr.count; i++) {
        UIButton* btn = [_carInputView viewWithTag:i+10];
        // 位置排列
        if (i < 20) {
            int horizontal = i%10;
            int vertical = i/10;
            [self setBtnFrameWithBtn:btn horizontal:horizontal vertical:vertical];
        } else if (i >= 20 && i < 28) {
            int horizontal = i%10+1;
            int vertical = 2;
            [self setBtnFrameWithBtn:btn horizontal:horizontal vertical:vertical];
        } else {
            int horizontal = (i+2)%10+2;
            int vertical = 3;
            [self setBtnFrameWithBtn:btn horizontal:horizontal vertical:vertical];
        }
    }
    for (int i = 0; i<_numTypeArr.count; i++) {
        UIButton* btn = [_numInputView viewWithTag:i+100];
        // 位置排列
        if (i < 30) {
            int horizontal = i%10;
            int vertical = i/10;
            [self setBtnFrameWithBtn:btn horizontal:horizontal vertical:vertical];
        } else {
            int horizontal = i%10+2;
            int vertical = 3;
            [self setBtnFrameWithBtn:btn horizontal:horizontal vertical:vertical];
        }
    }
    // 设置切换和删除按钮位置
    UIButton* car_deleteBtn = [_carInputView viewWithTag:9];
    car_deleteBtn.frame = CGRectMake((_model.btnWidthSpace+_model.btnWidth)*9, (_model.btnHeightSpace+_model.btnHeight)*3+_model.btnHeightSpace, _model.btnWidth+_model.btnWidthSpace, _model.btnHeight);
    UIButton* car_changeBtn = [_carInputView viewWithTag:8];
    car_changeBtn.frame = CGRectMake(_model.btnWidthSpace, (_model.btnHeightSpace+_model.btnHeight)*3+_model.btnHeightSpace, _model.btnWidth+_model.btnWidthSpace, _model.btnHeight);
    
    UIButton* num_deleteBtn = [_numInputView viewWithTag:99];
    num_deleteBtn.frame = CGRectMake((_model.btnWidthSpace+_model.btnWidth)*9, (_model.btnHeightSpace+_model.btnHeight)*3+_model.btnHeightSpace, _model.btnWidth+_model.btnWidthSpace, _model.btnHeight);
    UIButton* num_changeBtn = [_numInputView viewWithTag:98];
    num_changeBtn.frame = CGRectMake(_model.btnWidthSpace, (_model.btnHeightSpace+_model.btnHeight)*3+_model.btnHeightSpace, _model.btnWidth+_model.btnWidthSpace, _model.btnHeight);
    
    CGFloat deleteBtnWidth = 18;
    CGFloat deleteBtnHeight = 34*18/45.0;
    num_deleteBtn.imageEdgeInsets = UIEdgeInsetsMake((_model.btnHeight-deleteBtnHeight)/2.0, (_model.btnWidth+_model.btnWidthSpace-deleteBtnWidth)/2.0, (_model.btnHeight-deleteBtnHeight)/2.0, (_model.btnWidth+_model.btnWidthSpace-deleteBtnWidth)/2.0);
    car_deleteBtn.imageEdgeInsets = UIEdgeInsetsMake((_model.btnHeight-deleteBtnHeight)/2.0, (_model.btnWidth+_model.btnWidthSpace-deleteBtnWidth)/2.0, (_model.btnHeight-deleteBtnHeight)/2.0, (_model.btnWidth+_model.btnWidthSpace-deleteBtnWidth)/2.0);
}

#pragma mark - 点击事件

/// 中间内容选择按钮
- (void)itemClick:(UIButton* )item {
    [_inputView insertText:item.accessibilityIdentifier];

    if (item.tag < 100 && _inputView.text.length) {
        //默认输入省简称跳转输入数字字母
        _numInputView.hidden = NO;
        _carInputView.hidden = YES;
    }
}
/// 转换界面点击事件
- (void)changeClick:(UIButton* )item {
    _carInputView.hidden = !_carInputView.hidden;
    _numInputView.hidden = !_numInputView.hidden;
}
/// 删除按钮
- (void)deleteClick:(UIButton* )item {
    [_inputView deleteBackward];
    if (_inputView.text.length == 0) {
        //默认无任何输入时显示省简称选择界面
        _carInputView.hidden = NO;
        _numInputView.hidden = YES;
    }
}

@end
