//
//  FMDBHelper.h
//  meou
//
//  Created by 邓西亮 on 16/8/30.
//  Copyright © 2016年 北京麦芯科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseQueue.h"

@interface FMDBHelper : NSObject

+(FMDBHelper *)sharedInstance;
-(void)inDatabase:(void(^)(FMDatabase*))block;

@end
