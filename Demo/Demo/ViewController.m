//
//  ViewController.m
//  Demo
//
//  Created by Sean on 2016/12/7.
//  Copyright © 2016年 Sean. All rights reserved.
//

#import "ViewController.h"
#import "WTCarKeyboard.h"

@interface ViewController ()<WTCarKeyboardDelegate>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UITextField* textField = [UITextField new];
    [self.view addSubview:textField];
    textField.frame = CGRectMake(100, 100, 100, 40);
    textField.layer.borderColor = [UIColor blackColor].CGColor;
    textField.layer.borderWidth = 1;
    
    WTCarKeyboard* carKeyboard = [WTCarKeyboard new];
//    carKeyboard.delegate = self;
//    carKeyboard.inputBlock = ^(NSString* textStr)
//    {
//        NSLog(@"%@",textStr);
//    };
    textField.inputView = carKeyboard;
}

- (void)carKeyboard:(WTCarKeyboard *)carKeyboard didChangeWithText:(NSString *)textStr;
{
    NSLog(@"%@",textStr);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
{
    [self.view endEditing:YES];
}

@end
