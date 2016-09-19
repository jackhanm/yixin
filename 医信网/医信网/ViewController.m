//
//  ViewController.m
//  医信网
//
//  Created by sjq on 15/12/29.
//  Copyright © 2015年 sjq. All rights reserved.
//

#import "ViewController.h"

#define UIScreenW   [UIScreen mainScreen].bounds.size.width
#define UIScreenH    [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UIWebViewDelegate>
{
    UIWebView *webView;
}
@end

@implementation ViewController

#pragma mark -----------------
#pragma mark -LifeStyle Methods
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, UIScreenW, UIScreenH)];
    [webView setUserInteractionEnabled:YES];
    webView.delegate=self;
    [webView setOpaque:NO];
    [webView setScalesPageToFit:YES];
    [self.view addSubview:webView];
    
    //加载网页的方式
    //1.创建并加载远程网页
    NSURL *url = [NSURL URLWithString:@"http://www.yixinw.cn"];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    NSURL *url = [NSURL URLWithString:@"http://www.yixinw.cn"];
    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    if ((([httpResponse statusCode]/100) == 2)) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        
        [ webView loadRequest:[ NSURLRequest requestWithURL: url]];
        webView.delegate = self;
    } else {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:
                                  NSLocalizedString(@"HTTP Error",
                                                    @"Error message displayed when receving a connection error.")
                                                             forKey:NSLocalizedDescriptionKey];
        NSError *error = [NSError errorWithDomain:@"HTTP" code:[httpResponse statusCode] userInfo:userInfo];
        
        if ([error code] == 404) {
            webView.hidden = YES;
        }
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
