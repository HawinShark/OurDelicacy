//
//  CustomSearchBar.h
//  CustomSearchBarDemo
//
//  Created by 夏浩文 on 16/3/8.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

//点击搜索按钮，调用block，用于外界做赋值、加载数据等操作
typedef void(^ReturnBlock)(NSString *str);
typedef void (^ReturnClick)(NSString *str);

@interface CustomSearchBar : UIView

@property (nonatomic, strong) ReturnBlock block;
@property (nonatomic, strong) ReturnClick click;

- (void)getBlockFromOutSpace:(ReturnBlock)block;

- (void)getClickFromReturn:(ReturnClick)click;

@end
