//
//  DaydayCookDescription.m
//  美食类
//
//  Created by 夏浩文 on 16/4/19.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "DaydayCookDescription.h"
#import "DayDescriptionData.h"
#import "Loading.h"

#import <UIView+SDAutoLayout.h>
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
@interface DaydayCookDescription () <UIWebViewDelegate>
{
    Loading *load;
}

/* 图片*/
@property (nonatomic, retain) UIImageView *image;
/* title*/
@property (nonatomic, retain) UILabel *titleName;
/* makeimage*/
@property (nonatomic, retain) UIImageView *makeImage;
/* makelabel*/
@property (nonatomic, retain) UILabel *makelabel;
/* watchimage*/
@property (nonatomic, retain) UIImageView *watchImage;
/* watchLabel*/
@property (nonatomic, retain) UILabel *watchlabel;
/* imgUrl*/
@property (nonatomic, retain) NSString *imgUrl;
/* url*/
@property (nonatomic, retain) NSString *url;

/* makeTitle*/
@property (nonatomic, retain) NSString *makeTitle;

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation DaydayCookDescription



-(void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    UIToolbar *tool = [[UIToolbar alloc]initWithFrame:CGRectMake(0, screen_height -40, screen_width, 40)];
    
    [tool setBackgroundColor:[UIColor redColor]];
    //收藏按钮
    UIButton *collectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [collectBtn setFrame:CGRectMake(0, 0, screen_width/3, 40)];
    [collectBtn setImage:[UIImage imageNamed:@"收藏.png"] forState:UIControlStateNormal];
    [collectBtn setImage:[UIImage imageNamed:@"收藏(1).png"] forState:UIControlStateSelected];
    [collectBtn addTarget:self action:@selector(collectAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *collectItem = [[UIBarButtonItem alloc]initWithCustomView:collectBtn];
    //字体改变按钮
    UIButton *fontBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [fontBtn setFrame:CGRectMake(0, 0, screen_width/3, 40)];
    [fontBtn setImage:[UIImage imageNamed:@"字体.png"] forState:UIControlStateNormal];
    [fontBtn setImage:[UIImage imageNamed:@"字体放大.png"] forState:UIControlStateSelected];
    [fontBtn addTarget:self action:@selector(fontBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *fontItem = [[UIBarButtonItem alloc]initWithCustomView:fontBtn];
    
    //分享
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareBtn setFrame:CGRectMake(0, 0, screen_width/3, 40)];
    [shareBtn setImage:[UIImage imageNamed:@"分享.png"] forState:UIControlStateNormal];
    [shareBtn addTarget:self action:@selector(shareBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]initWithCustomView:shareBtn];
    NSArray *itemArr =[NSArray arrayWithObjects:collectItem,fontItem,shareItem, nil];
    [tool setItems:itemArr];
    
    [self.view addSubview:tool];
}
-(void)shareBtnAction:(UIButton *)btn
{
    
    
}
-(void)fontBtnAction:(UIButton *)btn
{
    if (btn.selected == NO) {
        
        //改变wedView字体大小
        [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '150%'"];
    }
    
    else{
        
        [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '100%'"];
        
    }
    btn.selected = !btn.selected;

    
}
-(void)collectAction:(UIButton *)btn{
    
    
    btn.selected = !btn.selected;
   }


    

- (void)viewDidLoad {
    [super viewDidLoad];
    //
    self.navigationController.navigationBarHidden = YES;

    [self.webView setScalesPageToFit:YES];

    self.webView.delegate = self;
    
    dispatch_async(dispatch_queue_create("discription", DISPATCH_QUEUE_PRIORITY_DEFAULT), ^{
        
        [self getData];
    });
    self.webView.scrollView.contentInset    = UIEdgeInsetsMake(screen_width + 100, 0, 0, 0);
    self.webView.scrollView.backgroundColor = RGB(245, 245, 245);
    [self buildImageAndLabel];


}


-(void)forward{
    
//        [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '150%'"];
}
-(void)back{
    [self.webView goBack];
}




//
//-(void)viewDidLayoutSubviews{
//    load = [[Loading alloc]initWithFrame:self.view.bounds];
//    [self.view addSubview:load];
//    [self.view bringSubviewToFront:load];
//}







#pragma mark- 控制图片缩放


-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if (velocity.y < 0) {
        //        self.image.transform = CGAffineTransformMakeScale(1+ABS(scrollView.contentOffset.y / 100), 1+ABS(scrollView.contentOffset.y / 100));
        
    }
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (!decelerate) {

    }
}







#pragma mark- 按钮点击方法

- (IBAction)Back:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}










#pragma mark- 获取数据

- (void)getData{
    NSString *url =[NSString stringWithFormat:@"http://218.244.151.213/daydaycook/server/recipe/details.do?id=%ld&username=&password=",(long)self.BookID];
    self.url = url;
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    [manager POST:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if ([responseObject[@"msg"] isEqualToString:@"成功"]) {
            
            DayDescriptionData *model = [DayDescriptionData modelObjectWithDictionary:responseObject[@"data"]];
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                
                
                [self.image sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
                self.titleName.text  = model.title;
                self.makeTitle = model.title;
                self.imgUrl = model.imageUrl;
                
                self.makelabel.text  = model.maketime;
                self.watchlabel.text = [NSString stringWithFormat:@"%.0f",model.clickCount];
                
                NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:model.loadContent]];
                
                [self.webView.scrollView setBounces:NO];
                
                //加载请求
                [self.webView loadRequest:request];
                //是否自动适应屏幕大小
                [self.webView setScalesPageToFit:YES];
                
                
                
                
            });
        }
    } failure:nil];
}








//-(void)webViewDidFinishLoad:(UIWebView *)webView{
////    CGFloat height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
//    //可获取load后webview的真实size.height
//}














#pragma mark- 约束布局(写入webview的scrollview里)

- (void)buildImageAndLabel{
    
    self.image        = [UIImageView new];
    self.titleName    = [UILabel new];
    self.makeImage    = [UIImageView new];
    self.makelabel    = [UILabel new];
    self.watchImage   = [UIImageView new];
    self.watchlabel   = [UILabel new];
    UIView *whiteBack = [UIView new];
    
    [self.webView.scrollView sd_addSubviews:@[self.image,whiteBack]];
    
    [_image setFrame:CGRectMake(0, -screen_width-100, screen_width, screen_width)];
    
    [_image setContentMode:UIViewContentModeScaleAspectFill];
    whiteBack.sd_layout.topSpaceToView(_image,10).leftSpaceToView(self.webView.scrollView,10).rightSpaceToView(self.webView.scrollView,10)
    .heightIs(80);

    
    [whiteBack sd_addSubviews:@[self.titleName,self.makeImage,self.makelabel,self.watchImage,self.watchlabel]];
    [whiteBack setBackgroundColor:[UIColor whiteColor]];
    
    self.titleName.sd_layout.topSpaceToView(whiteBack,15)
    .leftSpaceToView(whiteBack,10).widthRatioToView(whiteBack,.8).autoHeightRatio(0);
    self.titleName.textColor = RGB(255,129,141);
    self.titleName.font = [UIFont systemFontOfSize:20];
//    self.titleName.font = [UIFont boldSystemFontOfSize:20];

    _makeImage.sd_layout.bottomSpaceToView(whiteBack,10).leftEqualToView(_titleName).heightIs(16).widthEqualToHeight();
    [_makeImage setImage:[UIImage imageNamed:@"clock"]];
    
    _makelabel.sd_layout.bottomEqualToView(_makeImage).leftSpaceToView(_makeImage,8).widthIs(60).heightIs(16);
    _makelabel.textColor = RGB(79,79,79);
    _makelabel.font = [UIFont systemFontOfSize:16];
    
    _watchImage.sd_layout.topEqualToView(_makeImage).leftSpaceToView(_makelabel,25).bottomEqualToView(_makeImage).widthEqualToHeight();
    [_watchImage setImage:[UIImage imageNamed:@"eyes"]];
    
    
    _watchlabel.sd_layout.bottomEqualToView(_watchImage).leftSpaceToView(_watchImage,8).autoHeightRatio(0);
    _watchlabel.textColor = RGB(79,79,79);
    _watchlabel.font = [UIFont systemFontOfSize:16];
    
    
    
}


-(void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //
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
