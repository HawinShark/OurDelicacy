//
//  DDCLoopLayout.m
//  美食类
//
//  Created by 夏浩文 on 16/4/18.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "DDCLoopLayout.h"

static CGFloat const DDCViewLayoutStandardHeight = 100.0f;
static CGFloat const DDCViewLayoutFocusHeight = 310.0f;
static CGFloat const DDCViewLayoutDragHeight = 210.0f;

@interface DDCLoopLayout ()

@property (nonatomic,copy) NSArray *cachesLayoutAttributes;

@end

@implementation DDCLoopLayout

#pragma mark- Life Cicle

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commandINIT];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commandINIT];
    }
    return self;
}

- (void)commandINIT
{
    _standardHeight = DDCViewLayoutStandardHeight;
    _focusHeight = DDCViewLayoutFocusHeight;
    _dragHeight = DDCViewLayoutDragHeight;
}

#pragma mark- UICollectionViewFlowLayout 方法自定义

/* 返回所有内容的大小(ContentSize) */
-(CGSize)collectionViewContentSize
{
    //第一section
    NSInteger numberOfItems = [self numberOfItems];
    //计算出总高度
    CGFloat contentHeight = numberOfItems * self.dragHeight + ([self height] - self.dragHeight);//第一个的大小~
    return CGSizeMake([self width], contentHeight);
}

//不断使固定坐标失效(使可见的第一个cell永远是最大的size <280>) --当边界更改时是否更新布局
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

/* 返回最近的cell的偏移量以获取更好的snap效果,类似于分页效果 */
-(CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    //平滑滚动 当手指的touch离开(realease)点击cell的时候
    CGFloat TouchItemIndex = roundf(proposedContentOffset.y / self.dragHeight);//四舍五入
    CGFloat nearestPageOffset = TouchItemIndex * self.dragHeight;//滑动相应距离
    return CGPointMake(0.0, nearestPageOffset);
}

/* Return all attributes in the cache whose frame intersects with the rect passed to the method
 */
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    //创建 本视图下的矩形layouts
    NSMutableArray *layoutArributes = [NSMutableArray array];
    
    for (UICollectionViewLayoutAttributes *atrributs in self.cachesLayoutAttributes) {
        
        if (CGRectIntersectsRect(atrributs.frame, rect)) {
            [layoutArributes addObject:atrributs];
        }
    }
    
    return layoutArributes;
}

-(void)prepareLayout {
    
    NSMutableArray *cache = [NSMutableArray new];
    
    NSInteger countOfItems = [self numberOfItems];
    
    // last rect will be used to calculate frames past the first one.
    // 初始化它为一个无用的0值
    CGRect frame = CGRectZero;
    CGFloat y = 0.0;
    
    for (NSUInteger item = 0; item < countOfItems; item++) {
        NSIndexPath *indexpath = [NSIndexPath indexPathForItem:item inSection:0];
        
        //Initially set the height of the cell to the standard height
        //设置初始化后的cell的高 给standardheight
        CGFloat Height = self.standardHeight;
        
        self.currentIndex([self currentFocusItemIndex]);//返回下标
        
        if (indexpath.item == [self currentFocusItemIndex]) {
            //特定的cell -- >
            y = [self yOffset] - _standardHeight * [self nextItemPercentageOffset];
            Height = self.focusHeight;
        }
        else if (indexpath.item == ([self currentFocusItemIndex] + 1) && indexpath.item != countOfItems){ //
            
            //The cell directly below the featured cell, which grows as the user scrolls
            // 指定cell下面的cell 随用户的滑动直接出现
            Height = _standardHeight + MAX((_focusHeight - _standardHeight) * [self nextItemPercentageOffset], 0);
            
            CGFloat maxY = y + _standardHeight;
            y = maxY - Height;
        }
        else{
            y = frame.origin.y + frame.size.height;
        }
        //
        frame = CGRectMake(0, y, [self width], Height);
        
        UICollectionViewLayoutAttributes *layoutAtrributrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexpath];
        // Important because each cell has to slide over the top of the previous one
        //这很重要 因为每一个cell都滑动在顶部
        layoutAtrributrs.zIndex = item;
        //数组添加(计算好的frame)
        layoutAtrributrs.frame = frame;
        
        [cache addObject:layoutAtrributrs];
        //啥意思?
        y = CGRectGetMaxY(frame);
    }
    self.cachesLayoutAttributes = [cache copy];
}

//给item赋属性
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    return _cachesLayoutAttributes[indexPath.item];
}

#pragma mark- 私有方法

/* 返回当前特定的cell的下标*/
- (NSInteger)currentFocusItemIndex
{
    //dragoffset
    return MAX(0, self.collectionView.contentOffset.y / self.dragHeight);
}

//Returns a value between 0 and 1 that represents how close the next cell is to becoming the featured cell
/* 返回0~1的一个值,表示下一个接近的cell会成为特定的cell */
- (CGFloat) nextItemPercentageOffset
{
    return (self.collectionView.contentOffset.y / self.dragHeight) - [self currentFocusItemIndex];
}

//
- (NSInteger)numberOfItems
{
    return [self.collectionView numberOfItemsInSection:0];
}

- (CGFloat)width
{
    return CGRectGetWidth(self.collectionView.frame);
}

- (CGFloat)height
{
    return CGRectGetHeight(self.collectionView.frame);
}

- (CGFloat)yOffset
{
    return self.collectionView.contentOffset.y;
}

-(void)setStandardHeight:(CGFloat)standardHeight{
    if (standardHeight) {
        _standardHeight = standardHeight;
    }
}

@end
