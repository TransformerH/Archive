//
//  MessageTableViewController.m
//  Alumn
//
//  Created by Dorangefly Liu on 16/9/13.
//  Copyright © 2016年 刘畅. All rights reserved.
//

#import "MessageTableViewController.h"
#import "SystemMessageTableViewCell.h"
#import "MessageViewModel.h"
#import "User.h"
#import "User+Extension.h"



@interface MessageTableViewController ()


@property (nonatomic,strong) NSArray *dataArray;

@end

@implementation MessageTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"测试尾");
    
    [User systemMessageWithParameters:nil SuccessBlock:^(NSDictionary *dict, BOOL success) {
        NSLog(@"获取消息列表成功");
        
        self.dataArray = [MessageViewModel messageListFromPlist];
        
        NSLog(@"messageTableView的dataArray 的元素个数: %lu",(unsigned long)self.dataArray.count);
        
    } AFNErrorBlock:^(NSError *error) {
        NSLog(@"获取消息列表失败");
    }];
    
    
    UINib *nib = [UINib nibWithNibName:@"SystemMessageTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.rowHeight = 110;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [MessageViewModel messageListFromPlist].count;
}

- (SystemMessageTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SystemMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
  //  cell.textLabel.font = [UIFont systemFontOfSize:17];
//    for(int i = 0;i < self.dataArray.count;i++){
    
    NSLog(@"消息列表的类型输出: %d",[[self.dataArray[indexPath.row] valueForKey:@"type"] intValue]);
    
        switch ([[self.dataArray[indexPath.row] valueForKey:@"type"] intValue]) {
            case 0:{
                cell.circleURL = @"http://pic.58pic.com/58pic/15/65/94/75558PICQEi_1024.jpg";
                cell.messageName = @"圈子通知";
                cell.messageContent = [NSString stringWithFormat:@"您申请创建的圈子 %@ 已通过审核",[[self.dataArray[indexPath.row][indexPath.row] valueForKey:@"message"] valueForKey:@"circle_name"]];
                cell.updateTime = [self.dataArray[indexPath.row][indexPath.row] valueForKey:@"update_time"];
                break;
            }
            case 1:{
                cell.circleURL = [[self.dataArray[indexPath.row][indexPath.row] valueForKey:@"message"] valueForKey:@"circle_url"];
                cell.messageName = @"圈子通知";
                cell.messageContent = [NSString stringWithFormat:@"您申请创建的圈子 %@ 未通过审核",[[self.dataArray[indexPath.row][indexPath.row] valueForKey:@"message"] valueForKey:@"circle_name"]];
                cell.updateTime = [self.dataArray[indexPath.row] valueForKey:@"update_time"];
                break;
            }
            case 2:{
                cell.circleURL = [[self.dataArray[indexPath.row][indexPath.row] valueForKey:@"message"] valueForKey:@"circle_url"];
                cell.messageName = @"圈子通知";
                cell.messageContent = [NSString stringWithFormat:@"%@已加入",[[self.dataArray[indexPath.row][indexPath.row] valueForKey:@"message"] valueForKey:@"apply_name"]];
                cell.updateTime = [NSString stringWithFormat:@"%@ | %@",[[self.dataArray[indexPath.row][indexPath.row] valueForKey:@"message"] valueForKey:@"circle_name"],[self.dataArray[indexPath.row][indexPath.row] valueForKey:@"update_time"]];
                break;
            }
            case 3:{
                cell.circleURL = @"http://pic2.ooopic.com/11/75/82/72b1OOOPIC1e.jpg";
                cell.messageName = @"圈子通知";
                cell.messageContent = [[self.dataArray[indexPath.row][indexPath.row] valueForKey:@"message"] valueForKey:@"result"];
                cell.updateTime = [NSString stringWithFormat:@"%@ | %@",[[self.dataArray[indexPath.row][indexPath.row] valueForKey:@"message"] valueForKey:@"circle_name"],[self.dataArray[indexPath.row][indexPath.row] valueForKey:@"update_time"]];
                break;
            }
            case 4:{
                cell.circleURL = @"http://pic2.ooopic.com/11/75/82/72b1OOOPIC1e.jpg";
                cell.messageName = @"圈子通知";
                cell.messageContent = [NSString stringWithFormat:@"%@申请加入%@",[[self.dataArray[indexPath.row] valueForKey:@"message"] valueForKey:@"apply_name"],[[self.dataArray[indexPath.row] valueForKey:@"message"] valueForKey:@"circle_name"]];
                cell.updateTime = [NSString stringWithFormat:@"%@ | %@",[[self.dataArray[indexPath.row] valueForKey:@"message"] valueForKey:@"circle_name"],[self.dataArray[indexPath.row] valueForKey:@"update_time"]];
                break;
            }
                
            default:
                break;
        }
//    }
    
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


@end
