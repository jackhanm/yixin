//
//  MineVC.m
//  医信网
//
//  Created by yuhao on 16/10/8.
//  Copyright © 2016年 sjq. All rights reserved.
//

#import "MineVC.h"
#import "UIScrollView+HeaderScaleImage.h"
@interface MineVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, retain)UITableView *tableview;
@end

@implementation MineVC
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createview];
    // Do any additional setup after loading the view.
}
- (void)createview
{
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    [self.view addSubview:view1];
    self.tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 375, 667 - 64 -49) style:UITableViewStyleGrouped];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.yz_headerScaleImage = [UIImage imageNamed:@"8005_1x.png"];
    UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 375, 200)];
//    headview.backgroundColor = [UIColor yellowColor];
    headview.backgroundColor = [UIColor clearColor];
    self.tableview.tableHeaderView = headview;
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(150, 30, 100, 100)];
    imageview.layer.cornerRadius = 50;
//    imageview.image = [UIImage imageNamed:@"guide1.jpg"];
    imageview.userInteractionEnabled  = YES;
    imageview.backgroundColor = [UIColor orangeColor];
    [headview addSubview:imageview];
    
    [self.view addSubview:self.tableview];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    } else {
    return 3;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
//设置头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0;
    }
    return 10;
}

//设置脚视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return  50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellstr = @"cell";
    UITableViewCell *Cell =[tableView dequeueReusableCellWithIdentifier:cellstr];
    if (Cell == nil) {
        Cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellstr];
        
    }
    return Cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
