//
//  tableListViewController.m
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/27.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import "tableListViewController.h"
#import "VVeboTableView.h"

@interface tableListViewController ()

@end

@implementation tableListViewController{
    VVeboTableView *tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    tableView = [[VVeboTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
    tableView.scrollIndicatorInsets = tableView.contentInset;
    [self.view addSubview:tableView];
    
    UIToolbar *statusBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
    [self.view addSubview:statusBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
