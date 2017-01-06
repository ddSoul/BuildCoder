//
//  CoderRegistViewController.m
//  Coder_oc
//
//  Created by ddSoul on 17/1/4.
//  Copyright © 2017年 dxl. All rights reserved.
//

#import "CoderRegistViewController.h"
#import "Mine.h"

@interface CoderRegistViewController ()
@property (strong, nonatomic) IBOutlet UITextField *username;
@property (strong, nonatomic) IBOutlet UITextField *password;
@property (strong, nonatomic) IBOutlet UITextField *passwordAgain;
@property (strong, nonatomic) IBOutlet UIButton *regsiterButton;
- (IBAction)regsiterButton:(UIButton *)sender;

@end

@implementation CoderRegistViewController

#pragma mark ---bar隐藏处理
- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)regsiterButton:(UIButton *)sender {
    
    if (!self.username.text.length) {
        [ProgressHUD showErrorWithString:@"请输入昵称"];
        return;
    }
    
    if (!self.password.text.length) {
        [ProgressHUD showErrorWithString:@"请输入密码"];
        return;
    }
    
    if (!self.passwordAgain.text.length) {
        [ProgressHUD showErrorWithString:@"请确认密码"];
        return;
    }
    
    if (![self.passwordAgain.text isEqualToString:self.password.text]) {
        [ProgressHUD showErrorWithString:@"请保持两次输入的密码一致"];
        return;
    }
    
    BmobObject *gameScore = [BmobObject objectWithClassName:@"UserInfo"];
    [gameScore setObject:self.username.text forKey:@"username"];
    [gameScore setObject:self.passwordAgain.text forKey:@"password"];
    [gameScore saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        //进行操作
        NSLog(@"________%d————————————%@",isSuccessful,gameScore);
        if (isSuccessful) {
             Mine *mine = [Mine new];
            NSString *objectId = gameScore.objectId;
            NSString *userName = [gameScore objectForKey:@"username"];
            mine.objectId = objectId;
            mine.username = userName;
            BOOL success = [NSKeyedArchiver archiveRootObject:mine toFile:KmineFilePath];
            if (success) {
                [ProgressHUD showSuccessWithString:@"注册成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }

        }
       
        
    }];

    
    
}
@end
