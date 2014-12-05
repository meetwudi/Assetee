//
//  ASAddAssetFillInfoViewController.m
//  Assetee
//
//  Created by Wu Di on 12/5/14.
//  Copyright (c) 2014 吴迪（子回）. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JVFloatLabeledTextField/JVFloatLabeledTextField.h>
#import "ASAddAssetFillInfoViewController.h"
#import "ASAssetManager.h"

@interface ASAddAssetFillInfoViewController ()
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *nameInput;
@property (weak, nonatomic) IBOutlet UILabel *informLabel;
@property (nonatomic) UIView *overlayView;
@property (nonatomic) UIActivityIndicatorView *activityIndicator;

@end

@implementation ASAddAssetFillInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupViews];
}

- (void)setupViews {
    // Setup nameInput
    UIColor *floatLabelColor = [UIColor colorWithRed:0 green:145.0/255.0 blue:1.0 alpha:1];
    
    self.nameInput.floatingLabelTextColor = floatLabelColor;
    self.nameInput.floatingLabelYPadding = -2.0;
    [self.nameInput setPlaceholder:@"资产名称"];
    
    // If the asset exists, let user know about it
    __weak ASAddAssetFillInfoViewController *weakSelf = self;
    [[ASAssetManager sharedManager] getAssetWithBarCodeId:self.barCodeId complete:^(ASAssetState state, AVObject *asset) {
        if (state != ASAssetStateNotFound) {
            // the assets exists
            weakSelf.informLabel.text = @"该资产曾经入库过，本次入库保存后将删除原有入库记录";
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Getter & Setter
-(BOOL)exists {
    if (!_exists) {
        _exists = NO;
    }
    return _exists;
}

#pragma mark - View events

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    
    ASAssetManager *assetManager = [ASAssetManager sharedManager];
    [self addOverlayView];
    // dismiss keyboard
    [self.view endEditing:YES];
    
    [assetManager createAssetWithName:self.nameInput.text barCodeId:self.barCodeId snapshotImage:self.snapshotImage complete:^(BOOL succeeded, NSError *error) {
        if (error) {
            NSLog(@"%@", error);
            [self showAlertWithMessage:@"由于未知原因，资产入库失败，请重试或者联系管理员"];
        }
        else {
            [self showAlertWithMessage:@"资产入库成功"];
        }
        [self removeOverlayView];
        [self cancel:self];
    }];
}


@end
