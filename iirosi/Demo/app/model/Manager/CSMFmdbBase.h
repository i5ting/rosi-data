//
//  CSMFmdbBase.h
//  iBeaconDemo
//
//  Created by sang alfred on 5/9/14.
//  Copyright (c) 2014 Christopher Mann. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"


@interface CSMFmdbBase : NSObject

@property(nonatomic,retain,readwrite) FMDatabaseQueue *queue;
@property(nonatomic,retain,readwrite) NSString *dbPath;

@end
