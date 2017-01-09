//
//  SuperViewController.m
//  Coder_oc
//
//  Created by ddSoul on 17/1/6.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import "SuperViewController.h"
#import "UITextField+tool.h"

@interface SuperViewController ()
@end

@implementation SuperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)configeHomeNavgationItem
{
    self.title = @"";
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]] forBarMetrics:UIBarMetricsDefault];
    
    UIImageView *home_logo = [[UIImageView alloc] initWithFrame:CGRectMake(15, 20, 100, 20)];
    home_logo.image = [UIImage imageNamed:@"logo"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:home_logo];
    
    UIButton *rightItenBoderButton = [[UIButton alloc] initWithFrame:CGRectMake(120, 20, 230, 34)];
    rightItenBoderButton.backgroundColor = [UIColor whiteColor];
    rightItenBoderButton.layer.cornerRadius = 5;
    [rightItenBoderButton addTarget:self action:@selector(toSearchVc) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightItenBoderButton];

}

- (void)toSearchVc{
    NSLog(@"");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
