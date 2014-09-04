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
        self.layer.borderColor = [[UIColor colorWithRed:0.169 green:0.353 blue:0.514 alpha:1]CGColor];
        self.layer.borderWidth = 3.0f;
		self.textAlignment = NSTextAlignmentCenter;
		self.returnKeyType = UIReturnKeyGo;
		self.font = [UIFont fontWithName:@"Avenir" size:18.0f];
		self.placeholder = @"Search by hashtag: #ExampleTag";
		self.tintColor = [UIColor whiteColor];
        self.autocorrectionType = UITextAutocorrectionTypeNo;
        
    }
    return self;
}

@end
