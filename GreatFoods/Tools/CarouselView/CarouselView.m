//
//  CarouselView.m
//  轮播图
//
//  Created by lanou on 16/4/6.
//  Copyright © 2016年 WYH. All rights reserved.
//

#import "CarouselView.h"

@interface CarouselView ()<UIScrollViewDelegate>

@property(nonatomic,retain)UIScrollView *scrollView;
@property(nonatomic,retain)UIPageControl *pageControl;
@property(nonatomic,retain)UILabel *textLabel;

@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat height;

@property(nonatomic,assign)NSInteger curPage;//当前显示的下标
@property(nonatomic,retain)NSMutableArray *curArray;//存放当前显示的图片

@property(nonatomic,retain)NSTimer *timer;//定时器

@end

@implementation CarouselView

-(id)initWithFrame:(CGRect)frame{
    
    _width = frame.size.width;
    _height = frame.size.height;

    if (self = [super initWithFrame:frame]) {
        
        [self initWithScrollView];
        [self initWithPageControl];
        [self initWithTextLabel];
        
    }
    return self;
}


//创建scrollView
-(void)initWithScrollView{
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, _width, _height)];
    _scrollView.pagingEnabled = YES;
    _scrollView.contentSize = CGSizeMake(_width*3, 0);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.contentOffset = CGPointMake(_width, 0);
    
    _scrollView.delegate = self;
    
    self.curArray = [NSMutableArray arrayWithCapacity:3];
    
    //遍历创建显示的三张图片
    for (int i = 0; i < 3; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(_width*i, 0, _width, _height)];
        [_scrollView addSubview:imageView];
    }
    
    [self addSubview:_scrollView];
}

-(void)initWithPageControl{
    self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(_width-80, _height-30, 70, 30)];
    [self addSubview:_pageControl];
}

-(void)initWithTextLabel{
    self.textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _height-30, _width-80, 30)];
    _textLabel.textColor = [UIColor yellowColor];
    [self addSubview:_textLabel];
}

//专门计算下标的方法
-(NSInteger)updateCurpage:(NSInteger)page{
    
    NSInteger count = (page + self.array.count)%_array.count;
    return count;
}

//替换数据源的方法
-(void)updateCurViewWithPage:(NSInteger)page{
    
    //获取上一张图片的下标
    NSInteger per = [self updateCurpage:page-1];
    //当前显示的下标
    self.curPage = [self updateCurpage:page];
    //获取下一张的下标
    NSInteger last = [self updateCurpage:page+1];
    
    //当前显示的数据源
    [self.curArray removeAllObjects];
    [self.curArray addObject:self.array[per]];
    [self.curArray addObject:self.array[_curPage]];
    [self.curArray addObject:self.array[last]];
    
    //获取scrollView上的所有子视图
    NSArray *subArray = self.scrollView.subviews;
    
    for (int a = 0; a < 3; a++) {
        
        UIImageView *imageView = subArray[a];
        imageView.image = [UIImage imageNamed:self.curArray[a]];
        
        if (a == 1) {
            self.textLabel.text = self.curArray[1];
        }
    }
    
    self.scrollView.contentOffset = CGPointMake(_width, 0);
    self.pageControl.currentPage = _curPage;
}

-(void)setArray:(NSArray *)array{
    
    _array = array;
    [self updateCurViewWithPage:0];
    self.pageControl.numberOfPages = array.count;
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(autoupdate:) userInfo:nil repeats:YES];
}

-(void)autoupdate:(id)sender{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.scrollView.contentOffset = CGPointMake(_width*2, 0);
    }];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat x = scrollView.contentOffset.x;
    if (x >= _width*2) {
        [self updateCurViewWithPage:_curPage+1];
    }else if (x <= 0){
        [self updateCurViewWithPage:_curPage-1];
    }
}

//开始拖动
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self.timer invalidate];
    self.timer = nil;
}

//开始减速
-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(autoupdate:) userInfo:nil repeats:YES];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
