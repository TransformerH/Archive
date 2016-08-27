//
//  CardCell.m
//  scrollViewDamo
//
//  Created by 韩雪滢 on 8/25/16.
//  Copyright © 2016 小腊. All rights reserved.
//

#import "CardCell.h"
#import "View+MASAdditions.h"

@interface CardCell()

@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *majorLabel;
@property (strong, nonatomic) IBOutlet UILabel *classLabel;
@property (strong, nonatomic) IBOutlet UILabel *jobLabel;



@end

@implementation CardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    //*********************** imgView
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(15);
        make.left.equalTo(self.contentView).offset(15);
        make.width.offset(60);
        make.height.offset(60);
    }];
    _imgView.layer.cornerRadius = 30;
    _imgView.layer.masksToBounds = YES;

    
    //*********************** Labels
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgView).offset(20);
        make.top.equalTo(self.contentView).offset(40);
       // make.size.mas_equalTo(CGSizeMake(30, 60));
    }];
    
    [_majorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel).offset(4);
    }];
    
    [_classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.majorLabel);
        make.left.equalTo(self.majorLabel).offset(8);
    }];
    
    [_jobLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel);
        make.top.equalTo(self.majorLabel).offset(4);
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setName:(NSString *)name{
    if(![_name isEqualToString:name]){
        _name = [name copy];
        _nameLabel.text = _name;
    }
}

- (void)setJob:(NSString *)job{
    if(![_job isEqualToString:job]){
        _job = [job copy];
        _jobLabel.text = _job;
    }
}

- (void)setMajor:(NSString *)major{
    if(![_major isEqualToString:major]){
        _major = [major copy];
        _majorLabel.text = _major;
    }
}

- (void)setClassNum:(NSString *)classNum{
    if(![_classNum isEqualToString:classNum]){
        _classNum = [classNum copy];
        _classLabel.text = _classNum;
    }
}

@end
