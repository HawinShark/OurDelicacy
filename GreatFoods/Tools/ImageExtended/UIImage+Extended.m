//
//  UIImage+Extended.m
//  闭眼
//
//  Created by 夏浩文 on 16/4/11.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "UIImage+Extended.h"

@implementation UIImage (Extended)

+(UIImage *)decompressedImageFromImageString:(NSString *)filename{
    
    UIImage *image = [UIImage imageNamed:filename];
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0);
    [image drawAtPoint:CGPointZero];
    
    UIImage *decompressedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return decompressedImage;
}

+(UIImage *)RecompressedImageFromImage:(UIImage *)file
{
    UIImage *image = [file copy];
    UIGraphicsBeginImageContextWithOptions(image.size, YES, 0);
    [image drawAtPoint:CGPointZero];
    
    UIImage *decompressedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return decompressedImage;
}

@end
