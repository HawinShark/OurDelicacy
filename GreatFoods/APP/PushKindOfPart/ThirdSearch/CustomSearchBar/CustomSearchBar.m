//
//  CustomSearchBar.m
//  CustomSearchBarDemo
//
//  Created by 夏浩文 on 16/3/8.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "CustomSearchBar.h"
#import "UIView+ModifyAttributeValue.h"
#define CancleButtonWidth 50 //取消按钮的宽度
#define SearchImageViewSize 24 //搜索图标的尺寸（宽与高相等）

@interface CustomSearchBar ()<UITextFieldDelegate>
{
    UIView *_bgView;//背景视图
    UITextField *_textField;//输入框
    UIImageView *_searchImageView;//放大镜图标
    UIButton *_cancleButton;//取消按钮
    
    NSString *currentWords;//记录输入的单词
}

@end

@implementation CustomSearchBar



- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        currentWords = @"";
        
        //背景视图
        _bgView = [[UIView alloc] initWithFrame:self.bounds];
        //设置圆角效果
        _bgView.layer.cornerRadius = 5;
        _bgView.layer.masksToBounds = YES;
        _bgView.backgroundColor = [UIColor colorWithWhite:0.874 alpha:0.800];
        [self addSubview:_bgView];
        
        //取消按钮
        _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleButton.frame = CGRectMake(CGRectGetWidth(self.frame) - CancleButtonWidth, 0, CancleButtonWidth, CGRectGetHeight(self.frame));
        [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleButton setTitleColor:[UIColor colorWithWhite:0.8 alpha:1.000] forState:UIControlStateNormal];
        _cancleButton.titleLabel.font = [UIFont systemFontOfSize:13];
        [_cancleButton addTarget:self action:@selector(handleButton:) forControlEvents:UIControlEventTouchDown];
        //textField未编辑状态，“取消”按纽不显示
        _cancleButton.hidden = YES;
        [self addSubview:_cancleButton];
        
        //输入框
        _textField = [[UITextField alloc] initWithFrame:CGRectMake(5, 0, CGRectGetWidth(_bgView.frame) - 10, CGRectGetHeight(_bgView.frame))];
        _textField.font = [UIFont systemFontOfSize:13];
        [_textField addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
        _textField.delegate = self;
        _textField.returnKeyType = UIReturnKeySearch;
        //为textField设置属性占位符
        _textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入关键字" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithWhite:0.335 alpha:1.000]}];
        [_bgView addSubview:_textField];
        
        //放大镜图标imageView
        _searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetWidth(_bgView.frame) - SearchImageViewSize - 5, _bgView.center.y - SearchImageViewSize / 2, SearchImageViewSize, SearchImageViewSize)];
        _searchImageView.image = [UIImage imageNamed:@"main_nearby_image"];
        [_bgView addSubview:_searchImageView];
    }
    return self;
}

#pragma mark - handle action

- (void)textFieldChanged:(UITextField *)textField {
    //当输入框的字符数大于零时，隐藏放大镜图标
    _searchImageView.hidden = textField.text.length > 0 ? YES : NO;
}

//取消按钮触发事件
- (void)handleButton:(UIButton *)button {
    [_textField resignFirstResponder];
    //清除输入框中的字符串
    _textField.text = @"";
    currentWords = @"";
    _cancleButton.hidden = YES;
    _searchImageView.hidden = NO;
    //隐藏“取消”按钮伴随的动画效果
    [UIView animateWithDuration:0.5 animations:^{
        //方法setSize:和setOrigin:是UIView分类UIView+ModifyAttributeValue中的方法
        [_bgView setSize:CGSizeMake(CGRectGetWidth(_bgView.frame) + CancleButtonWidth, CGRectGetHeight(_bgView.frame))];
        [_textField setSize:CGSizeMake(CGRectGetWidth(_textField.frame) + CancleButtonWidth, CGRectGetHeight(_textField.frame))];
        [_searchImageView setOrigin:CGPointMake(_searchImageView.frame.origin.x + CancleButtonWidth, _searchImageView.frame.origin.y)];
    }];
}


-(void)getBlockFromOutSpace:(ReturnBlock)block{
    self.block = block;
}
-(void)getClickFromReturn:(ReturnClick)click{
    self.click = click;
}

#pragma mark - UITextFieldDelegate

//输入框开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    //显示“取消”按钮伴随的动画效果
    [UIView animateWithDuration:0.5 animations:^{
        [_bgView setSize:CGSizeMake(CGRectGetWidth(_bgView.frame) - CancleButtonWidth, CGRectGetHeight(_bgView.frame))];
        [_textField setSize:CGSizeMake(CGRectGetWidth(_textField.frame) - CancleButtonWidth, CGRectGetHeight(_textField.frame))];
        [_searchImageView setOrigin:CGPointMake(_searchImageView.frame.origin.x - CancleButtonWidth, _searchImageView.frame.origin.y)];
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _cancleButton.hidden = NO;
    });
    
    
    NSLog(@"%@",textField.text);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    self.click(textField.text);
    
    //归位
    [_textField resignFirstResponder];
    _cancleButton.hidden = YES;
    _searchImageView.hidden = NO;
    [UIView animateWithDuration:0.5 animations:^{
        //方法setSize:和setOrigin:是UIView分类UIView+ModifyAttributeValue中的方法
        [_bgView setSize:CGSizeMake(CGRectGetWidth(_bgView.frame) + CancleButtonWidth, CGRectGetHeight(_bgView.frame))];
        [_textField setSize:CGSizeMake(CGRectGetWidth(_textField.frame) + CancleButtonWidth, CGRectGetHeight(_textField.frame))];
        [_searchImageView setOrigin:CGPointMake(_searchImageView.frame.origin.x + CancleButtonWidth, _searchImageView.frame.origin.y)];
    }];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    if (range.length == 0) {    //添加
        currentWords = [currentWords stringByAppendingString:string];
        self.block(currentWords);
    }
    
//    NSLog(@"leng = %lu",(unsigned long)range.length);
//    NSLog(@"locat = %lu",(unsigned long)range.location);
    if (range.length == 1) {      // == 1 减少
        if (currentWords.length == 0) {
            currentWords = @"";
        }
        else{
        currentWords = [currentWords substringToIndex:currentWords.length - range.length];
            self.block(currentWords);
        }
    }
    
    return YES;
}

@end
