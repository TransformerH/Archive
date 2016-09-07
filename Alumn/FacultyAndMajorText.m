//
//  FacultyAndMajorText.m
//  RegisterDemoTwo
//
//  Created by 韩雪滢 on 9/7/16.
//  Copyright © 2016 韩雪滢. All rights reserved.
//

#import "FacultyAndMajorText.h"
#import "TextSender.h"

@interface FacultyAndMajorText()

@property (nonatomic,strong) TextSender *sender;

@end

@implementation FacultyAndMajorText
{
    UIToolbar *inputAccessoryView;
}

@synthesize facultiesAndMajors;
@synthesize facultyArray;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
    }
    
    [self getArrays];
    return self;
}

- (void)setSelectRow:(NSInteger)index{
    if(index >= 0){
        [pickView selectRow:index inComponent:0 animated:YES];
    }
}
- (void)drawRect:(CGRect)rect{
    pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 200, 320, 120)];
    pickView.dataSource = self;
    pickView.delegate = self;
    self.inputView = pickView;
    self.text = self.facultyArray[0];
}

- (NSArray*)getCurrentArray{
    
    self.sender = [TextSender getSender];
    if([self.sender getFacultyOrMajor]){
        return self.facultyArray;
    }else{
        return [self.facultiesAndMajors valueForKey:[self.sender getFaculty]];
    }
    
}

#pragma mark - UIPickerView dataSource,delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [[self getCurrentArray] count];
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [[self getCurrentArray] objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.text = [[self getCurrentArray] objectAtIndex:row];
}

#pragma mark - inputAccessoryView with toolbar
- (BOOL)canBecomeFirstResponder{
    return YES;
}

- (void)done:(id)sender{
    
    if([self.sender getFacultyOrMajor]){
      
                NSLog(@"%@",self.text);
                [self.sender setFaculty:self.text];
        [self.sender setFacultyOrMajor:NO];
    }else{
        [self.sender setFacultyOrMajor:YES];
    }
    [self resignFirstResponder];
    [super resignFirstResponder];
}

- (UIView*)inputAccessoryView{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
        return nil;
    }else{
        if(!inputAccessoryView){
            inputAccessoryView = [[UIToolbar alloc] init];
            inputAccessoryView.barStyle = UIBarStyleBlackTranslucent;
            inputAccessoryView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            [inputAccessoryView sizeToFit];
            CGRect frame = inputAccessoryView.frame;
            frame.size.height = 30.0f;
            inputAccessoryView.frame = frame;
            
            UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
            UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
            
            NSArray *array = [NSArray arrayWithObjects:flexibleSpaceLeft,doneBtn,nil];
            [inputAccessoryView setItems:array];
        }
        return inputAccessoryView;
    }
}



- (void)getArrays{
    self.facultyArray = [[NSMutableArray alloc] init];
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"majorList" ofType:@"plist"];
    self.facultiesAndMajors = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
    
    NSLog(@"all majors %@",self.facultiesAndMajors);

    
    for(NSString *key in self.facultiesAndMajors.allKeys){
        [self.facultyArray addObject:key];
    }
    
    NSLog(@"all faculties  %@",self.facultyArray);
}

@end
