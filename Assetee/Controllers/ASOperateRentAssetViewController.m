//
//  ASRentAssetFillInfoViewController.m
//  Assetee
//
//  Created by Wu Di on 12/5/14.
//  Copyright (c) 2014 吴迪（子回）. All rights reserved.
//

#import "ASOperateRentAssetViewController.h"
#import "ASFloatLabeledTextField.h"
#import <AVOSCloud/AVOSCloud.h>

@interface ASOperateRentAssetViewController ()

@end

@implementation ASOperateRentAssetViewController

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
}

#pragma mark - View event
- (IBAction)save:(id)sender {
    [self addOverlayView];
    [self.asset setObject:self.renterNameInput.text forKey:@"renterName"];
    [self.asset setObject:self.renterPhoneInput.text forKey:@"renterPhone"];
    [self.asset setObject:@YES forKey:@"rented"];
    [self.asset saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self showAlertWithMessage:@"资产借出成功"];
        }
        else {
            [self showAlertWithMessage:@"由于未知原因，资产借出失败"];
        }
        [self removeOverlayView];
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

@end
