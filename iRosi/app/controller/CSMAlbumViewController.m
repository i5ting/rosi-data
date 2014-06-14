//
//  CSMAlbumViewController.m
//  iBeaconDemo
//
//  Created by sang alfred on 5/9/14.
//  Copyright (c) 2014 Christopher Mann. All rights reserved.
//

#import "CSMAlbumViewController.h"
#import "CSMImageInfoManager.h"
#import "CSMImageInfo.h"
#import "UIImageView+WebCache.h"
#import "ShowAllImageViewController.h"

@interface CSMAlbumViewController ()

@end

@implementation CSMAlbumViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSString *aid = [USER_DEFAULT objectForKey:@"cache_current_album_id"];
        if (aid) {
            _current_album_id = aid;
        }else{
            _current_album_id = @"1";
        }
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"首页";

    [self search_with_album_id];
    
    //
    [self add_guesture];
    
}

-(void)add_guesture{
    UISwipeGestureRecognizer *recognizer;
    recognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [[self view] addGestureRecognizer:recognizer];
    
    UISwipeGestureRecognizer *recognizer2;
    recognizer2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer2 setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [[self view] addGestureRecognizer:recognizer2];
    
    UITapGestureRecognizer *recognizer3;
    recognizer3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];

    [[self view] addGestureRecognizer:recognizer3];
}

-(void)tap:(UITapGestureRecognizer *)recognizer
{
    [self navigation_right_button_click:nil];
}

-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer{
    
    //如果往左滑
    
    if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft) {
        [self next_album: nil];
    }
    
    //如果往右滑
    if(recognizer.direction==UISwipeGestureRecognizerDirectionRight) {
        [self prev_album: nil];
    }
}

- (void)navigation_right_button_click:(id)sender
{
    ShowAllImageViewController *_list_vc = [[ShowAllImageViewController alloc] initWithAlbumId:_current_album_id];
    [self.navigationController pushViewController:_list_vc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self search_with_album_id];
    [textField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
     _current_album_id = textField.text;
    [self search_with_album_id];
    [textField resignFirstResponder];
    return YES;
}

- (void)search_with_album_id
{
    self.input_album_number_view.text = _current_album_id;
    
    [USER_DEFAULT setObject:_current_album_id forKey:@"cache_current_album_id"];
    
    CSMImageInfoManager *info = [CSMImageInfoManager sharedCSMImageInfoManager];
    CSMImageInfo *image = [info get_album_with_id:_current_album_id];
    NSLog(@"%@",image);
    
    if (image) {
        self.name_label.text = image.title;
        [self.face_image_view setImageWithURL:[NSURL URLWithString:image.url] placeholderImage:[UIImage imageNamed:@"TopViewRight"]];
        [self setTitle: [NSString stringWithFormat:@"专辑：%@",image.title]];
    }
}

-(IBAction)prev_album:(UIButton *)sender
{
    if ([_current_album_id intValue] <= 0) {
        return;
    }
    _current_album_id = [NSString stringWithFormat:@"%d",[_current_album_id intValue] - 1];
    [USER_DEFAULT setObject:_current_album_id forKey:@"cache_current_album_id"];
    [self search_with_album_id];
}

-(IBAction)next_album:(UIButton *)sender
{
    _current_album_id = [NSString stringWithFormat:@"%d",[_current_album_id intValue] + 1];
    [USER_DEFAULT setObject:_current_album_id forKey:@"cache_current_album_id"];
    [self search_with_album_id];
}


@end
