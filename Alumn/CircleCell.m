//
//  CircleCell.m
//  scrollViewDamo
//
//  Created by 韩雪滢 on 8/26/16.
//  Copyright © 2016 小腊. All rights reserved.
//

#import "CircleCell.h"
#import "View+MASAdditions.h"
#import   "UIImageView+WebCache.h"


@interface CircleCell()
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation CircleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    // ****************************imgView
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.top.equalTo(self.contentView).offset(10);
        make.width.offset(60);
        make.height.offset(60);
        
    }];
    _imgView.layer.cornerRadius = _imgView.bounds.size.width / 2.0;
    _imgView.layer.masksToBounds = YES;
    
    // **************************nameLabel
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgView).offset(10);
        make.top.equalTo(self.contentView).offset(40);
        make.size.mas_equalTo(CGSizeMake(30, 60));
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

- (void)setImgUrl:(NSString *)imgUrl{
    _imgUrl = imgUrl;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:_imgUrl]];
}

@end

