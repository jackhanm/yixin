//
//  hospitalroot.m
//  医信网
//
//  Created by yuhao on 2017/1/14.
//  Copyright © 2017年 sjq. All rights reserved.
//

#import "hospitalroot.h"
#import "HACursor.h"
#import "UIView+Extension.h"
#import "HATestView.h"
#import "webview.h"
@interface hospitalroot ()
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSMutableArray *pageViews;
@end

@implementation hospitalroot

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"健康分类";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"fenxiang"] style:UIBarButtonItemStylePlain target:self action:@selector(rightAct)];
    [self createview];
    

    // Do any additional setup after loading the view.
}
- (void)createview
{
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
    
    //不允许有重复的标题
    self.titles = @[@" 医院官网",@"健康分类"];
    
    HACursor *cursor = [[HACursor alloc]init];
    cursor.frame = CGRectMake(0, 64, self.view.width, 45);
    cursor.titles = self.titles;
    cursor.pageViews = [self createPageViews];
    //设置根滚动视图的高度
    cursor.rootScrollViewHeight = self.view.frame.size.height -109;
    //默认值是白色
    cursor.titleNormalColor = [UIColor whiteColor];
    //默认值是白色
    cursor.titleSelectedColor = [UIColor redColor];
    //是否显示排序按钮
    cursor.showSortbutton = YES;
    //默认的最小值是5，小于默认值的话按默认值设置
    cursor.minFontSize = 11;
    //默认的最大值是25，小于默认值的话按默认值设置，大于默认值按设置的值处理
    cursor.maxFontSize = 20;
    //cursor.isGraduallyChangFont = NO;
    //在isGraduallyChangFont为NO的时候，isGraduallyChangColor不会有效果
    cursor.isGraduallyChangColor = NO;
    [self.view addSubview:cursor];
    
}
- (NSMutableArray *)createPageViews{
    NSMutableArray *pageViews = [NSMutableArray array];
    for (NSInteger i = 0; i < self.titles.count; i++) {
        
        
        if (i == 0) {
            HATestView *textView = [[HATestView alloc]initWithurl:@"http://www.yixinw.cn/y.html"];
            [pageViews addObject:textView];
            
        }
        if (i == 1) {
            HATestView *textView = [[HATestView alloc]initWithurl:@"http://www.yixinw.cn/h.html"];
            [pageViews addObject:textView];
            
        }
        
        
    }
    return pageViews;
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
