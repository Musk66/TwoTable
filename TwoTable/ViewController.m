//
//  ViewController.m
//  FMeituan
//
//  Created by tiger on 16/7/7.
//  Copyright © 2016年 tqsoft. All rights reserved.
//

#import "ViewController.h"
#import "MLCategoryVc.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView66;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addSwitchBtn];
    //[self loadWebView];
}

- (void)loadWebView {
    [_webView66 loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.weibo.com"]]];
    UIImageView *ig = [[UIImageView alloc] init];
    ig.image =[UIImage imageNamed:@"mb_登录"];
}

- (void)addSwitchBtn {
    UIButton *switchBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 60, 20)];
    [switchBtn setTitle:@"商品" forState:UIControlStateNormal];
    [switchBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [switchBtn setBackgroundColor:[UIColor brownColor]];
    [switchBtn addTarget:self action:@selector(switchVc) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:switchBtn];
}

- (void)switchVc {
    MLCategoryVc *categoryVc = [[MLCategoryVc alloc] init];
    [self.navigationController showViewController:categoryVc sender:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
