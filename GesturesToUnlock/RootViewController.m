//
//  RootViewController.m
//  GesturesToUnlock
//
//  Created by CalvinCheung on 2017/1/17.
//  Copyright © 2017年 CalvinCheung. All rights reserved.
//

#import "RootViewController.h"

#import "GestureViewController.h"
#import "GestureVerifyViewController.h"
#import "PCCircleViewConst.h"

@interface RootViewController ()<UIAlertViewDelegate>

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"GesturesUnlock";
    [self setBtn];
}


- (void)setBtn{
    
    NSArray *arr = @[@"设置手势密码",@"手势密码登录",@"验证手势密码",@"修改手势密码"];
    for (int i = 0; i < 4; i++) {
        UIButton *btn = [UIButton new];
        btn.frame = CGRectMake(20, 100 + i*40 + i*20, [UIScreen mainScreen].bounds.size.width-40, 40);
        btn.layer.cornerRadius = 5;
        btn.tag = i+1;
        [btn setBackgroundColor:[UIColor colorWithRed:246/255 green:246/255 blue:246/255 alpha:1]];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(BtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

- (void)BtnClicked:(UIButton *)Btn{
    
    switch (Btn.tag) {
        case 1:
        {
            GestureViewController *gestureVc = [[GestureViewController alloc] init];
            gestureVc.type = GestureViewControllerTypeSetting;
            [self.navigationController pushViewController:gestureVc animated:YES];
        }
            break;
        case 2:
        {
            if ([[PCCircleViewConst getGestureWithKey:gestureFinalSaveKey] length]) {
                GestureViewController *gestureVc = [[GestureViewController alloc] init];
                [gestureVc setType:GestureViewControllerTypeLogin];
                [self.navigationController pushViewController:gestureVc animated:YES];
            } else {
                UIAlertView *alerView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"暂未设置手势密码，是否前往设置" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
                [alerView show];
            }
        }
            break;
        case 3:
        {
            GestureVerifyViewController *gestureVerifyVc = [[GestureVerifyViewController alloc] init];
            [self.navigationController pushViewController:gestureVerifyVc animated:YES];
        }
            break;
            
        case 4:
        {
            GestureVerifyViewController *gestureVerifyVc = [[GestureVerifyViewController alloc] init];
            gestureVerifyVc.isToSetNewGesture = YES;
            [self.navigationController pushViewController:gestureVerifyVc animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        GestureViewController *gestureVc = [[GestureViewController alloc] init];
        gestureVc.type = GestureViewControllerTypeSetting;
        [self.navigationController pushViewController:gestureVc animated:YES];
    }
}

@end
