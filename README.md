# WTCarKeyboard
车牌号自定义键盘输入

使用方法

    UITextField* textField = [UITextField new];
    [self.view addSubview:textField];
    textField.frame = CGRectMake(100, 100, 100, 40);
    textField.layer.borderColor = [UIColor blackColor].CGColor;
    textField.layer.borderWidth = 1;
    
    WTCarKeyboard* carKeyboard = [WTCarKeyboard new];
    carKeyboard.delegate = self;
    carKeyboard.inputBlock = ^(NSString* textStr)
    {
        NSLog(@"%@",textStr);
    };
    textField.inputView = carKeyboard;

2017-02-23
·优化了删除按钮显示问题；
·优化了打开键盘的界面卡顿问题；
