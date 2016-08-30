//
//  ViewController.m
//  PeopleListDemo
//
//  Created by 韩雪滢 on 8/27/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import "PeopleListVC.h"
#import "PeopleViewCell.h"
#import "ChooseButton.h"
#import "PeopleVM.h"
#import "UIView+SDAutoLayout.h"
#import "View+MASAdditions.h"

static NSString *CellTableIdentifier=@"CellTableIdentifier";
static BOOL isShow = NO;
//static BOOL isSearch = NO;


@interface PeopleListVC ()

@property (copy,nonatomic) NSArray *content;
@property (copy,nonatomic) NSMutableArray *choose;
@property (copy,nonatomic) NSArray *result;

@property (strong, nonatomic) IBOutlet UIView *naviView;
@property (strong,nonatomic) UIView *dview;

@property (strong,nonatomic) PeopleVM *peopleVM;
@property (strong,nonatomic) UITableView *tableView;

//@property (strong,nonatomic) UISearchController *searController;
//@property (strong,nonatomic) UISearchBar *searchBar;

@property (copy,nonatomic) NSMutableArray *searchResult;

@end

@implementation PeopleListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(_naviView.bounds.size.width - 40, 37, 20, 20)];
//    UIButton *button = [[UIButton alloc] init];
//    button.sd_layout
//    .widthIs(20)
//    .heightIs(20)
//    .rightSpaceToView(self.view,20);
//    [button setImage:[UIImage imageNamed:@"pickLogo"] forState:UIControlStateNormal];
    
    
    
    [_button addTarget:self action:@selector(showDown:) forControlEvents:UIControlEventTouchUpInside];
    [_naviView addSubview:_button];
    
    
    UIButton *searchButton = [[UIButton alloc] initWithFrame:CGRectMake(40, 37, 20, 20)];
    [searchButton setImage:[UIImage imageNamed:@"searchLogo"] forState:UIControlStateNormal];
  //  [searchButton addTarget:self action:@selector(showSearch:) forControlEvents:UIControlEventTouchUpInside];
    [_naviView addSubview:searchButton];
    
    //$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$   set content,修改数据
    
    self.peopleVM = [[PeopleVM alloc] init];
    self.content = [_peopleVM getPeople];
    
    for(int i=0;i<_content.count;i++){
        NSLog(@"%@",_content[i]);
    }
    
    
    /*self.content=@[   @{@"name":@"Sheryl",@"major":@"2014 CS",@"class":@"four",@"job":@"student",@"city":@"NJ",@"img":@"path"},
     @{@"name":@"Sheryl",@"major":@"2014 CS",@"class":@"four",@"job":@"student",@"city":@"NJ",@"img":@"path"}];
     */
    
    //---------------------------------------------------------   筛选view
    
    _choose =[NSMutableArray arrayWithArray:@[@"NO",@"NO",@"NO"]];
    
    _dview = [[UIView alloc] initWithFrame:CGRectMake(0,_naviView.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height- _naviView.bounds.size.height)];
    [self setDownView];
    
    //---------------------------------------------------------   searchbar
    /* _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, _naviView.bounds.size.height, self.view.bounds.size.width, 80)];
     _searchBar.placeholder = @"搜索关键词";
     */
    //----------------------------------------------------------   searchController
  /*  _searController = [[UISearchController alloc] initWithSearchResultsController:nil];
    _searController.delegate = self;
    _searController.dimsBackgroundDuringPresentation = NO;
    _searController.hidesNavigationBarDuringPresentation = NO;
    _searController.searchBar.frame = CGRectMake(self.searController.searchBar.frame.origin.x,self.searController.searchBar.frame.origin.y, self.searController.searchBar.frame.size.width, 44.0);
    self.tableView.tableHeaderView = self.searController.searchBar;
    
    */
    
    //---------------------------------------------------------   tableView
    _tableView=(id)[self.view viewWithTag:1];
    
    _tableView.rowHeight=116;//表示图为单元预留合适的显示空间
    UINib *nib=[UINib nibWithNibName:@"PeopleViewCell" bundle:nil];
    [_tableView registerNib:nib forCellReuseIdentifier:CellTableIdentifier];
    
    UIEdgeInsets contentInset=_tableView.contentInset;
    contentInset.top=20;
    [_tableView setContentInset:contentInset];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// table的行数
- (NSInteger)tableView:(UITableView*)tableView numberOfRowsInSection:(NSInteger)section{
 //   if(self.searController.active){
 //       return [self.searchResult count];
 //   }else{
        return [self.content count];
 //   }
}
//------------------------------------------------  字典转数组

- (NSArray*)dictionaryToArray:(NSDictionary*) dic{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    [result addObject:[dic valueForKey:@"city"]];
    [result addObject:[dic valueForKey:@"class"]];
    [result addObject:[dic valueForKey:@"job"]];
    [result addObject:[dic valueForKey:@"major"]];
    [result addObject:[dic valueForKey:@"name"]];
    return [NSArray arrayWithArray:result];
}
/*
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString *message = [self.searController.searchBar text];
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", message];
    
    if(self.searchResult != nil){
        [self.searchResult removeAllObjects];
    }
    for(int i = 0 ; i < self.content.count ; i++){
        NSArray *temp = [[NSArray alloc] initWithArray:[self dictionaryToArray:self.content[i]]];
        NSArray *tempResult = [[NSArray alloc] initWithArray:[temp filteredArrayUsingPredicate:preicate]];
        
        if(tempResult.count){
            [self.searchResult addObject:self.content[i]];
        }
    }
    
    if(self.searchResult.count != 0){
        self.content = [NSArray arrayWithArray:self.searchResult];
        [self.tableView reloadData];
    }
}

*/
//设置cell的内容
- (PeopleViewCell*)tableView:(UITableView*)tableView
       cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    //注册tableCell，创建新的cell，重复利用
    PeopleViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellTableIdentifier forIndexPath:indexPath];
    NSDictionary *rowData=self.content[indexPath.row];
    cell.name=rowData[@"name"];
    cell.major=rowData[@"major"];
    cell.classNum = rowData[@"class"];
    cell.job = rowData[@"job"];
    cell.city= rowData[@"city"];
    
    return cell;
}


//-------------------------------------------------------------   searchBar delegate
/*- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [searchBar becomeFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSString *searchContent = searchBar.text;
    
    NSLog(@"searchContent: %@",searchContent);
    
    self.content = [NSArray arrayWithArray:[self.peopleVM searchPeople:searchContent]];
    
    NSLog(@"searchResult");
    for(int i = 0;i < self.content.count ; i++){
        NSLog(@"%@",self.content[i]);
    }
    
    [self.tableView reloadData];
    //  [searchBar resignFirstResponder];
}
 */

- (void)showDown:(id)sender{
    if(!isShow){
        [self.view addSubview:_dview];
        isShow = YES;
    }
    else{
        [_dview removeFromSuperview];
        isShow = NO;
    }
    
}


- (void)setDownView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,0, self.view.bounds.size.width, self.view.bounds.size.height / 5)];
    view.backgroundColor = [UIColor whiteColor];
    
    // button groups
    ChooseButton *majorBtn = [[ChooseButton alloc] initWithFrame:CGRectMake(30, 40, 80, 30)];
    majorBtn.backgroundColor = [UIColor lightGrayColor];
    [majorBtn.layer setMasksToBounds:YES];
    [majorBtn.layer setCornerRadius:6.0];
    majorBtn.alpha = 0.5;
    [majorBtn setTitle:@"同院系" forState:UIControlStateNormal];
    majorBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [majorBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [majorBtn addTapBlock:^(UIButton *button) {
        if(button.backgroundColor == [UIColor lightGrayColor]){
            [button setBackgroundColor:[UIColor colorWithRed:84 / 255.0 green:211 / 255.0 blue:139 / 255.0 alpha:1.0]];
            button.alpha = 1.0;
            
            _choose[0] = @"YES";
            
            NSLog(@"同院系");
            for(int i=0;i<_choose.count;i++)
            {
                NSLog(@"%@",_choose[i]);
            }
        }else{
            [button setBackgroundColor:[UIColor lightGrayColor]];
            button.alpha = 0.5;
            _choose[0] = @"NO";
            
            NSLog(@"同院系");
            for(int i=0;i<_choose.count;i++)
            {
                NSLog(@"%@",_choose[i]);
            }
            
        }
    }];
    
    ChooseButton *yearBtn = [[ChooseButton alloc] initWithFrame:CGRectMake(150, 40, 80, 30)];
    yearBtn.backgroundColor = [UIColor lightGrayColor];
    [yearBtn.layer setMasksToBounds:YES];
    [yearBtn.layer setCornerRadius:6.0];
    yearBtn.alpha = 0.5;
    [yearBtn setTitle:@"同年级" forState:UIControlStateNormal];
    yearBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [yearBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [yearBtn addTapBlock:^(UIButton *button) {
        //self.choose[0] = @"YES";
        if(button.backgroundColor == [UIColor lightGrayColor]){
            [button setBackgroundColor:[UIColor colorWithRed:84 / 255.0 green:211 / 255.0 blue:139 / 255.0 alpha:1.0]];
            button.alpha = 1.0;
            
            _choose[1] = @"YES";
            
            NSLog(@"同年级");
            for(int i=0;i<_choose.count;i++)
            {
                NSLog(@"%@",_choose[i]);
            }
            
        }else{
            [button setBackgroundColor:[UIColor lightGrayColor]];
            button.alpha = 0.5;
            
            _choose[1] = @"NO";
            
            NSLog(@"同年级");
            for(int i=0;i<_choose.count;i++)
            {
                NSLog(@"%@",_choose[i]);
            }
            
        }
    }];
    
    
    ChooseButton *cityBtn = [[ChooseButton alloc] initWithFrame:CGRectMake(270, 40, 80, 30)];
    cityBtn.backgroundColor = [UIColor lightGrayColor];
    [cityBtn.layer setMasksToBounds:YES];
    [cityBtn.layer setCornerRadius:6.0];
    cityBtn.alpha = 0.5;
    [cityBtn setTitle:@"同城市" forState:UIControlStateNormal];
    cityBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [cityBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [cityBtn addTapBlock:^(UIButton *button) {
        //self.choose[0] = @"YES";
        if(button.backgroundColor == [UIColor lightGrayColor]){
            [button setBackgroundColor:[UIColor colorWithRed:84 / 255.0 green:211 / 255.0 blue:139 / 255.0 alpha:1.0]];
            button.alpha = 1.0;
            
            _choose[2] = @"YES";
            
            NSLog(@"同城市");
            for(int i=0;i<_choose.count;i++)
            {
                NSLog(@"%@",_choose[i]);
            }
            
        }else{
            [button setBackgroundColor:[UIColor lightGrayColor]];
            button.alpha = 0.5;
            
            _choose[2] = @"NO";
            
            NSLog(@"同城市");
            for(int i=0;i<_choose.count;i++)
            {
                NSLog(@"%@",_choose[i]);
            }
            
        }
    }];
    
    
    ChooseButton *closeBtn = [[ChooseButton alloc] initWithFrame:CGRectMake(270, view.bounds.size.height - 45, 80, 30)];
    closeBtn.backgroundColor = [UIColor colorWithRed:84 / 255.0 green:211 / 255.0 blue:139 / 255.0 alpha:1.0];
    [closeBtn.layer setMasksToBounds:YES];
    [closeBtn.layer setCornerRadius:6.0];
    [closeBtn setTitle:@"确定" forState:UIControlStateNormal];
    closeBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [closeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [closeBtn addTapBlock:^(UIButton *button) {
        _result = [_peopleVM matchPeople:[NSArray arrayWithArray:_choose]];
        self.content = [NSArray arrayWithArray:_result];
        //#########################   NSLog 测试新的content
        for(int k = 0 ;k<self.content.count;k++){
            NSLog(@"新的content :%@",self.content[k]);
        }
        
        [self.tableView reloadData];
        
    }];
    
    
    UIButton *superBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, view.bounds.size.height - 45, 80, 30)];
    superBtn.backgroundColor = [UIColor whiteColor];
    [superBtn.layer setMasksToBounds:YES];
    [superBtn.layer setCornerRadius:6.0];
    superBtn.layer.borderWidth = 1.5;
    superBtn.layer.borderColor = [UIColor colorWithRed:84 / 255.0 green:211 / 255.0 blue:139 / 255.0 alpha:1.0].CGColor;
    [superBtn setTitle:@"高级筛选" forState:UIControlStateNormal];
    superBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [superBtn setTitleColor:[UIColor colorWithRed:84 / 255.0 green:211 / 255.0 blue:139 / 255.0 alpha:1.0] forState:UIControlStateNormal];
    
    [view addSubview:majorBtn];
    [view addSubview:yearBtn];
    [view addSubview:cityBtn];
    [view addSubview:closeBtn];
    [view addSubview:superBtn];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    CGRect maskRect = CGRectMake(0, 0, _dview.bounds.size.width, (_dview.bounds.size.height - view.bounds.size.height));
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, nil, maskRect);
    
    [maskLayer setPath:path];
    CGPathRelease(path);
    UIView *maskView = [[UIView alloc] initWithFrame:CGRectMake(0,view.bounds.size.height, _dview.bounds.size.width,_dview.bounds.size.height - view.bounds.size.height)];
    maskView.layer.mask = maskLayer;
    maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    
    [_dview addSubview:maskView];
    [_dview addSubview:view];
    
}

- (void)clickBtn:(UIButton*)btn{
    btn.backgroundColor = [UIColor colorWithRed:84 / 255.0 green:211 / 255.0 blue:139 / 255.0 alpha:1.0];
    if([btn.currentTitle isEqualToString:@"同院系"]){
        self.choose[0] = @"YES";
    }else if([btn.currentTitle isEqualToString:@"同年级"]){
        self.choose[1] = @"YES";
    }else if([btn.currentTitle isEqualToString:@"同城市"]){
        self.choose[2] = @"YES";
    }
}



@end
