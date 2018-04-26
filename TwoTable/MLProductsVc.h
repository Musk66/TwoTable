//
//  MLProductsVc.h
//  FMeituan
//
//  Created by tiger on 16/7/7.
//  Copyright © 2016年 tqsoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MLProductsDelegate <NSObject>

@optional
- (void)willDisplayHeaderView:(NSInteger)section;
- (void)didEndDisplayingHeaderView:(NSInteger)section;

@end

@interface MLProductsVc : UIViewController

@property (nonatomic, weak) id<MLProductsDelegate> delegate;

/**
 *  当CategoryTableView滚动时,ProductsTableView跟随滚动至指定section
 *
 *  @param section
 */
- (void)scrollToSelectedIndexPath:(NSIndexPath *)indexPath;

@end
