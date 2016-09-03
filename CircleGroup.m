//
//  CircleGroup.m
//  Alumn
//
//  Created by Dorangefly Liu on 16/9/2.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import "CircleGroup.h"

@implementation CircleGroup
-(id)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+(id)circleGroupWithDict:(NSDictionary *)dict
{
    return [[self alloc]initWithDict:dict];
}

@end
