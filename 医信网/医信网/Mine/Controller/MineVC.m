//
//  MineVC.m
//  医信网
//
//  Created by yuhao on 16/10/8.
//  Copyright © 2016年 sjq. All rights reserved.
//

#import "MineVC.h"
#import "UIScrollView+HeaderScaleImage.h"
#import "UINavigationBar+PS.h"
#import "UIView+PS.h"
#import "PSBottomBar.h"
#import "Mfirstcell.h"
#define Max_OffsetY  50

#define WeakSelf(x)      __weak typeof (self) x = self

#define HalfF(x) ((x)/2.0f)

#define  kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define  kScreenHeight  [UIScreen mainScreen].bounds.size.height

#define  Statur_HEIGHT   [[UIApplication sharedApplication] statusBarFrame].size.height
#define  NAVIBAR_HEIGHT  (self.navigationController.navigationBar.frame.size.height)
#define  INVALID_VIEW_HEIGHT (Statur_HEIGHT + NAVIBAR_HEIGHT)


@interface MineVC ()<UITableViewDelegate, UITableViewDataSource>
{
    CGFloat _lastPosition;
}
@property (nonatomic,strong)PSBottomBar * bottomBar;
@property (nonatomic,strong)UIImageView * avatarView;
@property (nonatomic,strong)UILabel * messageLabel;
@property (nonatomic,strong)UIView * headBackView;
@property (nonatomic,strong)UIImageView * headImageView;
@property (nonatomic,strong)UITableView * displayTableView;
@property (nonatomic, retain)UITableView *tableview;
@end

@implementation MineVC
#pragma mark --
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //    [self scrollViewDidScroll:self.displayTableView];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar ps_reset];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createview];
    // Do any additional setup after loading the view.
}
#pragma mark -懒加载-
- (UITableView*)displayTableView
{
    if (!_displayTableView) {
        _displayTableView  = [[UITableView alloc] initWithFrame:self.view.bounds style:(UITableViewStylePlain)];
        _displayTableView.delegate = self;
        _displayTableView.dataSource = self;
        _displayTableView.showsVerticalScrollIndicator = NO;
    }
    return _displayTableView;
}

- (UIView*)headBackView
{
    if (!_headBackView) {
        _headBackView = [UIView new];
        _headBackView.userInteractionEnabled = YES;
        _headBackView.frame = CGRectMake(0, 0, kScreenWidth,200);
    }
    return _headBackView;
}

- (UIImageView*)headImageView
{
    if (!_headImageView)
    {
        _headImageView = [UIImageView new];
        _headImageView.image = [UIImage imageNamed:@"guide2.jpg"];
        _headImageView.contentMode = UIViewContentModeScaleAspectFill;
        _headImageView.clipsToBounds = YES;
        _headImageView.backgroundColor = [UIColor orangeColor];
    }
    return _headImageView;
}

- (UIImageView*)avatarView
{
    if (!_avatarView) {
        _avatarView = [UIImageView new];
        _avatarView.image = [UIImage imageNamed:@"8005_1x.png"];
        _avatarView.contentMode = UIViewContentModeScaleToFill;
        _avatarView.size = CGSizeMake(80, 80);
        [_avatarView setLayerWithCr:_avatarView.width / 2];
    }
    return _avatarView;
}

- (UILabel*)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [UILabel new];
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        _messageLabel.font = [UIFont systemFontOfSize:16];
        _messageLabel.textColor = [UIColor whiteColor];
    }
    return _messageLabel;
}
- (PSBottomBar*)bottomBar
{
    if (!_bottomBar) {
        
        WeakSelf(ws);
        _bottomBar = [[PSBottomBar alloc] initWithFrame:CGRectMake(0, kScreenHeight - HalfF(128),kScreenWidth , HalfF(128))];
        _bottomBar.block = ^(BottomBarType type)
        {
            [ws clickBottomBarEvent:type];
        };
    }
    return _bottomBar;
}

- (void)clickBottomBarEvent:(BottomBarType)type
{
    if (type == BottomBarType_Original)
    {
        [UIView animateWithDuration:0.2 animations:^{
            [self.navigationController.navigationBar ps_setTransformIdentity];
        }];
        
    }
    else if (type == BottomBarType_Up)
    {
        [UIView animateWithDuration:0.2 animations:^{
            [self.navigationController.navigationBar ps_setTranslationY:- INVALID_VIEW_HEIGHT];
        }];
    }
}

- (void)createview
{
    
    [self resetHeaderView];
    
    self.displayTableView.tableHeaderView = self.headBackView;
    [self.view addSubview:self.displayTableView];
    
  
    
//    _displayTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.bottomBar.height)];
//    
    
    //导航
    [self.navigationController.navigationBar ps_setBackgroundColor:[UIColor clearColor]];
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"左边" style:(UIBarButtonItemStylePlain) target:nil action:nil];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"右边" style:(UIBarButtonItemStylePlain) target:nil action:nil];

    
}
- (void)resetHeaderView
{
    self.headImageView.frame = self.headBackView.bounds;
    [self.headBackView addSubview:self.headImageView];
    
    self.avatarView.centerX = self.headBackView.centerX;
    self.avatarView.centerY = self.headBackView.centerY -  HalfF(70);
    [self.headBackView addSubview:self.avatarView];
    
    self.messageLabel.text = @"权志龙 : 13800138000";
    self.messageLabel.y = CGRectGetMaxY(self.avatarView.frame) + HalfF(20);
    self.messageLabel.size = CGSizeMake(kScreenWidth - HalfF(30), 30);
    self.messageLabel.centerX = self.headBackView.centerX;
    [self.headBackView addSubview:self.messageLabel];
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat offset_Y = scrollView.contentOffset.y;
    
    NSLog(@"上下偏移量 OffsetY:%f ->",offset_Y);
    
    //1.处理图片放大
    CGFloat imageH = self.headBackView.size.height;
    CGFloat imageW = kScreenWidth;
    
    //下拉
    if (offset_Y < 0)
    {
        CGFloat totalOffset = imageH + ABS(offset_Y);
        CGFloat f = totalOffset / imageH;
        
        //如果想下拉固定头部视图不动，y和h 是要等比都设置。如不需要则y可为0
        self.headImageView.frame = CGRectMake(-(imageW * f - imageW) * 0.5, offset_Y, imageW * f, totalOffset);
    }
    else
    {
        self.headImageView.frame = self.headBackView.bounds;
    }
    
    //2.处理导航颜色渐变  3.底部工具栏动画
    
    if (offset_Y > Max_OffsetY)
    {
        CGFloat alpha = MIN(1, 1 - ((Max_OffsetY + INVALID_VIEW_HEIGHT - offset_Y) / INVALID_VIEW_HEIGHT));
        
        [self.navigationController.navigationBar ps_setBackgroundColor:[NavigationBarBGColor colorWithAlphaComponent:alpha]];
        
        if (offset_Y - _lastPosition > 5)
        {
            //向上滚动
            _lastPosition = offset_Y;
            
            [self bottomForwardDownAnimation];
        }
        else if (_lastPosition - offset_Y > 5)
        {
            // 向下滚动
            _lastPosition = offset_Y;
            [self bottomForwardUpAnimation];
        }
        self.title = alpha > 0.8? @"我的":@"";
    }
    else
    {
        [self.navigationController.navigationBar ps_setBackgroundColor:[NavigationBarBGColor colorWithAlphaComponent:0]];
        
        [self bottomForwardUpAnimation];
    }
    
    //滚动至顶部
    
    if (offset_Y < 0) {
        [self bottomForwardUpAnimation];
        
    }
    
    //滚动至底部
    CGSize size = _displayTableView.contentSize;
    
    float y = offset_Y + _displayTableView.height;
    float h = size.height;
    float reload_distance = 10;
    
    if (y > h - _bottomBar.height + reload_distance)
    {
        [self bottomForwardUpAnimation];
    }
}

- (void)bottomForwardDownAnimation
{
    WeakSelf(ws);
    [UIView animateWithDuration:0.2 animations: ^{
        ws.bottomBar.transform = CGAffineTransformMakeTranslation(0, ws.bottomBar.height);
    } completion: ^(BOOL finished) {
    }];
}

- (void)bottomForwardUpAnimation
{
    WeakSelf(ws);
    [UIView animateWithDuration:0.2 animations: ^{
        ws.bottomBar.transform = CGAffineTransformIdentity;
    } completion: ^(BOOL finished) {
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 1;
    }
    if (section == 2) {
        return 3;
    }
    return 3;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}
//设置头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 30;
    }
    return 10;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *custom  = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 375, 30)];
    custom.backgroundColor = [UIColor colorWithRed:0.9451 green:0.9451 blue:0.9451 alpha:1.0];
    UILabel *headlabel = [[UILabel alloc]initWithFrame:CGRectZero];
    headlabel.backgroundColor = [UIColor clearColor];
    headlabel.opaque = NO;
    headlabel.textColor = [UIColor lightGrayColor];
    headlabel.highlightedTextColor = [UIColor whiteColor];
    headlabel.font  = [UIFont boldSystemFontOfSize:13];
    headlabel.frame = CGRectMake(10, 5, 100, 20);
    if (section ==0) {
        headlabel.text = @"我的医信";
    } else {
        headlabel.text = @"";
    }
    
    [custom addSubview:headlabel];
    return custom;
    
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return @"我的医信";
        
    }
    return nil;
}
//设置脚视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 ) {
        return 80;
    }
    return  50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        static NSString *cellstr = @"firstcell";
        Mfirstcell *Cell = [tableView dequeueReusableCellWithIdentifier:cellstr];
        Cell = [[Mfirstcell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellstr];
        return Cell;
    }
    
    
    
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
