//
//  CSMBaseViewController.m
//  iBeaconDemo
//
//  Created by sang alfred on 5/9/14.
//  Copyright (c) 2014 Christopher Mann. All rights reserved.
//

#import "CSMBaseViewController.h"

@interface CSMBaseViewController ()

@end

@implementation CSMBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)add_navigation_back_button
{
    //左侧按钮
    UIButton *backButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 25.0f, 25.0f)];
    //    UIImage *backImage = [[UIImage imageNamed:@"back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0.0, 0, 0.0f)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"back"]   forState:UIControlStateNormal];
    //    [backButton setTitle:@"Backss" forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(navigation_left_button_click:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = backButtonItem;
}

- (UIButton *)add_navigation_right_button:(NSString *)imageName
{
    //左侧按钮
    UIButton *rightButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 25.0f, 25.0f)];
    //    UIImage *backImage = [[UIImage imageNamed:@"back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0.0, 0, 0.0f)];
    [rightButton setBackgroundImage:[UIImage imageNamed:imageName]   forState:UIControlStateNormal];
    //    [backButton setTitle:@"Backss" forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(navigation_right_button_click:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem = backButtonItem;
    
    return rightButton;
}

- (void)navigation_right_button_click:(id)sender
{
    
    
}

-(void)navigation_left_button_click:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
