//
//  CSMImageInfoManager.h
//  iBeaconDemo
//
//  Created by sang alfred on 5/9/14.
//  Copyright (c) 2014 Christopher Mann. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSMFmdbBase.h"
#import "CSMImageInfo.h"

@interface CSMImageInfoManager : CSMFmdbBase

SINGLETON_FOR_HEADER(CSMImageInfoManager)

/**
 * 获得所有专辑
 */
- (NSArray *)get_all_album;

/**
 * 根据专辑id获得所有图片信息
 */
- (NSArray *)get_images_with_album_id: (NSString *)album_id;


- (int)get_all_album_count;

/**
 * 根据专辑id获得所有图片信息
 */
- (CSMImageInfo *)get_album_with_id: (NSString *)album_id;

@end
