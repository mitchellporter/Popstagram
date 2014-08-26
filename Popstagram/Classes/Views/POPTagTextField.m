//
//  POPTagTextField.m
//  Popstagram
//
//  Created by Mitchell Porter on 8/25/14.
//  Copyright (c) 2014 Mitchell Porter. All rights reserved.
//

#import "POPTagTextField.h"

@implementation POPTagTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //Customize the tag text field
        self.backgroundColor = [UIColor whiteColor];
		self.textColor = [UIColor blackColor];
        self.layer.cornerRadius = 8.0f;
        self.layer.borderColor = [[UIColor blueColor]CGColor];
        self.layer.borderWidth = 3.0f;
		self.textAlignment = NSTextAlignmentCenter;
		self.returnKeyType = UIReturnKeyGo;
		self.font = [UIFont fontWithName:@"Avenir" size:18.0f];
		self.placeholder = @"Search by hash tag: #ExampleTag";
		self.tintColor = [UIColor whiteColor];
    }
    return self;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
