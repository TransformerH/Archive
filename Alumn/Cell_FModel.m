//
//  CellModel.m
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/23.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import "Cell_FModel.h"

@implementation Cell_FModel
-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        //        [self setValuesForKeysWithDictionary:dict];
        self.ID = [dict objectForKey:@"id"];
        self.cellDesc = [dict objectForKey:@"name"];
        //self.cellImage = [dict objectForKey:@"image_urls"];
        
    }
    return self;
}

+(id)modelWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

@end
