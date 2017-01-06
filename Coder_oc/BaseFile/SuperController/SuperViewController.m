//
//  SuperViewController.m
//  Coder_oc
//
//  Created by ddSoul on 17/1/6.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import "SuperViewController.h"
#import "UITextField+tool.h"

@interface SuperViewController ()<UITextFieldDelegate>

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
    
    
    UITextField *home_search = [[UITextField alloc] initWithFrame:CGRectMake(120, 20, 230, 34)];
    home_search.backgroundColor = [UIColor whiteColor];
    home_search.delegate = self;
    home_search.layer.cornerRadius = 5.0f;
    home_search.leftDistance = 40.0f;
    [home_search addleftImageView];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:home_search];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
