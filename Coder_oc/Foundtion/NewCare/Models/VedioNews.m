//
//  VedioNews.m
//  Coder_oc
//
//  Created by ddSoul on 17/1/9.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import "VedioNews.h"

@implementation VedioNews

- (NSString *)description
{
    NSArray *keys = @[@"cover",@"mp4_url",@"topic",@"writerAvtarUrl",@"writer",@"readerCount",@"commentCount"];
    return [self dictionaryWithValuesForKeys:keys].description;
}

@end
