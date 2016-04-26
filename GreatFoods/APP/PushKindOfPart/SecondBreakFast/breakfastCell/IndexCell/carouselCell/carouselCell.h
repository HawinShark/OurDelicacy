//
//  carouselCell.h
//  美食类
//
//  Created by lanou on 16/4/23.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LunBo <NSObject>

- (void)infiniteScrollViewdidSelectItemAtIndex:(NSInteger)index;

@end



@interface carouselCell : UITableViewCell

@property(nonatomic,retain) NSArray *titles;



@property(nonatomic,assign) id<LunBo>delegate;



-(void)setCarouselArray:(NSArray *)carouselArray;

@end
