//
//  ShowAllImageViewController.h
//  SeeImagePhoto
//
//  Created by wolfman on 14-3-28.
//  Copyright (c) 2014年 WolfMan. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "MWPhotoBrowser.h"
#import "CSMBaseViewController.h"

@interface ShowAllImageViewController : CSMBaseViewController

@property(nonatomic,strong) NSMutableArray *photos;

- (id)initWithAlbumId:(NSString *)aid;

@end
