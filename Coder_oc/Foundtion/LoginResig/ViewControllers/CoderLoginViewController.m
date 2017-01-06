//
//  CoderLoginViewController.m
//  Coder_oc
//
//  Created by ddSoul on 17/1/4.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import "CoderLoginViewController.h"
#import "CoderRegistViewController.h"
#import "Mine.h"

@interface CoderLoginViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *userName;
@property (strong, nonatomic) IBOutlet UITextField *password;

- (IBAction)loginButton:(UIButton *)sender;

- (IBAction)gotoRes:(UIButton *)sender;

@end

@implementation CoderLoginViewController

#pragma mark ---bar隐藏处理
- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    // Do any additional setup after loading the view from its nib.
}

- (void)initUI
{
    self.password.delegate = self;
    self.userName.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginButton:(UIButton *)sender {
    
    if (!self.userName.text.length) {
        [ProgressHUD showErrorWithString:@"请输入用户名"];
        return;
    }
    
    if (!self.password.text.length) {
        [ProgressHUD showErrorWithString:@"请输入密码"];
        return;
    }
    
    Mine *mineModle = [NSKeyedUnarchiver unarchiveObjectWithFile:KmineFilePath];
    
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"UserInfo"];
    [bquery getObjectInBackgroundWithId:mineModle.objectId block:^(BmobObject *object, NSError *error){
        
        if (error) {
            [ProgressHUD showErrorWithString:@"登录失败"];
        }else{
            if (object) {
                NSString *passwordSever = [object objectForKey:@"password"];
                if ([passwordSever isEqualToString:self.password.text]) {
                    [ProgressHUD showSuccessWithString:@"登陆成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [ProgressHUD showErrorWithString:@"密码输入error了"];
                }
            }
        }
        
    }];
}

- (IBAction)gotoRes:(UIButton *)sender {
    
    CoderRegistViewController *push = [[CoderRegistViewController alloc] init];
    [self.navigationController pushViewController:push animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
