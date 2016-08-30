//
//  ViewController.h
//  PeopleListDemo
//
//  Created by 韩雪滢 on 8/27/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PeopleListVC : UIViewController
<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchResultsUpdating>
@property (weak, nonatomic) IBOutlet UIButton *button;


@end

