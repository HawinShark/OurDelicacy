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

/* 播放器 */
@property (nonatomic, retain) UIWebView *player;
/* 播放按钮 */
@property (nonatomic, retain) UIButton *playButton;

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
        [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '130%'"];
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
    
    [self showHudInViewhint:@"拼命加载呢!.."];
    dispatch_async(dispatch_queue_create("discription", DISPATCH_QUEUE_PRIORITY_DEFAULT), ^{
        
        [self getData];
    });
    
    self.webView.scrollView.contentInset    = UIEdgeInsetsMake(screen_width + 100, 0, 36, 0);
    
    //去除webview底部黑条
    self.webView.opaque = NO;
    
    self.webView.backgroundColor = RGB(245, 245, 245);
    self.webView.scrollView.backgroundColor = RGB(245, 245, 245);
    
    [self buildImageAndLabel];


}


-(void)forward{
    
//        [self.webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '150%'"];
}
-(void)back{
    [self.webView goBack];
}











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
    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
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
                
                
                dispatch_async(dispatch_get_global_queue(0, 0), ^{
                    
                    [self.image sd_setImageWithURL:[NSURL URLWithString:model.imageUrl]];
                    
                    NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:model.loadContent]];
                    [self.webView loadRequest:request];
                    
                    NSURLRequest * PlayRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:model.detailsUrl]];
                    [self.player loadRequest:PlayRequest];
                });
                
                self.titleName.text  = model.title;
                self.makeTitle = model.title;
                self.imgUrl = model.imageUrl;
                
                self.makelabel.text  = model.maketime;
                self.watchlabel.text = [NSString stringWithFormat:@"%.0f",model.clickCount];
                
                
                [self.webView.scrollView setBounces:NO];
                
                //加载请求
                //是否自动适应屏幕大小
                [self.webView setScalesPageToFit:YES];
                
                
                [self showhide];
                
                [self.player setScalesPageToFit:YES];
                
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
    //
    self.player = [UIWebView new];
    self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [self.webView.scrollView sd_addSubviews:@[self.image,whiteBack]];
    
    [_image setFrame:CGRectMake(0, -screen_width-100, screen_width, screen_width)];
    
    [_image setContentMode:UIViewContentModeScaleAspectFill];
    whiteBack.sd_layout.topSpaceToView(_image,10).leftSpaceToView(self.webView.scrollView,10).rightSpaceToView(self.webView.scrollView,10)
    .heightIs(80);

    _image.userInteractionEnabled = YES;
    
    //视频播放器
    [_image sd_addSubviews:@[ _player,_playButton]];
    _player.alpha = 0;
    _player.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    _player.scrollView.bounces = NO;
    //控制播放
    _playButton.alpha = 1;
    _playButton.sd_layout.centerXEqualToView(_image).centerYEqualToView(_image).widthIs(80).heightEqualToWidth();
    [_playButton setImage:[UIImage imageNamed:@"Play"] forState:UIControlStateNormal];
    [_playButton addTarget:self action:@selector(play) forControlEvents:UIControlEventTouchUpInside];
//    _playButton.userInteractionEnabled = YES;
    
    [whiteBack sd_addSubviews:@[self.titleName,self.makeImage,self.makelabel,self.watchImage,self.watchlabel]];
    [whiteBack setBackgroundColor:[UIColor whiteColor]];
    
    self.titleName.sd_layout.topSpaceToView(whiteBack,15)
    .leftSpaceToView(whiteBack,10).rightSpaceToView(whiteBack,10);
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



-(void)play{
    
    self.playButton.alpha = 0;
    self.player.alpha = 1;
    
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
