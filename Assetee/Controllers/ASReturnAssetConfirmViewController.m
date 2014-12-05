//
//  ASReturnAssetConfirmViewController.m
//  Assetee
//
//  Created by Wu Di on 12/5/14.
//  Copyright (c) 2014 吴迪（子回）. All rights reserved.
//

#import "ASReturnAssetConfirmViewController.h"
#import "ASFloatLabeledTextField.h"
#import <AVOSCloud/AVOSCloud.h>

@interface ASReturnAssetConfirmViewController ()
@property (weak, nonatomic) IBOutlet ASFloatLabeledTextField *nameInput;
@property (weak, nonatomic) IBOutlet ASFloatLabeledTextField *renterNameInput;
@property (weak, nonatomic) IBOutlet ASFloatLabeledTextField *renterPhoneInput;

@end

@implementation ASReturnAssetConfirmViewController

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
- (void) setupViews {
    UIColor *floatLabelColor = [UIColor colorWithRed:0 green:145.0/255.0 blue:1.0 alpha:1];
    
    self.nameInput.floatingLabelTextColor = floatLabelColor;
    self.nameInput.floatingLabelYPadding = -2.0;
    [self.nameInput setPlaceholder:@"资产名称"];
    self.nameInput.text = [self.asset valueForKey:@"name"];
    self.nameInput.enabled = NO;
    
    self.renterNameInput.floatingLabelTextColor = floatLabelColor;
    self.renterNameInput.floatingLabelYPadding = -2.0;
    [self.renterNameInput setPlaceholder:@"租借人名称"];
    self.renterNameInput.text = [self.asset valueForKey:@"renterName"];
    self.renterNameInput.enabled = NO;
    
    
    self.renterPhoneInput.floatingLabelTextColor = floatLabelColor;
    self.renterPhoneInput.floatingLabelYPadding = -2.0;
    [self.renterPhoneInput setPlaceholder:@"租借人电话"];
    self.renterPhoneInput.text = [self.asset valueForKey:@"renterPhone"];
    self.renterPhoneInput.enabled = NO;
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
