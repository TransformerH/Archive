//
//  JoinedCircleTableViewController.m
//  scrollViewDamo
//
//  Created by 韩雪滢 on 8/26/16.
//  Copyright © 2016 小腊. All rights reserved.
//

#import "JoinedCircleTableViewController.h"
#import "MJRefresh.h"
#import "CircleCell.h"
#import "MeViewModel.h"
#import "MessageViewModel.h"



@interface JoinedCircleTableViewController ()

@end

@implementation JoinedCircleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    UINib *nib = [UINib nibWithNibName:@"CircleCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"circle"];
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    self.tableView.rowHeight = 90;
    
    //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$  防止IOS自动释放self
    __typeof (self) __weak weakSelf = self;
    
    //   MJRefresh  上拉刷新数据
    
    self.tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        
        [weakSelf delayInSeconds:1.0 block:^{
            //如果itemNum < plist中的所有圈子数则刷新
            if(weakSelf.itemNum < [MeViewModel createCircleFromPlist].count){
                if((weakSelf.itemNum + 4) < [MeViewModel adminCircleFromPlist].count){
                    weakSelf.itemNum += 4;
                }else{
                    weakSelf.itemNum += ([MeViewModel adminCircleFromPlist].count - weakSelf.itemNum);
                }
                [weakSelf.tableView.footer endRefreshing];
                [weakSelf.tableView reloadData];
            }
            
        }];
    }];
}

- (void)delayInSeconds:(CGFloat)delayInSeconds block:(dispatch_block_t) block
{
    //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$  延迟时间，将block 中执行的操作加入到队列中
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC),  dispatch_get_main_queue(), block);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _itemNum;
}

- (CircleCell*)tableView:(UITableView*)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    CircleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"circle" forIndexPath:indexPath];
    if([MeViewModel adminCircleFromPlist].count >0){
        cell.name = [[MeViewModel adminCircleFromPlist][indexPath.row] valueForKey:@"name"];}
    
    
    return cell;
}
/*
 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
 
 // Configure the cell...
 
 return cell;
 }
 */

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
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
