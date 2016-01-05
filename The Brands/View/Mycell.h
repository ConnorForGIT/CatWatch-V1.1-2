//
//  Mycell.h
//  IDailyWatch
//
//  Created by   赵东东 on 14-10-16.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@protocol MyCellDelegate <NSObject>

//协议方法
- (void)pushViewController:(UIViewController *)viewController count:(NSInteger)count;

@end

@interface Mycell : UITableViewCell<UICollectionViewDataSource, UICollectionViewDelegate>
//设置代理
@property (nonatomic, retain) id<MyCellDelegate>delegate;

@property(nonatomic , retain)UICollectionView *collectionView;


@property (nonatomic, retain)NSMutableArray *brandsArr;

@property (nonatomic, retain)NSMutableArray *brandsArr2;

@property(nonatomic, assign)NSInteger cellNumber;




@end
