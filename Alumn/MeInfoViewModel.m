//
//  MeInfoViewModel.m
//  MeInfoDemo
//
//  Created by 韩雪滢 on 9/1/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import "MeInfoViewModel.h"

@implementation MeInfoViewModel

- (void)setInfo:(NSDictionary *)personDic{
    
    self.city = [[personDic valueForKey:@"_source"] valueForKey:@"city"];
    self.name = [[personDic valueForKey:@"_source"] valueForKey:@"name"];
    self.job = [[personDic valueForKey:@"_source"] valueForKey:@"job"];
    self.major = [[personDic valueForKey:@"_source"] valueForKey:@"faculty"];
    self.company = [[personDic valueForKey:@"_source"] valueForKey:@"company"];
    self.classNum = [[personDic valueForKey:@"_source"] valueForKey:@"major"];
    self.enrollYear = [[NSString alloc] initWithFormat:@"%@",[[personDic valueForKey:@"_source"] valueForKey:@"admission_year"]];
    self.school = @"东南大学";
    
    NSLog (@"User city:%@ ; name:%@ ; job:%@ ; faculty:%@ ; company:%@ ; major:%@ ; enrollYear:%@ ; school:%@",self.city,self.name,self.job,self.major,self.company,self.classNum,self.enrollYear,self.school);
}

+ (MeInfoViewModel*)getMeInfoVM{
    static dispatch_once_t dec;
    static MeInfoViewModel *meInfoVM;
    dispatch_once(&dec, ^{
        meInfoVM = [[MeInfoViewModel alloc] init];
    });
    
    return meInfoVM;
}

@end
