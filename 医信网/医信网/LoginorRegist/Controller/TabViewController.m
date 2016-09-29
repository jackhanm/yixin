//
//  TabViewController.m
//  医信网
//
//  Created by yuhao on 16/9/25.
//  Copyright © 2016年 sjq. All rights reserved.
//

#import "TabViewController.h"
#import "Nearhopital.h"
#import "healBook.h"
#import "heallist.h"
#import "hospitalWeb.h"
#import "CustomUserLocationViewController.h"
@interface TabViewController ()
@property (nonatomic ,retain)Nearhopital *nearhospital;
@property (nonatomic, retain)healBook *healbook;
@property (nonatomic, retain)heallist *heallist;
@property (nonatomic, retain)hospitalWeb *hospitalWeb;
@end

@implementation TabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createview];
    
    // Do any additional setup after loading the view.
}
- (void)createview
{
    _nearhospital = [[Nearhopital alloc]init];
    UINavigationController *nearhospitalnc = [[UINavigationController alloc]initWithRootViewController:_nearhospital];
    nearhospitalnc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"附近医院" image:[UIImage imageNamed:@"fujinyiyuan"] tag:10000];
    
    _healbook = [[healBook alloc]init];
    UINavigationController *healbooknc = [[UINavigationController alloc]initWithRootViewController:_healbook];
    healbooknc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"健康书籍" image:[UIImage imageNamed:@"jiankangshuji"] tag:10001];

    _heallist = [[heallist alloc]init];
    UINavigationController *heallistnc = [[UINavigationController alloc]initWithRootViewController:_heallist];
    heallistnc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"健康分类" image:[UIImage imageNamed:@"jiankangfenlei"] tag:10002];

    
    _hospitalWeb = [[hospitalWeb alloc]init];
    UINavigationController *hospitalWebnc = [[UINavigationController alloc]initWithRootViewController:_hospitalWeb];
    hospitalWebnc.tabBarItem = [[UITabBarItem alloc]initWithTitle:@"医院官网" image:[UIImage imageNamed:@"yiyuanguanwang"] tag:10003];
    
    self.viewControllers =  [NSArray arrayWithObjects:hospitalWebnc,nearhospitalnc,heallistnc, healbooknc,nil];
    self.tabBar.tintColor = [UIColor colorWithRed:0.2784 green:0.6039 blue:0.8667 alpha:1.0];
    
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
