//
//  News.h
//  Coder_oc
//
//  Created by ddSoul on 17/1/6.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FootModel.h"

typedef NS_ENUM(NSInteger ,HomeCellType){
    bigImageType = 0,
    smallImageType,
    defultType
};

@interface News : NSObject

@property (nonatomic, strong) NSArray<NSString *> *imageArray;

@property (nonatomic, copy) NSString *title;

@property (nonatomic, strong) FootModel *typeinfo;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, assign) NSInteger type;

@end
