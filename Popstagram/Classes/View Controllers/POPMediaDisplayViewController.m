//
//  POPMediaDisplayViewController.m
//  Popstagram
//
//  Created by Mitchell Porter on 8/25/14.
//  Copyright (c) 2014 Mitchell Porter. All rights reserved.
//

#import "POPMediaDisplayViewController.h"

@interface POPMediaDisplayViewController ()

@end

@implementation POPMediaDisplayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"standard resolution image: %@", self.standardResolutionImage);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
