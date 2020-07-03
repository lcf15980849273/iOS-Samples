//
//  HQLPasswordsView.m
//  XuZhouSS
//
//  Created by ToninTech on 2017/7/18.
//  Copyright © 2017年 ToninTech. All rights reserved.
//

#import "HQLPasswordsView.h"
#import "HQLConst.h"

#import <Masonry.h>
#import <YYKit.h>

static const NSUInteger KPasswordNumber = 6;

@interface HQLPasswordsView ()<UITextFieldDelegate>

@property (nonatomic, strong) UILabel  *titleLabel;

@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *forgetPwdButton;

@property (nonatomic, strong) UIImageView *rotationImageView;
@property (nonatomic, strong) UILabel *loadingTextLabel;

@property (nonatomic, strong) NSMutableArray *dotsImgArray;

@end

@implementation HQLPasswordsView

#pragma mark - Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.closeButton];
    [self addSubview:self.titleLabel];
    [self addSubview:self.pwdTextField];
    [self addSubview:self.forgetPwdButton];
    [self addSubview:self.rotationImageView];
    [self addSubview:self.loadingTextLabel];
    
    // 设置【分割线】
    UIView *line = [UIView new];
    // #C9CBCC
    line.backgroundColor = COLOR_RGB(201, 203, 204);
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(HQLPasswordViewTitleHeight);
        make.left.and.right.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    
    // 设置占位输入框背景
    UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password_textField"]];
    imgView.frame = [self textFieldRect];
    [self addSubview:imgView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 设置【标题】的坐标
    self.titleLabel.centerX = kScreenWidth * 0.5;
    self.titleLabel.centerY = HQLPasswordViewTitleHeight * 0.5;
    
    // 设置【关闭按钮】的坐标
    self.closeButton.top = (HQLPasswordViewTitleHeight - HQLPasswordViewCloseButtonWH) / 2;
    self.closeButton.left   = HQLPasswordViewCloseButtonMarginLeft;
    self.closeButton.width  = HQLPasswordViewCloseButtonWH;
    self.closeButton.height = HQLPasswordViewCloseButtonWH;

    // 设置【忘记密码】按钮的坐标
    self.forgetPwdButton.left = kScreenWidth - (kScreenWidth - HQLPasswordViewTextFieldWidth) * 0.5 - self.forgetPwdButton.width;
    self.forgetPwdButton.top  = HQLPasswordViewTitleHeight + HQLPasswordViewTextFieldMarginTop + HQLPasswordViewTextFieldHeight + HQLPasswordViewForgetPWDButtonMarginTop;
    
    // 调整旋转图片布局
    self.rotationImageView.centerX = self.centerX;
    self.rotationImageView.centerY = self.height * 0.5;
    
    // 调整提示文本布局
    self.loadingTextLabel.centerX = self.centerX;
    self.loadingTextLabel.top = CGRectGetMaxY(self.rotationImageView.frame) + 20;
}


#pragma mark - Custom Accessors

- (void)setTitle:(NSString *)title {
    _title = [title copy];
    self.titleLabel.text = title;
    [self.titleLabel sizeToFit];
}

- (void)setLoadingText:(NSString *)loadingText {
    _loadingText = [loadingText copy];
    self.loadingTextLabel.text = loadingText;
    [self.loadingTextLabel sizeToFit];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"输入密码";
        _titleLabel.font = FONT(18);
//        _titleLabel.textColor = COLOR_RGB(102, 102, 102);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIButton *)closeButton {
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"password_back"];
        [_closeButton setBackgroundImage:image
                                forState:UIControlStateNormal];
        [_closeButton addTarget:self
                         action:@selector(closeButtonDidClicked:)
               forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

- (UIButton *)forgetPwdButton {
    if (!_forgetPwdButton) {
        _forgetPwdButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetPwdButton setTitle:@"忘记密码？" forState:UIControlStateNormal];
        [_forgetPwdButton setTitleColor:COLOR_RGB(47, 112, 225)
                               forState:UIControlStateNormal];
        _forgetPwdButton.titleLabel.font = FONT(14);
        [_forgetPwdButton sizeToFit];
        [_forgetPwdButton addTarget:self
                             action:@selector(forgetPwdButtonDidClicked:)
                   forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetPwdButton;
}

- (UITextField *)pwdTextField {
    if (!_pwdTextField) {
        _pwdTextField = [[UITextField alloc] init];
        _pwdTextField.frame = [self textFieldRect];
        _pwdTextField.backgroundColor = [UIColor clearColor];
        _pwdTextField.textColor = [UIColor clearColor];
        _pwdTextField.tintColor = [UIColor clearColor];
        _pwdTextField.keyboardType = UIKeyboardTypeNumberPad;
        _pwdTextField.delegate = self;
    }
    return _pwdTextField;
}

- (UIImageView *)rotationImageView {
    if (!_rotationImageView) {
        UIImage *image = [UIImage imageNamed:@"password_loading_a"];
        _rotationImageView = [[UIImageView alloc] initWithImage:image];
        _rotationImageView.hidden = YES;
    }
    return _rotationImageView;
}

- (UIView *)loadingTextLabel {
    if (!_loadingTextLabel) {
        _loadingTextLabel = [[UILabel alloc] init];
        _loadingTextLabel.text = @"正在确认密码...";
        _loadingTextLabel.textColor = [UIColor darkGrayColor];
        _loadingTextLabel.font = FONT(13);
        _loadingTextLabel.textAlignment = NSTextAlignmentCenter;
        _loadingTextLabel.hidden = YES;
    }
    return _loadingTextLabel;
}

- (NSMutableArray *)dotsImgArray {
    if (!_dotsImgArray) {
        _dotsImgArray = [NSMutableArray arrayWithCapacity:KPasswordNumber];
        for (int i = 0; i < KPasswordNumber; i++) {
            
            // textField 的 Rect
            CGFloat textFieldW = HQLPasswordViewTextFieldWidth;
            CGFloat textFieldH = HQLPasswordViewTextFieldHeight;
            CGFloat textFieldX = (kScreenWidth - textFieldW) * 0.5;
            CGFloat textFieldY = HQLPasswordViewTitleHeight + HQLPasswordViewTextFieldMarginTop;
            
            // 圆点 的 Rect
            CGFloat pointW = HQLPasswordViewPointnWH;
            CGFloat pointH = HQLPasswordViewPointnWH;
            CGFloat pointY = textFieldY + (textFieldH - pointH) * 0.5;
            // 一个格子的宽度
            CGFloat cellW = textFieldW / KPasswordNumber;
            CGFloat padding = (cellW - pointW) * 0.5;
            // 圆点的 X
            CGFloat pointX = textFieldX + (2 * i + 1) * padding + i * pointW;
            // 添加圆形图片
            UIImageView *dotsImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password_point"]];
            dotsImageView.contentMode = UIViewContentModeCenter;
            dotsImageView.frame = CGRectMake(pointX, pointY, pointW, pointH);
            // 先全部隐藏
            dotsImageView.hidden = YES;
            
            [self addSubview:dotsImageView];
            [_dotsImgArray addObject:dotsImageView];
        }
    }
    return _dotsImgArray;
}

#pragma mark - IBActions

- (void)closeButtonDidClicked:(id)sender {
    [self removePasswordView];
    if (self.closeBlock) {
        self.closeBlock();
    }
}

- (void)forgetPwdButtonDidClicked:(id)sender {
    [self removePasswordView];
    if (self.forgetPasswordBlock) {
        self.forgetPasswordBlock();
    }
}

#pragma mark - Public

//- (void)showInView:(UIView *)view {
//    [view addSubview:self];
//    // 输入框起始frame
//    self.backgroundView.frame = CGRectMake(0,
//                                           SCREEN_HEIGHT,
//                                           SCREEN_WIDTH,
//                                           460);
//
//    // 输入框弹出动画
//    [UIView animateWithDuration:HQLPasswordViewAnimationDuration
//                          delay:0
//                        options:UIViewAnimationOptionTransitionNone
//                     animations:^{
//                         self.backgroundView.top = (self.height - self.backgroundView.height);
//                         [self.pwdTextField becomeFirstResponder];
//                     } completion:nil];
//}

- (void)removePasswordView {
    [self.pwdTextField resignFirstResponder];
    [self clearUpPassword];
    [self removeFromSuperview];
}

- (void)requestComplete:(BOOL)state message:(NSString *)message {
    [self stopLoading];
    if (state) {
        // 请求成功
        self.loadingTextLabel.text = message;
        self.rotationImageView.image =
        [UIImage imageNamed:HQLPasswordViewSrcName(@"password_success")];
    } else {
        // 请求失败
        self.loadingTextLabel.text = message;
        self.rotationImageView.image =
        [UIImage imageNamed:HQLPasswordViewSrcName(@"password_error")];
    }
}

- (void)requestComplete:(BOOL)state {
    if (state) {
        [self requestComplete:state message:@"支付成功"];
    } else {
        [self requestComplete:state message:@"支付失败"];
    }
}

#pragma mark - Private

// 重置圆点
- (void)resetDotsWithLength:(NSUInteger)length {
    for (int i = 0; i < KPasswordNumber; i++) {
        if (length == 0 || i >= length) {
            ((UIImageView *)[self.dotsImgArray objectAtIndex:i]).hidden = YES;
        }else {
            ((UIImageView *)[self.dotsImgArray objectAtIndex:i]).hidden = NO;
        }
    }
}

// 开始旋转
- (void)startLoading {
    [self startRotation:self.rotationImageView];
    self.pwdTextField.userInteractionEnabled = NO;
    [self enableAllButton:NO];
}

- (void)enableAllButton:(BOOL)enable {
    self.closeButton.userInteractionEnabled     = enable;
    self.forgetPwdButton.userInteractionEnabled = enable;
}

// 结束旋转
- (void)stopLoading {
    [self stopRotation:self.rotationImageView];
    self.pwdTextField.userInteractionEnabled = YES;
    [self enableAllButton:YES];
}

- (void)startRotation:(UIView *)view {
    self.rotationImageView.hidden = NO;
    self.loadingTextLabel.hidden  = NO;
    self.rotationImageView.image = [UIImage imageNamed:@"password_loading_a"];
    self.loadingTextLabel.text = _loadingText;
    
    CABasicAnimation* rotationAnimation =
    [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 2.0;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)stopRotation:(UIView *)view {
    [view.layer removeAllAnimations];
}

// 清除密码
- (void)clearUpPassword {
    // 1.清空输入文本框密码
    self.pwdTextField.text = @"";
    // 2.清空黑色圆点
    [self resetDotsWithLength:0];
    // 3.隐藏加载图片和文字
    self.rotationImageView.hidden = YES;
    self.loadingTextLabel.hidden  = YES;
}

- (CGRect)textFieldRect {
    CGFloat textFieldW = HQLPasswordViewTextFieldWidth;
    CGFloat textFieldH = HQLPasswordViewTextFieldHeight;
    CGFloat textFieldX = (kScreenWidth - textFieldW) * 0.5;
    CGFloat textFieldY = HQLPasswordViewTitleHeight + HQLPasswordViewTextFieldMarginTop;
    return CGRectMake(textFieldX, textFieldY, textFieldW, textFieldH);
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    // 每次 TextField 开始编辑，都要清空密码
    [self clearUpPassword];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    NSUInteger numberLength = textField.text.length + string.length;
    if([string isEqualToString:@""]) {
        // 1.判断是不是删除键？
        [self resetDotsWithLength:numberLength - 1];
        return YES;
    } else if(numberLength >= KPasswordNumber) {
        // 2.判断此次输入数字的是不是第6个数字？
        [self resetDotsWithLength:numberLength];
        // 2.1 收起键盘
        [self.pwdTextField resignFirstResponder];
        // 2.2 发起请求 Block
        if (self.finishBlock) {
            [self startLoading];
            NSString *password =
            [textField.text stringByAppendingString:string];
            self.finishBlock(password);
        }
        return NO;
    } else {
        // 3.每次键入一个值，都要重设黑点
        [self resetDotsWithLength:numberLength];
        return YES;
    }
}

@end
