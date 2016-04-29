//
//  ClearCacheController.m
//  美食类
//
//  Created by 夏浩文 on 16/4/28.
//  Copyright © 2016年 夏浩文. All rights reserved.
//

#import "ClearCacheController.h"

#import <SDImageCache.h>
@interface ClearCacheController ()

@end

@implementation ClearCacheController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
//        NSLog(@"沙河路径 --> %@",NSHomeDirectory());
    
    
    [self buildGGIcon];//添加头部视图
    
    
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
    return @"这是一款🐔的软件,又名DayDayFuck!";
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
    
    
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/





#pragma mark- 添加头部视图 (icon)

- (void) buildGGIcon{
    
    UIView *back = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screen_width, 370)];
    
    [self.view addSubview:back];
    
    UIImageView *Iconimage = [[UIImageView alloc]initWithFrame:back.bounds];
    
    [Iconimage setImage:[UIImage imageNamed:@"GGIcon"]];
    
    [Iconimage setContentMode:UIViewContentModeScaleAspectFit];
    
    [back addSubview:Iconimage];
    
    self.tableView.tableHeaderView = back;
    
    
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    backButton.frame = CGRectMake(30, 70, 30, 30);
    
    [backButton setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    
    [backButton addTarget:self action:@selector(backto) forControlEvents:UIControlEventTouchUpInside];
    
    [back addSubview:backButton];
    
}

- (void)backto
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
