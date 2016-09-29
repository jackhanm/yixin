//
//  GuideviewController.m
//  医信网
//
//  Created by yuhao on 16/9/27.
//  Copyright © 2016年 sjq. All rights reserved.
//

#import "GuideviewController.h"
#define WIDGHT [[UIScreen mainScreen] bounds].size.width
#define WIDTHSIXP 375.000000
#define HEIGHTSIXP 667.000000
#define HEIGHT  [[UIScreen mainScreen] bounds].size.height
@interface GuideviewController ()
{
    void(^_myBlock)();
}
@end

@implementation GuideviewController
- (void)dealloc
{
    Block_release(_myBlock);
    [super dealloc];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self createview];
    
    
    
    // Do any additional setup after loading the view.
}
- (void)sendblock:(void (^)(void))block
{
    //    block();
    _myBlock = Block_copy(block);
    
}
- (void)createview
{
//    self.view.backgroundColor = [UIColor whiteColor];
    UIScrollView *srollview  = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDGHT, HEIGHT)];
    srollview.contentSize = CGSizeMake(WIDGHT * 3, HEIGHT);
    [srollview setPagingEnabled:YES];
    [srollview setBounces:NO];
    
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDGHT, HEIGHT)];
    [imageview setImage:[UIImage imageNamed:@"guide1.jpg"]];
    [srollview addSubview:imageview];
    
    
    
    UIImageView *imageview1 = [[UIImageView alloc]initWithFrame:CGRectMake(WIDGHT, 0, WIDGHT, HEIGHT)];
    [imageview1 setImage:[UIImage imageNamed:@"guide2.jpg"]];
    [srollview addSubview:imageview1];
  
    
    
    UIImageView *imageview2 = [[UIImageView alloc]initWithFrame:CGRectMake(WIDGHT * 2, 0, WIDGHT, HEIGHT)];
    [imageview2 setImage:[UIImage imageNamed:@"guide3.jpg"]];
     imageview2.userInteractionEnabled = YES;
    [srollview addSubview:imageview2];
  
    
//    UIImageView *imageview3 = [[UIImageView alloc]initWithFrame:CGRectMake(WIDGHT * 3, 0, WIDGHT, HEIGHT)];
//    [imageview3 setImage:[UIImage imageNamed:@"乡间.jpg"]];
//    [srollview addSubview:imageview3];
//   
//    
//    UIImageView *imageview4 = [[UIImageView alloc]initWithFrame:CGRectMake(WIDGHT * 4, 0, WIDGHT, HEIGHT)];
//    [imageview4 setImage:[UIImage imageNamed:@"风景.jpg"]];
//    imageview4.userInteractionEnabled = YES;
//    [srollview addSubview:imageview4];
   
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];//在imageview3上加载一个透明的button
    //    button.backgroundColor = [UIColor blueColor];
    
    [button setFrame:CGRectMake(70/ WIDTHSIXP * WIDGHT, 580 / HEIGHTSIXP * HEIGHT, 230 / WIDTHSIXP * WIDGHT, 50 / HEIGHTSIXP * HEIGHT)];
    [button addTarget:self action:@selector(firstpressed) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"开 始 使 用" forState:UIControlStateNormal];
    [button setTitleColor: [UIColor colorWithRed:0.615 green:1.000 blue:0.971 alpha:1.000] forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor colorWithRed:0.615 green:1.000 blue:0.971 alpha:1.000] forState:UIControlStateNormal];
    button.backgroundColor = [UIColor colorWithWhite:0.542 alpha:1.000];
    button.backgroundColor = [UIColor clearColor];
    button.layer.borderWidth = 1;
    button.layer.borderColor = [[UIColor colorWithRed:0.615 green:1.000 blue:0.971 alpha:1.000]CGColor];
    button.layer.cornerRadius = 15 / HEIGHTSIXP * HEIGHT;
    
    
    
    [imageview2 addSubview:button];
    
    [self.view addSubview:srollview];

}
- (void)firstpressed{
    
    NSLog(@"111");
    _myBlock();
    
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
