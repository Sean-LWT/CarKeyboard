# CarKeyboard
## _中国车牌号输入框_

<img src="https://github.com/Sean-LWT/CarKeyboard/blob/master/V1.png" width="100px">
<img src="https://github.com/Sean-LWT/CarKeyboard/blob/master/V2.png" width="100px">
<img src="https://github.com/Sean-LWT/CarKeyboard/blob/master/H1.png" width="100px">
<img src="https://github.com/Sean-LWT/CarKeyboard/blob/master/H2.png" width="100px">

## 使用

创建时传入父UITextField
```oc
+ (instancetype)shareWithTextInput:(UITextField* )inputView;
```
例如
```oc
_textField = [UITextField new];
[self.view addSubview:_textField];
_textField.inputView = [WTCarKeyboard shareWithTextInput:_textField];
```

## 更新

# 2017-02-23
· 优化了删除按钮显示问题
· 优化了打开键盘的界面卡顿问题

# 2022-02-25
· 优化代码、简化使用方法

## License

MIT
