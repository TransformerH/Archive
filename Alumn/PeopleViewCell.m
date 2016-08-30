//
//  PeopleViewCell.m
//  PeopleListDemo
//
//  Created by 韩雪滢 on 8/27/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import "PeopleViewCell.h"

@interface PeopleViewCell()

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *majorLabel;
@property (strong, nonatomic) IBOutlet UILabel *classLabel;
@property (strong, nonatomic) IBOutlet UILabel *jobClass;
@property (strong, nonatomic) IBOutlet UILabel *cityLabel;
@property (strong, nonatomic) IBOutlet UIImageView *userImg;

@end

@implementation PeopleViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setName:(NSString*)n{
    if(![n isEqualToString:_name]){
        _name=[n copy];
        self.nameLabel.text=_name;
    }
}
- (void)setMajor:(NSString*)n{
    if(![n isEqualToString:_major]){
        _major=[n copy];
        self.majorLabel.text=_major;
    }
}

- (void)setClassNum:(NSString*)n{
    if(![n isEqualToString:_classNum]){
        _classNum=[n copy];
        self.classLabel.text=_classNum;
    }
}

- (void)setJob:(NSString*)n{
    if(![n isEqualToString:_job]){
        _job=[n copy];
        self.jobClass.text=_job;
    }
}

- (void)setCity:(NSString*)n{
    if(![n isEqualToString:_city]){
        _city=[n copy];
        self.cityLabel.text=_city;
    }
}


@end
