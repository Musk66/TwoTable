//
//  MLProductsVc.m
//  FMeituan
//
//  Created by tiger on 16/7/7.
//  Copyright © 2016年 tqsoft. All rights reserved.
//

#import "MLProductsVc.h"

#define kScreenWidth self.view.frame.size.width
#define kScreenHeight self.view.frame.size.height

@interface MLProductsVc () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *productTb;
@property (nonatomic, strong) NSArray *productsList;
@property (nonatomic, strong) NSArray *categoryList;
@property(nonatomic, assign)BOOL isScrollUp;//是否是向上滚动
@property(nonatomic, assign)CGFloat lastOffsetY;//滚动即将结束时scrollView的偏移量
@end

@implementation MLProductsVc

- (void)viewDidLoad {
    [super viewDidLoad];
    _isScrollUp = false;
    _lastOffsetY = 0;
    [self createTableView];
    [self configData];
}

- (void)configData {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Goods" ofType:@"plist"];
    _productsList = [NSArray arrayWithContentsOfFile:filePath][1];
    _categoryList = [NSArray arrayWithContentsOfFile:filePath][0];
}

- (void)createTableView
{
    _productTb = [[UITableView alloc] initWithFrame:CGRectMake(kScreenWidth*0.25, 64, kScreenWidth*0.75, kScreenHeight) style:UITableViewStyleGrouped];
    _productTb.showsHorizontalScrollIndicator = NO;
    _productTb.showsVerticalScrollIndicator = NO;
    _productTb.delegate = self;
    _productTb.dataSource = self;
    [self setView:_productTb];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.categoryList.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.productsList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
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
    NSString *pReuseId = @"pCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:pReuseId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:pReuseId];
    }
    cell.textLabel.text = self.productsList[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.categoryList[section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 28;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(nonnull UIView *)view forSection:(NSInteger)section {
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(willDisplayHeaderView:)] && !_isScrollUp && _productTb.isDecelerating) {
        [self.delegate willDisplayHeaderView:section];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(didEndDisplayingHeaderView:)] && _isScrollUp && _productTb.isDecelerating) {
        [self.delegate didEndDisplayingHeaderView:section];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _isScrollUp = _lastOffsetY < scrollView.contentOffset.y;
    _lastOffsetY = scrollView.contentOffset.y;
}

- (void)scrollToSelectedIndexPath:(NSIndexPath *)indexPath {
    [self.productTb scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
