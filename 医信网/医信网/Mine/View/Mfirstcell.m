//
//  Mfirstcell.m
//  医信网
//
//  Created by yuhao on 16/11/4.
//  Copyright © 2016年 sjq. All rights reserved.
//

#import "Mfirstcell.h"



@interface Mfirstcell ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end
@implementation Mfirstcell




- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createview];
    }
    return self;
}
-(void)createview
{
    //uicollectviewLayout 是一个抽象类,我们一般使用他的子类UICollectionViewFlowLayout
    UICollectionViewFlowLayout *flowl = [[UICollectionViewFlowLayout alloc]init];
    //行间距
    //注意:1, 系统会尽可能靠近此参数,并保证不会小于
    //垂直与滑动方向即为行!
    flowl.minimumLineSpacing = 10;
    
    //列间距
    flowl.minimumInteritemSpacing = 30;
    //单元大小
    flowl.itemSize = CGSizeMake(80, 60);
     //与屏幕四周的间距
    flowl.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
//    flowl.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    //滚动方向
    flowl.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    
    UICollectionView *collectionV = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 375, 80) collectionViewLayout:flowl];
    collectionV.backgroundColor = [UIColor purpleColor];
    collectionV.delegate = self;
    collectionV.dataSource = self;
    [self addSubview:collectionV];
    
    //注册自定义cell
    [collectionV registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];

    
    
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *Cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    Cell.backgroundColor = [UIColor orangeColor];
    return Cell;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.chenwei.frame = CGRectMake(10, 10, 100, 30);
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
