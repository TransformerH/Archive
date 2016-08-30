//
//  Circle_FindVC.m
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/30.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import "Circle_FindVC.h"

#import "CollectionViewCell_F.h"
#import "CollectionReusableView_F.h"

#import "Section_FModel.h"
#import "Cell_FModel.h"

#define UISCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)



@interface Circle_FindVC ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView_F;

//下面数组用来存放头部标题；
@property(strong,nonatomic) NSMutableArray *headerArray;
@property (nonatomic,strong) Section_FModel *section;
//里面存放section对象，也就是section模型，模型由SectionModel定义；
@property (nonatomic,strong) NSMutableArray *dataSectionArray;
//里面存放cell对象，也就是cell模型，模型由CellModel定义；
@property (nonatomic,strong) NSMutableArray *dataCellArray;
@property(nonatomic,strong) NSMutableArray *cellImageArr;
@property(nonatomic,strong) NSMutableArray *cellDescArr;
@property(nonatomic,strong) CollectionReusableView_F *reusableView;

@end

@implementation Circle_FindVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //进行CollectionView和Cell的绑定
    [self.collectionView_F registerClass:[CollectionViewCell_F class]  forCellWithReuseIdentifier:@"CollectionCell"];
    self.collectionView_F.backgroundColor = [UIColor clearColor];//背景透明
    //加入头部视图；
    [self.collectionView_F registerClass:[CollectionReusableView_F class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
    
}



#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    Section_FModel *sec = [self.dataSectionArray objectAtIndex:section];
    return  sec.cellArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionViewCell_F *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    //找到某一个具体的Section；
    Section_FModel *sec = [self.dataSectionArray objectAtIndex:indexPath.section];
    //找到Section中的cell数组中某个具体的cell；
    Cell_FModel *cel = [sec.cellArray objectAtIndex:indexPath.row];
    //取出数据；
    cell.imageView.image = [UIImage imageNamed:cel.cellImage];
    cell.descLabel.text = cel.cellDesc;
    
    return cell;
}

//有多少个section；
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    //有多少个一维数组；
    return self.dataSectionArray.count;
}

//加载头部标题；
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    self.reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
    //就打印出当前section的值；
    self.reusableView.title.text = [self.headerArray objectAtIndex:indexPath.section];
    return self.reusableView;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((UISCREEN_WIDTH - 40) / 2, (UISCREEN_WIDTH - 40) / 2);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10,25,25,15);
}



- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(self.collectionView_F.frame.size.width, 50);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

#pragma mark -- Lazy Load 懒加载
//要添加的图片从这里面选；
//这里进行的是懒加载，要先去判断，没有的话才去进行实例化;

- (NSMutableArray *)dataSectionArray{
    if (!_dataSectionArray){
        //CollectionView有一个Section数组；
        _dataSectionArray = [[NSMutableArray alloc] initWithCapacity:1];//1个；
        for (int i = 0; i < 1; i++) {
            //默认初始有两个Section；
            _dataCellArray = [[NSMutableArray alloc] initWithCapacity:6];//2个；
            for (int j = 0; j < 6; j++) {
                //默认一个section中有6个cell；
                //初始化每一个cell；
                Cell_FModel *cellModel = [[Cell_FModel alloc] init];
                cellModel.cellImage = self.cellImageArr[j];
                cellModel.cellDesc = self.cellDescArr[j];
                
                //添加到cell数组中；
                [_dataCellArray addObject:cellModel];
            }//for;
            //初始化section；
            Section_FModel *sectionModel = [[Section_FModel alloc] init];
            sectionModel.sectionName = self.headerArray[i];
            //把上面生成的cell数组加入到section数组中；
            sectionModel.cellArray = _dataCellArray;
            //增加一个section；
            [_dataSectionArray addObject:sectionModel];
        }//for;
    }
    return _dataSectionArray;
}

//这里标题的添加也使用懒加载；
- (NSMutableArray *)headerArray{
    
    if (!_headerArray) {
        self.headerArray = [[NSMutableArray alloc] initWithObjects:@"第一个",@"第二个", nil];
    }
    return _headerArray;
}

- (NSMutableArray *)cellImageArr{
    
    if (!_cellImageArr) {
        self.cellImageArr = [[NSMutableArray alloc] initWithObjects:@"0",@"1",@"2",@"3",@"4",@"5",nil];
    }
    return _cellImageArr;
}

- (NSMutableArray *)cellDescArr{
    if (!_cellDescArr) {
        self.cellDescArr = [[NSMutableArray alloc] initWithObjects:@"第0个",@"第1个",@"第2个",@"第3个",@"第4个",@"添加",nil];
    }
    return _cellDescArr;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //取出是某一个section；
    Section_FModel *sec = [self.dataSectionArray objectAtIndex:indexPath.section];
    if ((indexPath.row == sec.cellArray.count - 1)) {
        NSLog(@"点击最后一个cell，执行添加操作");
        //初始化一个新的cell模型；
        Cell_FModel *cel = [[Cell_FModel alloc] init];
        cel.cellImage = @"2";
        cel.cellDesc = @"再来一个";
        //获取当前的cell数组；
        self.dataCellArray = sec.cellArray;
        //把新创建的cell插入到最后一个之前；
        [self.dataCellArray insertObject:cel atIndex:self.dataCellArray.count - 1];
        //更新UI；
        [self.collectionView_F reloadData];
    }else{
        NSLog(@"第%ld个section,点击图片%ld",indexPath.section,indexPath.row);
        //在storyborad中使用push方法不拖线跳转
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *VC = [sb instantiateViewControllerWithIdentifier:@"circleDeatil"];
        [self.navigationController pushViewController:VC animated:YES];
    }
}





- (void)deleteCellButtonPressed: (id)sender{
    
    CollectionViewCell_F *cell = (CollectionViewCell_F *)[sender superview];//获取cell
    NSIndexPath *indexpath = [self.collectionView_F indexPathForCell:cell];//获取cell对应的indexpath;
    //删除cell；
    Section_FModel *sec = [self.dataSectionArray objectAtIndex:indexpath.section];
    [sec.cellArray removeObjectAtIndex:indexpath.row];
    
    [self.collectionView_F reloadData];
    NSLog(@"删除按钮，section:%ld ,   row: %ld",(long)indexpath.section,(long)indexpath.row);
}
- (IBAction)backItemClicked:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


@end


