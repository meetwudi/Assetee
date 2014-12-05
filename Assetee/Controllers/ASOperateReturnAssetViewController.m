//
//  ASReturnAssetConfirmViewController.m
//  Assetee
//
//  Created by Wu Di on 12/5/14.
//  Copyright (c) 2014 吴迪（子回）. All rights reserved.
//

#import "ASOperateReturnAssetViewController.h"
#import "ASFloatLabeledTextField.h"
#import <AVOSCloud/AVOSCloud.h>

@interface ASOperateReturnAssetViewController ()


@end

@implementation ASOperateReturnAssetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Views
- (void)setupViews {
    [super setupViews];
    self.nameInput.text = [self.asset valueForKey:@"name"];
    self.nameInput.enabled = NO;
    self.renterNameInput.text = [self.asset valueForKey:@"renterName"];
    self.renterNameInput.enabled = NO;
    self.renterPhoneInput.text = [self.asset valueForKey:@"renterPhone"];
    self.renterPhoneInput.enabled = NO;
}


#pragma mark - View events

- (IBAction)confirmReturn:(id)sender {
    [self addOverlayView];
    [self.asset setObject:@NO forKey:@"rented"];
    [self.asset saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self showAlertWithMessage:@"资产归还成功"];
        }
        else {
            [self showAlertWithMessage:@"由于未知原因，资产归还失败"];
        }
        [self dismissViewControllerAnimated:YES completion:nil];
        [self removeOverlayView];
    }];
}

@end
