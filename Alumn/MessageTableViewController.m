//
//  MessageTableViewController.m
//  Alumn
//
//  Created by Dorangefly Liu on 16/9/13.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import "MessageTableViewController.h"
#import "MJRefresh.h"
#import "SystemMessageTableViewCell.h"
#import "MessageViewModel.h"
#import "MyAltview.h"
#import "Circle_FindVC.h"
#import "UIView+SDAutoLayout.h"


@interface MessageTableViewController ()

@property (nonatomic,strong)NSArray *dataArray;
@property (nonatomic,strong)MyAltview *alt;
@property (nonatomic,strong)UIView *darkview;

@end

@implementation MessageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //---------------------------------  设置数据
    self.dataArray = [MessageViewModel messageListFromPlist];
    
    UINib *nib = [UINib nibWithNibName:@"SystemMessageTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.rowHeight = 110;
}

- (void)delayInSeconds:(CGFloat)delayInSeconds block:(dispatch_block_t) block
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC),  dispatch_get_main_queue(), block);
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (SystemMessageTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SystemMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.font = [UIFont systemFontOfSize:17];
    for(int i = 0;i < self.dataArray.count;i++){
        switch ([[[MessageViewModel messageListFromPlist][i] valueForKey:@"type"] intValue]) {
            case 0:{
                cell.circleURL = [[self.dataArray[i] valueForKey:@"message"] valueForKey:@"circle_url"];
                cell.messageName = @"圈子通知";
                cell.messageContent = [NSString stringWithFormat:@"您申请创建的圈子 %@ 已通过审核",[[self.dataArray[i] valueForKey:@"message"] valueForKey:@"circle_name"]];
                cell.updateTime = [self.dataArray[i] valueForKey:@"update_time"];
                break;
            }
            case 1:{
                cell.circleURL = [[self.dataArray[i] valueForKey:@"message"] valueForKey:@"circle_url"];
                cell.messageName = @"圈子通知";
                cell.messageContent = [NSString stringWithFormat:@"您申请创建的圈子 %@ 未通过审核",[[self.dataArray[i] valueForKey:@"message"] valueForKey:@"circle_name"]];
                cell.updateTime = [[MessageViewModel messageListFromPlist][i] valueForKey:@"update_time"];
                break;
            }
            case 2:{
                cell.circleURL = [[self.dataArray[i] valueForKey:@"message"] valueForKey:@"circle_url"];
                cell.messageName = @"圈子通知";
                cell.messageContent = [NSString stringWithFormat:@"%@已加入",[[self.dataArray[i] valueForKey:@"message"] valueForKey:@"apply_name"]];
                cell.updateTime = [NSString stringWithFormat:@"%@ | %@",[[self.dataArray[i] valueForKey:@"message"] valueForKey:@"circle_name"],[self.dataArray[i] valueForKey:@"update_time"]];
                break;
            }
            case 3:{
                cell.circleURL = [[self.dataArray[i] valueForKey:@"message"] valueForKey:@"circle_url"];
                cell.messageName = @"圈子通知";
                cell.messageContent = [[self.dataArray[i] valueForKey:@"message"] valueForKey:@"result"];
                cell.updateTime = [NSString stringWithFormat:@"%@ | %@",[[self.dataArray[i] valueForKey:@"message"] valueForKey:@"circle_name"],[self.dataArray[i] valueForKey:@"update_time"]];
                break;
            }
            case 4:{
                cell.circleURL = [[self.dataArray[i] valueForKey:@"message"] valueForKey:@"circle_url"];
                cell.messageName = @"圈子通知";
                cell.messageContent = [NSString stringWithFormat:@"%@申请加入%@",[[self.dataArray[i] valueForKey:@"message"] valueForKey:@"apply_name"],[[self.dataArray[i] valueForKey:@"message"] valueForKey:@"circle_name"]];
                cell.updateTime = [NSString stringWithFormat:@"%@ | %@",[[self.dataArray[i] valueForKey:@"message"] valueForKey:@"circle_name"],[self.dataArray[i] valueForKey:@"update_time"]];
                break;
            }
                
            default:
                break;
        }
    }
    
    return cell;
}


//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSString *circleURL;
//    NSString *messageContent;
//    NSString *updateTime;
//
//
//    switch ([[[MessageViewModel messageListFromPlist][indexPath.row] valueForKey:@"type"] intValue]) {
//        case 0:{
//            circleURL = [[self.dataArray[indexPath.row] valueForKey:@"message"] valueForKey:@"circle_url"];
//            messageContent = [NSString stringWithFormat:@"您申请创建的圈子 %@ 已通过审核",[[self.dataArray[indexPath.row] valueForKey:@"message"] valueForKey:@"circle_name"]];
//            updateTime = [self.dataArray[indexPath.row] valueForKey:@"update_time"];
//            break;
//        }
//        case 1:{
//            circleURL = [[self.dataArray[indexPath.row] valueForKey:@"message"] valueForKey:@"circle_url"];
//            messageContent = [NSString stringWithFormat:@"您申请创建的圈子 %@ 未通过审核",[[self.dataArray[indexPath.row] valueForKey:@"message"] valueForKey:@"circle_name"]];
//            updateTime = [[MessageViewModel messageListFromPlist][indexPath.row] valueForKey:@"update_time"];
//            break;
//        }
//        case 2:{
//            circleURL = [[self.dataArray[indexPath.row] valueForKey:@"message"] valueForKey:@"circle_url"];
//            messageContent = [NSString stringWithFormat:@"%@已加入",[[self.dataArray[indexPath.row] valueForKey:@"message"] valueForKey:@"apply_name"]];
//            updateTime = [NSString stringWithFormat:@"%@ | %@",[[self.dataArray[indexPath.row] valueForKey:@"message"] valueForKey:@"circle_name"],[self.dataArray[indexPath.row] valueForKey:@"update_time"]];
//            break;
//        }
//        case 3:{
//            circleURL = [[self.dataArray[indexPath.row] valueForKey:@"message"] valueForKey:@"circle_url"];
//            messageContent = [[self.dataArray[indexPath.row] valueForKey:@"message"] valueForKey:@"result"];
//            updateTime = [NSString stringWithFormat:@"%@ | %@",[[self.dataArray[indexPath.row] valueForKey:@"message"] valueForKey:@"circle_name"],[self.dataArray[indexPath.row] valueForKey:@"update_time"]];
//            break;
//        }
//        case 4:{
//            circleURL = [[self.dataArray[indexPath.row] valueForKey:@"message"] valueForKey:@"circle_url"];
//            messageContent = [NSString stringWithFormat:@"%@申请加入%@",[[self.dataArray[indexPath.row] valueForKey:@"message"] valueForKey:@"apply_name"],[[self.dataArray[indexPath.row] valueForKey:@"message"] valueForKey:@"circle_name"]];
//            updateTime = [NSString stringWithFormat:@"%@ | %@",[[self.dataArray[indexPath.row] valueForKey:@"message"] valueForKey:@"circle_name"],[self.dataArray[indexPath.row] valueForKey:@"update_time"]];
//            break;
//        }
//
//        default:
//            break;
//    }
//
//
//
//    _darkview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//    _darkview.backgroundColor = [UIColor blackColor];
//    _darkview.alpha = 0.5;
//    _darkview.userInteractionEnabled =YES;
//    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(event:)];
//    [tapGesture setNumberOfTapsRequired:1];
//    [_darkview addGestureRecognizer:tapGesture];
//    [self.view addSubview:_darkview];
//    self.alt = [MyAltview new];
//    self.alt.altwidth=280;
//
//    // circleName 最上面  alttitle:人名   icon:url  creator_id
//
//    NSString *contentWithBlanck = [[NSString alloc] initWithFormat:@"%@,%@",messageContent,@"\n"];
//    [_alt CreatAlt:nil circleName:@"圈子通知" altTitle:updateTime altButton:nil altbtnTcolor:[UIColor blackColor] altselectbtnTcolor:[UIColor whiteColor] icon:circleURL];
//    _alt.sd_layout
//    .centerYEqualToView(self.view)
//    .centerXEqualToView(self.view);
//    [self.view addSubview:_alt.view];
//    [Circle_FindVC animationAlert:_alt.view];
//    [_alt show];
//
//}
//
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
