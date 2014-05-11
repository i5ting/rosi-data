//
//  CSMImageInfoManager.m
//  iBeaconDemo
//
//  Created by sang alfred on 5/9/14.
//  Copyright (c) 2014 Christopher Mann. All rights reserved.
//

#import "CSMImageInfoManager.h"
#import "CSMImageInfo.h"
#import "FMDB.h"
#import "Base64.h"

#define base64_seed @"alfred"


#define FMDBQuickCheck(SomeBool) { if (!(SomeBool)) { NSLog(@"Failure on line %d", __LINE__); abort(); } }




@implementation CSMImageInfoManager

SINGLETON_FOR_CLASS(CSMImageInfoManager)

- (id)init
{
    if (self = [super init]) {
        
    }
    
    return self;
}
/**
 * 获得所有专辑
 */
- (NSArray *)get_all_album
{
    NSMutableArray *result = [NSMutableArray array];
    
    [self.queue inDatabase:^(FMDatabase *adb) {

        int count = 0;
        FMResultSet *rsl = [adb executeQuery:@"select * from image_infos where face_image = 1"];
        while ([rsl next]) {
            count++;
        
            CSMImageInfo *image = [CSMImageInfo new];
            image.m_id              = [rsl intForColumn:@"id"];
            image.path              = [rsl stringForColumn:@"path"];
            image.url               = [[[rsl stringForColumn:@"url"] base64DecodedString] stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"_%@",base64_seed] withString:@""];
            image.title             = [rsl stringForColumn:@"title"];
            image.order_i           = [rsl intForColumn:@"order_i"];
            image.order_s           =[rsl stringForColumn:@"order_s"];
            image.is_face_image     = [rsl intForColumn:@"face_image"]==1?YES:NO;
            
            [result addObject:image];
            image = nil;
            
        }
        
    
    }];
    

    return result;
}

- (int)get_all_album_count
{
        
    NSMutableArray *result = [NSMutableArray array];
    NSString *count;
    [self.queue inDatabase:^(FMDatabase *adb) {
        
        int count = 0;
        FMResultSet *rs = [adb executeQuery:@"select count(0) from image_infos where face_image = 1"];
        
        count = [rs stringForColumnIndex:0];
    }];
    
    
    return [count intValue];
}

/**
 * 根据专辑id获得所有图片信息
 */
- (CSMImageInfo *)get_album_with_id: (NSString *)album_id
{
    NSString *sql = [NSString stringWithFormat:@"select * from image_infos where title = 'ROSI-%@' and face_image=1",album_id];
    __block CSMImageInfo *image =  [CSMImageInfo new];
    
    [self.queue inDatabase:^(FMDatabase *adb) {
        FMResultSet *rsl = [adb executeQuery: sql];

        while (rsl.next) {
            image.m_id              = [rsl intForColumn:@"id"];
            image.path              = [rsl stringForColumn:@"path"];
            image.url               = [[[rsl stringForColumn:@"url"] base64DecodedString] stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"_%@",base64_seed] withString:@""];
            image.title             = [rsl stringForColumn:@"title"];
            image.order_i           = [rsl intForColumn:@"order_i"];
            image.order_s           =[rsl stringForColumn:@"order_s"];
            image.is_face_image     = [rsl intForColumn:@"face_image"]==1?YES:NO;
        }
    }];
    
    return image;
}


/**
 * 根据专辑id获得所有图片信息
 */
- (NSArray *)get_images_with_album_id: (NSString *)album_id
{
    NSString *title = [NSString stringWithFormat:@"ROSI-%@",album_id];
    NSMutableArray *result = [NSMutableArray array];
    
    [self.queue inDatabase:^(FMDatabase *adb) {
        FMResultSet *rsl = [adb executeQuery:@"select * from image_infos where title = ?",title];
        while ([rsl next]) {
            CSMImageInfo *image = [CSMImageInfo new];
            image.m_id              = [rsl intForColumn:@"id"];
            image.path              = [rsl stringForColumn:@"path"];
            image.url               = [[[rsl stringForColumn:@"url"] base64DecodedString] stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"_%@",base64_seed] withString:@""];
            image.title             = [rsl stringForColumn:@"title"];
            image.order_i           = [rsl intForColumn:@"order_i"];
            image.order_s           =[rsl stringForColumn:@"order_s"];
            image.is_face_image     = [rsl intForColumn:@"face_image"]==1?YES:NO;
            
            [result addObject:image];
            image = nil;
            
        }
    }];
    
    return result;
}




@end
