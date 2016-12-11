# WTCarKeyboard
车牌号自定义键盘输入

使用方法

    UITextField* textField = [UITextField new];
    [self.view addSubview:textField];
    textField.frame = CGRectMake(100, 100, 100, 40);
    textField.layer.borderColor = [UIColor blackColor].CGColor;
    textField.layer.borderWidth = 1;
    
    WTCarKeyboard* carKeyboard = [WTCarKeyboard new];
    carKeyboard.delegate = self; //代理
    carKeyboard.inputBlock = ^(NSString* textStr) //block
    {
         NSLog(@"%@",textStr);
    };
    textField.inputView = carKeyboard;
