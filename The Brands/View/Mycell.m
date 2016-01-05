//
//  Mycell.m
//  IDailyWatch
//
//  Created by   赵东东 on 14-10-16.
//  Copyright (c) 2014年 lanou3g.com 蓝鸥科技. All rights reserved.
//

#import "Mycell.h"
#import "InBrandsController.h"
#import "UIImageView+WebCache.h"
#import "InMycell.h"
#import "Product.h"

@interface Mycell ()

@property (nonatomic, retain)UICollectionViewFlowLayout *layout;

@end
@implementation Mycell


- (void)awakeFromNib {
    
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.brandsArr = [NSMutableArray array];
        self.brandsArr2 = [NSMutableArray array];
        
       self.layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.itemSize = CGSizeMake(155, 60);
        _layout.sectionInset = UIEdgeInsetsMake(3, 3, 3, 3);
        _layout.minimumInteritemSpacing = 0.5;
        _layout.minimumLineSpacing = 1;
        
     self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 2, 320, 250)collectionViewLayout:_layout];
     _collectionView.delegate = self;
     _collectionView.dataSource = self;
     _collectionView.bounces = NO;
    _collectionView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:_collectionView];
    [_collectionView release];
    [_collectionView registerClass:[InMycell class] forCellWithReuseIdentifier:@"kk"];
        
    
        

    }
    return self;
}

- (void)setBrandsArr:(NSMutableArray *)brandsArr
{
    if (_brandsArr != brandsArr) {
        [_brandsArr release];
        _brandsArr = [brandsArr retain];
    }
    
    [_collectionView reloadData];
    _collectionView.frame = CGRectMake(0, 2, 320, _layout.collectionViewContentSize.height);
    
}


//实现协议
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    NSString *path = [_brandsArr[indexPath.row] photo];
    for (int i = 0; i < _brandsArr2.count; i++) {
        Product *rp = [[Product alloc]init];
        rp = [_brandsArr2 objectAtIndex:i];
        NSString *str2 = rp.photo;
        
        if ([str2 isEqualToString:path]) {
            InBrandsController *inBrandsVC = [[InBrandsController alloc] init];
            
            ///  传MOdel
            inBrandsVC.productModel = rp;
            inBrandsVC.count = i;
            [self.delegate pushViewController:inBrandsVC count:i];
        
            [inBrandsVC release];
            
        }
        
    }
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.brandsArr.count;

}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    InMycell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"kk" forIndexPath:indexPath];
    [cell.picture setImageWithURL:[NSURL URLWithString:[_brandsArr[indexPath.row] photo]]placeholderImage:[UIImage imageNamed:@"加载.PNG"]];
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
