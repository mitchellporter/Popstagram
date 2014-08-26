//
//  POPMediaDisplayViewController.m
//  Popstagram
//
//  Created by Mitchell Porter on 8/25/14.
//  Copyright (c) 2014 Mitchell Porter. All rights reserved.
//

#import "POPMediaDisplayViewController.h"

@interface POPMediaDisplayViewController ()

@property (nonatomic) UIImageView *lowResolutionImageView;

@end

@implementation POPMediaDisplayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Execute various setup methods
    [self setupStandardResolutionImageView];
}

- (void)setupStandardResolutionImageView
{
    self.lowResolutionImageView = [[UIImageView alloc]initWithFrame:CGRectMake(7, 70, 306, 306)];
    self.lowResolutionImageView.image = self.lowResolutionImage;
    [self.view addSubview:self.lowResolutionImageView];
}

@end
