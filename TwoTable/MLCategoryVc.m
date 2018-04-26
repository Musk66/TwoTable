//
//  MLCategoryVc.m
//  FMeituan
//
//  Created by tiger on 16/7/7.
//  Copyright © 2016年 tqsoft. All rights reserved.
//

#import "MLCategoryVc.h"
#import "MLProductsVc.h"

#define kScreenWidth self.view.frame.size.width
#define kScreenHeight self.view.frame.size.height

@interface MLCategoryVc () <UITableViewDelegate, UITableViewDataSource, MLProductsDelegate>
@property (nonatomic, strong) MLProductsVc *productsVc;
@property (nonatomic, strong) UITableView *categoryTb;
@property (nonatomic, strong) NSArray *categoryList;
@end

@implementation MLCategoryVc

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor lightGrayColor];
    [self createTableView];
    [self addChildVc];
}

- (NSArray *)categoryList {
    if (!_categoryList) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Goods" ofType:@"plist"];
        _categoryList = [NSArray arrayWithContentsOfFile:filePath][0];
    }
    return _categoryList;
}

- (void)addChildVc {
    _productsVc = [[MLProductsVc alloc] init];
    _productsVc.delegate = self;
    [self addChildViewController:_productsVc];
    [self.view addSubview:_productsVc.view];
}

- (void)createTableView
{
    _categoryTb = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth*0.25, kScreenHeight) style:UITableViewStylePlain];
    _categoryTb.showsHorizontalScrollIndicator = NO;
    _categoryTb.showsVerticalScrollIndicator = NO;
    _categoryTb.delegate = self;
    _categoryTb.dataSource = self;
    [self.view addSubview:_categoryTb];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categoryList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cReuseId = @"cCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cReuseId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cReuseId];
    }
    cell.textLabel.text = self.categoryList[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_productsVc) {
        [_productsVc scrollToSelectedIndexPath:indexPath];
    }
}

#pragma mark - MLProductsDelegate

- (void)willDisplayHeaderView:(NSInteger)section {
    [self.categoryTb selectRowAtIndexPath:[NSIndexPath indexPathForRow:section inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

- (void)didEndDisplayingHeaderView:(NSInteger)section {
    [self.categoryTb selectRowAtIndexPath:[NSIndexPath indexPathForRow:section + 1 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
