//
//  FMDBHelper.m
//  meou
//
//  Created by 邓西亮 on 16/8/30.
//  Copyright © 2016年 北京麦芯科技有限公司. All rights reserved.
//

#import "FMDBHelper.h"


@implementation FMDBHelper

{
    FMDatabaseQueue* queue;
}

-(id)init
{
    self = [super init];
    if(self){
        NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"mineData.sqlite"];
        queue = [FMDatabaseQueue databaseQueueWithPath:path];
    }
    return self;
}

+(FMDBHelper *)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

-(void)inDatabase:(void(^)(FMDatabase*))block
{
    [queue inDatabase:^(FMDatabase *db){
        block(db);
    }];
}

@end
