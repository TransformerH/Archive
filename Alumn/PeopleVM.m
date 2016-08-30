//
//  PeopleVM.m
//  PeopleListDemo
//
//  Created by 韩雪滢 on 8/28/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import "PeopleVM.h"

@interface PeopleVM()

@property (copy,nonatomic) NSArray *people;
@property (copy,nonatomic) NSDictionary *me;

@end

@implementation PeopleVM

- (NSArray*)getPeople{
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"peopleList" ofType:@"plist" ];
    _people = [[NSArray alloc] initWithContentsOfFile:plistPath];
    
    return _people;
}

- (NSArray*)matchPeople:(NSArray *)choose{
    
    NSMutableArray *matchResult = [[NSMutableArray alloc] init];
    
    NSString *peoplePlistPath = [[NSBundle mainBundle] pathForResource:@"peopleList" ofType:@"plist" ];
    _people = [[NSArray alloc] initWithContentsOfFile:peoplePlistPath];
    
    NSString *mePlistPath = [[NSBundle mainBundle] pathForResource:@"MeList" ofType:@"plist" ];
    _me = [[NSDictionary alloc] initWithContentsOfFile:mePlistPath];
    
    
    if([choose[0] isEqualToString:@"YES"]){
        //处理同院系的  不同年级的  不同城市的
        for(int i = 0;i < _people.count;i++){
            if([[_people[i] valueForKey:@"major"] isEqualToString:[_me valueForKey:@"major"]]){
                [matchResult addObject:_people[i]];
            }
        }
        
        if([choose[1] isEqualToString:@"YES"]){
            //处理已经同院系的，选取同年级的  不同城市的
            for(int j = 0;j < matchResult.count; j++){
                if(![[matchResult[j] valueForKey:@"class"] isEqualToString:[_me valueForKey:@"class"]]){
                    [matchResult removeObject:matchResult[j]];
                }
            }
            
            if([choose[2] isEqualToString:@"YES"]){
                //处理已经 同院系 同年级的，选取 同城市的
                for(int k = 0;k < matchResult.count;k++){
                    if(![[matchResult[k] valueForKey:@"city"] isEqualToString:[_me valueForKey:@"city"]]){
                        [matchResult removeObject:matchResult[k]];
                    }
                }
            }
            
        }else if([choose[2] isEqualToString:@"YES"]){
            //处理已经同院系的，选取 同城市的 不同年级的
            for(int m =0 ;m < matchResult.count;m++){
                if(![[matchResult[m] valueForKey:@"city"] isEqualToString:[_me valueForKey:@"city"]]){
                    [matchResult removeObject:matchResult[m]];
                }
            }
        }
        
    }else if([choose[1] isEqualToString:@"YES"]){
        //处理同年级的  不同院系的  不同城市的
        for(int n = 0;n < _people.count; n++){
            if([[_people[n] valueForKey:@"class"] isEqualToString:[_me valueForKey:@"class"]]){
                [matchResult addObject:_people[n]];
            }
        }
        
        if([choose[2] isEqualToString:@"YES"]){
            //处理同年级的  不同院系的 同城市的
            for(int n1 = 0;n1 < matchResult.count;n1++){
                if(![[matchResult[n1] valueForKey:@"city"] isEqualToString:[_me valueForKey:@"city"]]){
                    [matchResult removeObject:matchResult[n1]];
                }
            }
        }
        
    }else if([choose[2] isEqualToString:@"YES"]){
        //处理 不同年级的  不同院系的  同一城市的
        for(int b = 0;b < _people.count ; b++){
            if([[_people[b] valueForKey:@"city"] isEqualToString:[_me valueForKey:@"city"]]){
                [matchResult addObject:_people[b]];
            }
        }
    }
    
    //不进行处理  不同院系  不同年级   不同城市
    /*
    //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@  NSLog 输出  测试结果
    for(int i = 0;i < matchResult.count;i++){
        NSLog(@"%@",matchResult[i]);
    }*/
    
    return matchResult;
}

- (NSArray*)searchPeople:(NSString *)message{
    NSMutableArray *result = [NSMutableArray alloc];
    NSString *peoplePlistPath = [[NSBundle mainBundle] pathForResource:@"peopleList" ofType:@"plist" ];
    _people = [[NSArray alloc] initWithContentsOfFile:peoplePlistPath];
    
    for(int i = 0;i < _people.count;i++){
        if([message isEqualToString:[_people[i] valueForKey:@"name"]]){
            [result addObject:_people[i]];
        }
        if([message isEqualToString:[_people[i] valueForKey:@"major"]]){
            [result addObject:_people[i]];
        }
        if([message isEqualToString:[_people[i] valueForKey:@"class"]]){
            [result addObject:_people[i]];
        }
        if([message isEqualToString:[_people[i] valueForKey:@"job"]]){
            [result addObject:_people[i]];
        }
        if([message isEqualToString:[_people[i] valueForKey:@"city"]]){
            [result addObject:_people[i]];
        }

    }
    
    return result;
}

@end
