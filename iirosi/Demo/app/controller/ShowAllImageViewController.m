//
//  ShowAllImageViewController.m
//  SeeImagePhoto
//
//  Created by wolfman on 14-3-28.
//  Copyright (c) 2014年 WolfMan. All rights reserved.
//

#import "ShowAllImageViewController.h"
#import "CSMImageInfoManager.h"
#import "CSMImageInfo.h"
#import "AppDelegate.h"
#import "SDImageCache.h"
#import "MWPhotoBrowser.h"

#import "UIImageView+WebCache.h"


// 展示 帖子 图片1 图片2 图片3 图片4
// 展示 图片



@interface ShowAllImageViewController ()<UIGestureRecognizerDelegate>
{
    NSMutableArray * myImageUrlArr;
    NSString *_album_id;
    
}

@end

@implementation ShowAllImageViewController

- (id)initWithAlbumId:(NSString *)aid
{
    if (self = [super init]) {
        _album_id = aid;
    }
    
    return self;
}

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
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIScrollView * myScrollView = [[UIScrollView alloc] init];
    myScrollView.frame = self.view.bounds;
    
    [self.view addSubview: myScrollView];
    
    myImageUrlArr = [[NSMutableArray alloc] init];
    
    CSMImageInfoManager *info = [CSMImageInfoManager sharedCSMImageInfoManager];
    NSArray *r = [info get_images_with_album_id: _album_id];
    
    for (CSMImageInfo *image in r) {
        NSLog(@"%@",image);
         [myImageUrlArr addObject: image.url];
    }
    
    int BtnW = 70;
    int BtnWS = 10;
    int BtnX = 10;
    
    int BtnH = 70;
    int BtnHS = 10;
    int BtnY = 10;
    
    int i = 0;
    
    for (i = 0; i < [myImageUrlArr count]; i++ ) {
        UIImageView * imageview = [[UIImageView alloc] init];
        imageview.frame = CGRectMake( (BtnW+BtnWS) * (i%4) + BtnX , (BtnH+BtnHS) *(i/4) + BtnY, BtnW, BtnH );
        imageview.tag = 10000 + i;
        imageview.userInteractionEnabled = YES;
        // 内容模式
        imageview.clipsToBounds = YES;
        imageview.contentMode = UIViewContentModeScaleAspectFill;
        
//        [imageview s]
        [imageview setImageWithURL: [NSURL URLWithString: [myImageUrlArr objectAtIndex:i]] placeholderImage: [UIImage imageNamed:@"TopViewRight.png"] ];
//        [imageview setI];
        [imageview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(BtnClick:)] ];
        [myScrollView addSubview: imageview];
    }
    
    int getEndImageYH = (BtnH+BtnHS) *(i/4) + BtnY ;
    
    if ( getEndImageYH > myScrollView.frame.size.height ) {
        myScrollView.contentSize = CGSizeMake( myScrollView.frame.size.width , getEndImageYH + 80 );
    }else{
        myScrollView.contentSize = CGSizeMake( myScrollView.frame.size.width , myScrollView.frame.size.height + 1 );
    }
 
    UIButton *_right_btn = [self add_navigation_right_button:@""];
    _right_btn.hidden = NO;
    CGRect f = _right_btn.frame;
    f.size.width = 60;
    f.origin.x = 30;
    _right_btn.frame = f;
    [_right_btn setTitle:@"Next" forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
    if ( [self.view window] == nil ) {
        self.view = nil;
    }
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

-(void)BtnClick:(UITapGestureRecognizer *)imageTap
{
    NSLog(@"imageTag==%d", imageTap.view.tag );
    
    
    self.photos = [NSMutableArray array];
    
    for (int i = 0; i < [myImageUrlArr count]; i++) {
        // 替换为中等尺寸图片
        
        NSString * getImageStrUrl = [NSString stringWithFormat:@"%@", [myImageUrlArr objectAtIndex:i] ];
        
        [self.photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:getImageStrUrl]]];

    }
//
//    // 2.显示相册
//    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
//    browser.currentPhotoIndex = (imageTap.view.tag - 10000); // 弹出相册时显示的第一张图片是？
//    browser.photos = photos; // 设置所有的图片
//    [browser show];
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    
    // Set options
    browser.displayActionButton = YES; // Show action button to allow sharing, copying, etc (defaults to YES)
    browser.displayNavArrows = NO; // Whether to display left and right nav arrows on toolbar (defaults to NO)
    browser.displaySelectionButtons = NO; // Whether selection buttons are shown on each image (defaults to NO)
    browser.zoomPhotosToFill = YES; // Images that almost fill the screen will be initially zoomed to fill (defaults to YES)
    browser.alwaysShowControls = NO; // Allows to control whether the bars and controls are always visible or whether they fade away to show the photo full (defaults to NO)
    browser.enableGrid = YES; // Whether to allow the viewing of all the photo thumbnails on a grid (defaults to YES)
    browser.startOnGrid = NO; // Whether to start on the grid of thumbnails instead of the first photo (defaults to NO)
    browser.wantsFullScreenLayout = YES; // iOS 5 & 6 only: Decide if you want the photo browser full screen, i.e. whether the status bar is affected (defaults to YES)
    
    // Optionally set the current visible photo before displaying
    int currentPhotoIndex = (imageTap.view.tag - 10000); // 弹出相册时显示的第一张图片是？
    [browser setCurrentPhotoIndex: currentPhotoIndex];
    
    
    // Present
    [self.navigationController pushViewController:browser animated:YES];
}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.photos.count)
        return [self.photos objectAtIndex:index];
    return nil;
}


@end
