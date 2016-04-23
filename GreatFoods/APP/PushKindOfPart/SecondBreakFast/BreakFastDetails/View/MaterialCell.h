//
//  MaterialCell.h
//  早餐
//
//  Created by lanou on 16/4/20.
//  Copyright © 2016年 WYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MaterialCell : UITableViewCell


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *constantheight;

@property(nonatomic,retain) NSArray *abc;

//@property (nonatomic,copy) void (^reload)();

@end
