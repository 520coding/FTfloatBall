//
//  FTViewController.m
//  FTfloatBall
//
//  Created by 1085192695@qq.com on 08/07/2020.
//  Copyright (c) 2020 1085192695@qq.com. All rights reserved.
//


#import "FTViewController.h"
#import "FTfloatBall.h"
@interface FTViewController ()

@property (nonatomic, strong) FTfloatBall *floatView;

@end

@implementation FTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    FTfloatBall *fbv = [FTfloatBall getFloatBall];
    [fbv initWithFrame:CGRectMake(0, 200, 100, 100) baseImage:@"moon"];
    fbv.layer.cornerRadius = 50;
    fbv.layer.borderWidth = 2;
    fbv.layer.borderColor = [UIColor whiteColor].CGColor;

    NSMutableArray *butArray = [[NSMutableArray alloc]init];
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 80, 80)];
    button1.backgroundColor = [UIColor grayColor];
    [button1 setTitle:@"账户" forState:UIControlStateNormal];
    button1.titleLabel.font = [UIFont systemFontOfSize:20];
    button1.layer.cornerRadius = 40;
    button1.tag = 1;
    [butArray addObject:button1];

    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 80, 80)];
    button2.backgroundColor = [UIColor grayColor];
    button2.layer.cornerRadius = 40;
    [button2 setTitle:@"客服" forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont systemFontOfSize:20];
    button2.tag = 2;
    [butArray addObject:button2];

    [fbv setButtonArray:butArray];
    _floatView = fbv;
    
    __weak typeof(self) weakSelf = self;
    _floatView.clickBolcks = ^(NSInteger i) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Title" message:[NSString stringWithFormat:@"你点击了第 %ld 个按钮",i] preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *_Nonnull action) {
            NSLog(@"点击了OK");
        }];
        [alertController addAction:okAction];
        
        [weakSelf presentViewController:alertController animated:YES completion:nil];
    };

    [self.view addSubview:_floatView];
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

@end
