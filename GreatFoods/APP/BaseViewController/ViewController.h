//
//  ViewController.h
//  美食类
//
//  Created by 夏浩文 on 16/4/18.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModels.h"
@interface ViewController : UIViewController
{
    NSInteger RefreshCurrentPage;//DAYDAYCOOK下拉刷新第几页
}

/* dayday的数据 */
@property (nonatomic, retain) NSMutableArray *DDdataArray;



@end
