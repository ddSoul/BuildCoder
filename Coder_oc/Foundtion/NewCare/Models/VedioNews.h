//
//  VedioNews.h
//  Coder_oc
//
//  Created by ddSoul on 17/1/9.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VedioNews : NSObject

/**
 描述图片
 */
@property (nonatomic, copy) NSString *cover;

/**
 视频地址
 */
@property (nonatomic, copy) NSString *mp4_url;

/**
 标题
 */
@property (nonatomic, copy) NSString *topic;

/**
 作者头像
 */
@property (nonatomic, copy) NSString *writerAvtarUrl;

/**
 作者
 */
@property (nonatomic, copy) NSString *writer;

/**
 阅读数
 */
@property (nonatomic, copy) NSString *readerCount;

/**
 评论数
 */
@property (nonatomic, copy) NSString *commentCount;


@end
