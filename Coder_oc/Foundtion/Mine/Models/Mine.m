//
//  Mine.m
//  Coder_oc
//
//  Created by ddSoul on 17/1/4.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import "Mine.h"

#define CoderUserinfoID   @"objectId"   //用于归档解档的时候用的键名
#define CoderUserinfoName   @"username"   //用于归档解档的时候用的键名
#define CoderUserloginState   @"loginState"   //用于归档解档的时候用的键名


@implementation Mine


#pragma mark -- Coding
//编码
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.objectId forKey:CoderUserinfoID];
    [aCoder encodeObject:self.username forKey:CoderUserloginState];

}
//解码
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if(self)
    {
        self.objectId = [aDecoder decodeObjectForKey:CoderUserinfoID];
        self.username = [aDecoder decodeObjectForKey:CoderUserinfoName];
    }
    return self;
}

@end
