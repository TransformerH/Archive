//
//  CellModel.h
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/23.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cell_FModel: NSObject

//定义cell中的图片；
@property(nonatomic,strong) NSString *cellImage;
//定义cell中的描述文字；
@property(nonatomic,strong) NSString *cellDesc;
@property(nonatomic,strong) NSString *ID;
-(id)initWithDict:(NSDictionary *)dict;
+(id)modelWithDict:(NSDictionary *)dict;

@end
