//
//  CSMFmdbBase.m
//  iBeaconDemo
//
//  Created by sang alfred on 5/9/14.
//  Copyright (c) 2014 Christopher Mann. All rights reserved.
//

#import "CSMFmdbBase.h"

@implementation CSMFmdbBase

-(id)init
{
    if (self = [super init]) {
        self.dbPath = [[NSBundle mainBundle] pathForResource:@"cache" ofType:@"sqlite3"];
        self.queue  = [FMDatabaseQueue databaseQueueWithPath: self.dbPath];
    }
    
    return self;
}

@end
