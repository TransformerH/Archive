//
//  DemoVC5.h
//  Alumn
//
//  Created by Dorangefly Liu on 16/8/28.
//  Copyright © 2016年 刘龙飞. All rights reserved.
//

#import <UIKit/UIKit.h>
static int page =1;
static const NSString* ID;
@interface DemoVC5 : UITableViewController

+(void) setID:(NSString *) id;
+(NSString *) getID;
@end
