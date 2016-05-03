//
//  ClearCacheController.m
//  美食类
//
//  Created by 夏浩文 on 16/4/28.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "ClearCacheController.h"
#import "aboutThisViewController.h"

#import <SDImageCache.h>
@interface ClearCacheController ()

@end

@implementation ClearCacheController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//        NSLog(@"沙河路径 --> %@",NSHomeDirectory());
    
    
    [self buildGGIcon];//添加头部视图
    
    [self.tableView setContentInset:UIEdgeInsetsMake(-20, 0, 0, 0)];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"清理缓存";
    }
    return @"关于app";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    if (section == 0) {
        return @"视频缓存清除包含浏览与收藏记录";
    }
    return @"关于真食汇的版权声明";
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"clearcache"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"clearcache"];
    }
    
    cell.textLabel.textColor = RGB(92, 58, 64);
    
    // Configure the cell...
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.textLabel.text = @"视频缓存";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2fMB",[self filePath]];
        
        
    }else if (indexPath.row == 1){
        cell.textLabel.text = @"图片缓存";
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2fMB",[[SDImageCache sharedImageCache] getSize] /1024.0/1024.0];
    }
    
    // Section 2..
    if (indexPath.section == 1 && indexPath.row == 0) {
        cell.textLabel.text = @"- 关于真食汇 -";
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        
        UIAlertController *clearImage = [UIAlertController alertControllerWithTitle:@"Clear Images caches" message:@"将清除所有的图片缓存" preferredStyle:UIAlertControllerStyleAlert];
        
        //取消
        [clearImage addAction:[UIAlertAction actionWithTitle:@"放弃" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [clearImage dismissViewControllerAnimated:YES completion:nil];
        }]];
        
        //确认
        [clearImage addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[SDImageCache sharedImageCache]clearDisk];
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:1 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            
            UIAlertView *clear = [[UIAlertView alloc]initWithTitle:nil message:@"删除成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [clear show];
            [clear dismissWithClickedButtonIndex:0 animated:YES];
            
        }]];
        
        [self presentViewController:clearImage animated:YES completion:nil];
        
    }
    else if (indexPath.section == 0 && indexPath.row == 0){   //删除视频缓存
        
        UIAlertController *clearFilm = [UIAlertController alertControllerWithTitle:@"Clear Film caches and Data" message:@"将清除所有的视频缓存和浏览数据" preferredStyle:UIAlertControllerStyleAlert];
        
        //取消
        [clearFilm addAction:[UIAlertAction actionWithTitle:@"放弃" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            [clearFilm dismissViewControllerAnimated:YES completion:nil];
        }]];
        
        //确认
        [clearFilm addAction:[UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            // your code..
            [self clearDocumentCache];
            
            //..
            [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            
            UIAlertView *clear = [[UIAlertView alloc]initWithTitle:nil message:@"清理成功" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
            [clear show];
            [clear dismissWithClickedButtonIndex:0 animated:YES];
            
            //删除nsuser保存的视频路径
            NSString *appDomain = [[NSBundle mainBundle]bundleIdentifier];
            [[NSUserDefaults standardUserDefaults]removePersistentDomainForName:appDomain];
            
        }]];
        
        [self presentViewController:clearFilm animated:YES completion:nil];
    }
    
    
    // Section 2...
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        
        aboutThisViewController *about = [aboutThisViewController new];
        [self.navigationController pushViewController:about animated:YES];
        
    }
    
}






#pragma mark- 添加头部视图 (icon)

- (void) buildGGIcon{
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 350)];
    
    [self.view addSubview:back];
    
    UIImageView *Iconimage = [[UIImageView alloc]initWithFrame:back.bounds];
    
    [Iconimage setImage:[UIImage imageNamed:@"GGIcon"]];
    
    [Iconimage setContentMode:UIViewContentModeScaleAspectFit];
    
    [back addSubview:Iconimage];
    
    self.tableView.tableHeaderView = back;
    
    
}





#pragma mark- 缓存方法

//1:首先我们计算一下 单个文件的大小

- ( long long ) fileSizeAtPath:( NSString *) filePath{
    
    NSFileManager * manager = [ NSFileManager defaultManager ];
    
    if ([manager fileExistsAtPath :filePath]){
        
        return [[manager attributesOfItemAtPath :filePath error : nil ] fileSize ];
        
    }
    
    return 0 ;
    
}

//2: 遍历文件夹获得文件夹大小，返回多少 M（提示：你可以在工程界设置（)m）

- ( float ) folderSizeAtPath:( NSString *) folderPath{
    
    NSFileManager * manager = [ NSFileManager defaultManager ];
    
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator ];
    
    NSString * fileName;
    
    long long folderSize = 0 ;
    
    while ((fileName = [childFilesEnumerator nextObject ]) != nil ){
        
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
        
    }
    
    return folderSize/( 1024.0 * 1024.0 );
    
}

// 显示缓存大小

- ( float )filePath

{
    //document快捷写法
    
    NSString * cachPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
    
    //[ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    
    
    return [ self folderSizeAtPath :cachPath];
    
}


#pragma mark- 删除路径下的缓存

- (void) clearDocumentCache{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString *Cachefile = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
        
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:Cachefile];
        
        for (NSString *fileName in files) {
            
            NSString *path = [Cachefile stringByAppendingPathComponent:fileName];
            
            if ([[NSFileManager defaultManager] fileExistsAtPath:path]) { //如果文件存在
                [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
            }
            
        }
        [self performSelectorOnMainThread:@selector(clearSuccess) withObject:nil waitUntilDone:YES];
    });
    
}

- (void)clearSuccess{
    NSLog(@"清理视频缓存成功");
}




@end
