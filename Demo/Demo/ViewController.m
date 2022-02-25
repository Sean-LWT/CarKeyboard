//
//  ViewController.m
//  Demo
//
//  Created by Sean on 2016/12/7.
//  Copyright © 2016年 Sean. All rights reserved.
//

#import "ViewController.h"
#import "WTCarKeyboard.h"

@interface ViewController ()

@property (nonatomic, strong) UITextField* textField;

@end

@implementation ViewController

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // 示例
    _textField = [UITextField new];
    [self.view addSubview:_textField];
    _textField.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 6, 1)];
    _textField.rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 6, 1)];
    _textField.leftViewMode = UITextFieldViewModeAlways;
    _textField.rightViewMode = UITextFieldViewModeAlways;
    _textField.layer.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.5].CGColor;
    _textField.layer.cornerRadius = 4;
    _textField.layer.masksToBounds = YES;
    _textField.inputView = [WTCarKeyboard shareWithTextInput:_textField];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChangeNotification) name:UITextFieldTextDidChangeNotification object:_textField];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    switch ([UIDevice currentDevice].orientation) {
        case UIDeviceOrientationLandscapeLeft:case UIDeviceOrientationLandscapeRight:
        {
            // 设置横屏
            _textField.frame = CGRectMake((self.view.bounds.size.width-130)/2.0, 30, 130, 40);
        }
            break;
        case UIDeviceOrientationPortrait:
        {
            // 设置竖屏
            _textField.frame = CGRectMake((self.view.bounds.size.width-130)/2.0, 150, 130, 40);
        }
            break;
        default:
        {
            ;
        }
            break;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)textDidChangeNotification {
    NSLog(@"%@", _textField.text);
}

@end
