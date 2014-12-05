//
//  ASOperateViewController.m
//  Assetee
//
//  Created by Wu Di on 12/5/14.
//  Copyright (c) 2014 吴迪（子回）. All rights reserved.
//

#import "ASOperateViewController.h"
#import "ASFloatLabeledTextField.h"

@interface ASOperateViewController ()

@end

@implementation ASOperateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Views
- (void) setupViews {
    UIColor *floatLabelColor = [UIColor colorWithRed:0 green:145.0/255.0 blue:1.0 alpha:1];
    
    self.nameInput.floatingLabelTextColor = floatLabelColor;
    self.nameInput.floatingLabelYPadding = -2.0;
    [self.nameInput setPlaceholder:@"资产名称"];
    
    self.renterNameInput.floatingLabelTextColor = floatLabelColor;
    self.renterNameInput.floatingLabelYPadding = -2.0;
    [self.renterNameInput setPlaceholder:@"租借人名称"];
    
    
    self.renterPhoneInput.floatingLabelTextColor = floatLabelColor;
    self.renterPhoneInput.floatingLabelYPadding = -2.0;
    [self.renterPhoneInput setPlaceholder:@"租借人电话"];
}




@end
