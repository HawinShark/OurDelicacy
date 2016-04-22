//
//  UIImage+Extended.h
//  闭眼
//
//  Created by 夏浩文 on 16/4/11.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extended)

+ (UIImage *)decompressedImageFromImageString:(NSString *)filename;

+ (UIImage *)RecompressedImageFromImage:(UIImage *)file;

@end
