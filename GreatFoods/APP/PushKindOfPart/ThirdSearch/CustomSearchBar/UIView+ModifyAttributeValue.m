//
//  UIView+ModifyAttributeValue.m
//  CustomSearchBarDemo
//
//  Created by 王春平 on 16/3/8.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "UIView+ModifyAttributeValue.h"

@implementation UIView (ModifyAttributeValue)

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

@end
