//
//  RootViewController.m
//  Demo
//
//  Created by 许宗城 on 16/3/14.
//  Copyright © 2016年 许宗城. All rights reserved.
//

#import "RootViewController.h"
#import "WebViewController.h"
#import "RWWebProgressView.h"

@interface RootViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray *dataSource;

@property (nonatomic, weak) RWWebProgressView *progressView;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
//    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
//    tableView.delegate = self;
//    tableView.dataSource = self;
//    [self.view addSubview:tableView];
//    self.tableView = tableView;
    
    
    RWWebProgressView *view = [[RWWebProgressView alloc] init];
    view.bounds = CGRectMake(0, 0, self.view.frame.size.width, 3);
    view.center = CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    [self.view addSubview:view];
    
    
    self.progressView = view;
}

- (void)rightAction {
    WebViewController *vc = [[WebViewController alloc] initWithURLString:@"https://www.baidu.com"];
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"CELLID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
