//
//  GuideViewController.m
//  美食类
//
//  Created by 夏浩文 on 16/4/28.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "GuideViewController.h"

#import <UIView+SDAutoLayout.h>
@interface GuideViewController () <UIScrollViewDelegate>



@property (weak, nonatomic) IBOutlet UIScrollView *ScrollView;

@property (weak, nonatomic) IBOutlet UIPageControl *PageControl;

@property (weak, nonatomic) IBOutlet UIView *ICON;//头像

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ICONcenterY;


@property (weak, nonatomic) IBOutlet UILabel *Welcome;


/* 头像里轮播图*/
@property (nonatomic, retain) UIScrollView *iconScroll;


/* 夏浩文*/
@property (nonatomic, retain) UIView *Hawin;

/* 叶林曦*/
@property (nonatomic, retain) UIView *Lynsea;

/* 王业豪*/
@property (nonatomic, retain) UIView *Yehao;


@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    //添加我们仨 ->视图
    [self addOur];
    
    //添加我们仨 ->头像
    [self Iconscroll];


    
}


-(void)viewDidAppear:(BOOL)animated{
    if (screen_height < 491) {  //5以下
        _ICONcenterY.constant = - 0.05 * self.view.centerY;
    }
}






#pragma mark- 添加视图

- (void) addOur{
    
    _ICON.layer.borderWidth = 2.0f;
    _ICON.layer.borderColor = RGB(89, 61, 67).CGColor;
    
    _Hawin = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, screen_height)];
    
    _Lynsea = [[UIView alloc]initWithFrame:CGRectMake(screen_width, 0, screen_width, screen_height)];
    
    _Yehao = [[UIView alloc]initWithFrame:CGRectMake(screen_width * 2, 0, screen_width, screen_height)];
    
    if (_isMajor == YES) {
        //不创建
    }else{
        [self addButton]; //添加切换button
    }
    
    [self addImagesForUs];
    
    self.ScrollView.contentSize = CGSizeMake(screen_width * 3, screen_height);
    
    [self.ScrollView sd_addSubviews:@[_Hawin,_Lynsea,_Yehao]];
}


#pragma mark- 添加切换按钮

- (void) addButton{
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_Yehao addSubview:button];
    
    button.sd_layout.bottomSpaceToView(_Yehao,35).centerXEqualToView(_Yehao).heightIs(40).widthIs(165);
    
    [button setBackgroundColor:[UIColor clearColor]];
    
    [button setTitle:@"打开美食世界大门" forState:UIControlStateNormal];
    [button setTitleColor:RGB(89, 61, 67) forState:UIControlStateNormal];
    
    [button.layer setBorderWidth:2.0f];
    [button.layer setCornerRadius:4.0f];
    [button.layer setBorderColor:RGB(89, 61, 67).CGColor];
    
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    
    [button addTarget:self action:@selector(Exchange:) forControlEvents:UIControlEventTouchUpInside];
    
}


#pragma mark- 添加背景图

- (void) addImagesForUs{
    
    UIImageView * imageFirst = [UIImageView new];
    
    [_Hawin addSubview:imageFirst];
    
    imageFirst.sd_layout.leftSpaceToView(_Hawin,0).centerYEqualToView(_Hawin)
    .widthIs(screen_width);
    
    [imageFirst setImage:[UIImage imageNamed:@"Goodfood18"]];
    [imageFirst setContentMode:UIViewContentModeScaleAspectFill];
    
    
    //image two ...
    
    UIImageView * imageSecond = [UIImageView new];
    
    [_Lynsea addSubview:imageSecond];
    
    imageSecond.sd_layout.leftSpaceToView(_Lynsea,0)
    .widthIs(screen_width).centerYEqualToView(_Lynsea);
    
    [imageSecond setImage:[UIImage imageNamed:@"Goodfood20"]];
    [imageSecond setContentMode:UIViewContentModeScaleAspectFill];
    
    //image three...
    
    UIImageView * imageThird = [UIImageView new];
    
    [_Yehao addSubview:imageThird];
    
    imageThird.sd_layout.leftSpaceToView(_Yehao,0)
    .widthIs(screen_width).centerYEqualToView(_Yehao);
    
    [imageThird setImage:[UIImage imageNamed:@"Goodfood11"]];
    [imageThird setContentMode:UIViewContentModeScaleAspectFill];
    
    [self addDescriptionAndThird:imageThird];//添加人物描述
}


#pragma mark- 添加个人描述


- (void) addDescriptionAndThird:(UIImageView *)third {
    
    
    UILabel *HW = [UILabel new];
    UILabel *LX = [UILabel new];
    UILabel *YH = [UILabel new];
    
    [_Hawin addSubview:HW];
    [_Lynsea addSubview:LX];
    [_Yehao addSubview:YH];
    
    //
    HW.textColor = RGB(89, 61, 67);
    
    HW.sd_layout.
    topSpaceToView([_Hawin.subviews firstObject],15).
    centerYEqualToView(_Hawin).widthIs(screen_width);
    
    HW.textAlignment = NSTextAlignmentRight;
    
    [HW setText:@"【 一只年轻有为的程序员 】"];
    
    
    
    // person two..
    LX.textColor = RGB(89, 61, 67);
    
    LX.sd_layout.
    topSpaceToView([_Lynsea.subviews firstObject],15).
    centerYEqualToView(_Lynsea).widthIs(screen_width);
    
    LX.textAlignment = NSTextAlignmentRight;
    
    [LX setText:@"【 一只作死小能手 】"];
    
    
    
    // person 3..
    YH.textColor = RGB(89, 61, 67);
    
    
    YH.sd_layout.
    topSpaceToView(third,15).
    centerYEqualToView(_Yehao).widthIs(screen_width);
    
    YH.textAlignment = NSTextAlignmentRight;
    
    [YH setText:@"【 奋发上进的始作俑者 】"];
    
    
}



#pragma mark- Icon scroll

- (void) Iconscroll{
    
    _iconScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, 90, 90)];
    [_iconScroll setContentSize:CGSizeMake(90 * 3, 90)];
    
    
    #pragma mark- 坑爹的内阴影
/*
    //内阴影
    
    CAShapeLayer* shadowLayer = [CAShapeLayer layer];
    [shadowLayer setFrame:_iconScroll.bounds];
    
    // Standard shadow stuff
    [shadowLayer setShadowColor:[[UIColor colorWithWhite:0 alpha:1] CGColor]];
    [shadowLayer setShadowOffset:CGSizeMake(0.0f, 0.0f)];
    [shadowLayer setShadowOpacity:1.0f];
    [shadowLayer setShadowRadius:4];
    
    // Causes the inner region in this example to NOT be filled.
    [shadowLayer setFillRule:kCAFillRuleEvenOdd];
    
    // Create the larger rectangle path.
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectInset(_iconScroll.bounds, -45, -45));
    
    // Add the inner path so it's subtracted from the outer path.
    // someInnerPath could be a simple bounds rect, or maybe
    // a rounded one for some extra fanciness.
    CGPathRef someInnerPath = [UIBezierPath bezierPathWithRoundedRect:_iconScroll.bounds cornerRadius:45.0f].CGPath;
    CGPathAddPath(path, NULL, someInnerPath);
    CGPathCloseSubpath(path);
    
    [shadowLayer setPath:path];
    CGPathRelease(path);
    
    [[_iconScroll layer] addSublayer:shadowLayer];
    
    CAShapeLayer* maskLayer = [CAShapeLayer layer];
    [maskLayer setPath:someInnerPath];
    [shadowLayer setMask:maskLayer];
*/
    
    
    
    //我
    UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake(7.5, 7.5, 75, 75)];
    image1.image = [UIImage imageNamed:@"icon1"];
    image1.layer.cornerRadius = H(image1)/2;
    
    
    //你
    UIImageView *image2 = [[UIImageView alloc]initWithFrame:CGRectMake(97.5, 7.5, 75, 75)];
    image2.image = [UIImage imageNamed:@"icon2"];
    image2.layer.cornerRadius = H(image1)/2;
    image2.layer.masksToBounds = YES;
    
    
    //他
    UIImageView *image3 = [[UIImageView alloc]initWithFrame:CGRectMake(187.5, 7.5, 75, 75)];
    image3.image = [UIImage imageNamed:@"icon3"];
    image3.layer.cornerRadius = H(image1)/2;
    
    
    
    [_iconScroll addSubview:image1];
    [_iconScroll addSubview:image2];
    [_iconScroll addSubview:image3];
    
    
    [_ICON addSubview:_iconScroll];
    
}









#pragma mark- 添加阴影

- (void)setBGalphaWithView:(UIView *)view ImageName:(NSString *)name downName:(NSString *)downname
{
    
    UIImage *up = [UIImage imageNamed:name];
    UIImageView *upimage = [UIImageView new];
    upimage.image = up;
    
    
    UIImage *down = [UIImage imageNamed:downname];
    UIImageView *downimage = [UIImageView new];
    downimage.image = down;
    
    
    [view sd_addSubviews:@[upimage,downimage]];
    
    
    upimage.sd_layout.topSpaceToView(view,0).widthIs(screen_width).heightIs(90);
    downimage.sd_layout.bottomSpaceToView(view,0).widthIs(screen_width).heightIs(90);
    
    upimage.alpha = 0.7f;
    downimage.alpha = 0.7;
    
//    upimage.contentMode = UIViewContentModeScaleAspectFit;
//    downimage.contentMode = UIViewContentModeScaleAspectFit;
}






#pragma mark- scroll delegate ->> 控制page

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    _PageControl.currentPage = scrollView.contentOffset.x / screen_width;
    
    
    float offset = scrollView.contentOffset.x / screen_width;
    
    [_iconScroll setContentOffset:CGPointMake(W(_ICON) * offset , 0)];
    
    NSLog(@"%f",(float) (offset - (int)(_iconScroll.contentOffset.x / W(_ICON))));
    
    NSInteger IconOffset = _iconScroll.contentOffset.x / W(_ICON);
    
    //滚动百分比
    float persent = (offset - (int)(_iconScroll.contentOffset.x / W(_ICON)));
    
    for (UIImageView *image in _iconScroll.subviews) {
        
        if (image == _iconScroll.subviews[IconOffset]) {
            //当前image
            image.transform = CGAffineTransformMakeScale(1 - persent, 1 - persent);
        }else{
            image.transform = CGAffineTransformMakeScale(persent, persent);
        }
        
    }
    
}


-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{

}



#pragma mark- 切换root控制器

- (void) Exchange:(UIButton *)sender {
    
    self.ExchangeController();
}

#pragma mark- 隐藏状态栏
- (BOOL)prefersStatusBarHidden {
    return YES;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}







/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
