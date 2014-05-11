//
//  CSMBaseViewController.h
//  iBeaconDemo
//
//  Created by sang alfred on 5/9/14.
//  Copyright (c) 2014 Christopher Mann. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSMBaseViewController : UIViewController


- (void)add_navigation_back_button;

- (UIButton *)add_navigation_right_button:(NSString *)imageName;

- (void)navigation_right_button_click:(id)sender;

- (void)navigation_left_button_click:(id)sender;

@end
