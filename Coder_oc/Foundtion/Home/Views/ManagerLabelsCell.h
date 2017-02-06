//
//  ManagerLabelsCell.h
//  Coder_oc
//
//  Created by ddSoul on 17/2/4.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CollectionGestureDelegate <NSObject>

- (void)cellGestureAction:(UIGestureRecognizer *)gestureRecognizer;

@end

@interface ManagerLabelsCell : UICollectionViewCell

@property (nonatomic, assign) id<CollectionGestureDelegate> delegate;

- (void)showDeleteButton;

@end
