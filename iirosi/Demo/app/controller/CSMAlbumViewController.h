//
//  CSMAlbumViewController.h
//  iBeaconDemo
//
//  Created by sang alfred on 5/9/14.
//  Copyright (c) 2014 Christopher Mann. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSMBaseViewController.h"

@interface CSMAlbumViewController : CSMBaseViewController<UITextFieldDelegate>
{
    NSString *_current_album_id;
}

@property(nonatomic,retain,readwrite) IBOutlet UIImageView *face_image_view;
@property(nonatomic,retain,readwrite) IBOutlet UILabel *name_label;
@property(nonatomic,retain,readwrite) IBOutlet UITextField *input_album_number_view;


@property(nonatomic,retain,readwrite) IBOutlet UIButton *left_btn;
@property(nonatomic,retain,readwrite) IBOutlet UIButton *right_btn;

-(IBAction)prev_album:(UIButton *)sender;
-(IBAction)next_album:(UIButton *)sender;

@end
