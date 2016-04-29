//
//  ICarouselImages.m
//  美食类
//
//  Created by 夏浩文 on 16/4/25.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "ICarouselImages.h"
#import "ICarousellData.h"
#import "DaydayCookDescription.h"
#import <AFNetworking.h>
@interface ICarouselImages () <BHInfiniteScrollViewDelegate>
{
    NSMutableArray *imagesArray;
    NSMutableArray *titlesArray;
    NSMutableArray *bookid;
}
@end


@implementation ICarouselImages




- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [self GetDataWithFrame:frame];
            
        });
        
        
    }
    return self;
}


- (void)GetDataWithFrame:(CGRect)frame {
    
    imagesArray = [NSMutableArray array];
    titlesArray = [NSMutableArray array];
    bookid      = [NSMutableArray array];
    
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    [manager POST:@"http://api.daydaycook.com.cn/daydaycook/server/ad/listAds.do" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject[@"msg"] isEqualToString:@"成功"]) {
            NSArray *data = responseObject[@"data"];
            for (NSDictionary *dic in data) {
                ICarousellData *model = [ICarousellData modelObjectWithDictionary:dic];
                [imagesArray addObject:model.path];
                [titlesArray addObject:model.title];
                [bookid addObject:model.url];
                NSLog(@"%@",model.url);
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
               
                _ica = [BHInfiniteScrollView infiniteScrollViewWithFrame:frame Delegate:self ImagesArray:imagesArray PlageHolderImage:[UIImage imageNamed:@"GGIcon"]];
                
//                ica.pageViewContentMode = UIViewContentModeScaleAspectFit;
                [self addSubview:_ica];
                
            });
        }
        
        
    } failure:nil];
    
}


-(void)infiniteScrollView:(BHInfiniteScrollView *)infiniteScrollView didSelectItemAtIndex:(NSInteger)index
{
    
    DaydayCookDescription *vc = [[DaydayCookDescription alloc]init];
    
    vc.BookID = [bookid[index] integerValue];
    
    vc.isNavigation = YES;
    
    [[self viewController].navigationController pushViewController:vc animated:YES];
}

//从uiview中找到navigation
- (UIViewController*)viewController {
    
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
