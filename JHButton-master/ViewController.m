//
//  ViewController.m
//  JHButton-master
//
//  Created by RayJiang on 2017/9/28.
//  Copyright © 2017年 rayjiang. All rights reserved.
//

#import "ViewController.h"
#import "JHButton.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) JHButton *codeButton;
@property (weak, nonatomic) IBOutlet JHButton *storyboardButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self p_createCodeButton];
    [self p_createTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)p_createCodeButton {
    _codeButton = [[JHButton alloc] initWithFrame:CGRectMake(15, 64 + 30, self.view.bounds.size.width * 0.4, 35)];
    _codeButton.normalText = @"Code button";
    [_codeButton addTarget:self action:@selector(clickCodeButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_codeButton];
}

- (void)p_createTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + 90, self.view.bounds.size.height, 200) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [tableView setTableFooterView:[UIView new]];
    [self.view addSubview:tableView];
}

#pragma mark - Button

- (void)clickCodeButton:(JHButton *)button {
    [button startAnimation];
}

- (IBAction)clickStoryboardButton:(JHButton *)sender {
    [sender startAnimation];
}

#pragma mark - Table view delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *titleArray = @[@"停止", @"停止 - 成功", @"停止 - 失败"];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = titleArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [self.codeButton stopAnimation];
            [self.storyboardButton stopAnimation];
            break;
        case 1:
            [self.codeButton stopAnimationWithText:@"成功"];
            [self.storyboardButton stopAnimationWithText:@"成功"];
            break;
        case 2:
            [self.codeButton stopAnimationWithErrorText:@"失败"];
            [self.storyboardButton stopAnimationWithErrorText:@"失败"];
            break;
        default:
            break;
    }
}

@end
