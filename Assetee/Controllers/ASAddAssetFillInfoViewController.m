//
//  ASAddAssetFillInfoViewController.m
//  Assetee
//
//  Created by Wu Di on 12/5/14.
//  Copyright (c) 2014 吴迪（子回）. All rights reserved.
//

#import "ASAddAssetFillInfoViewController.h"
#import <JVFloatLabeledTextField/JVFloatLabeledTextField.h>
#import "ASAssetManager.h"

@interface ASAddAssetFillInfoViewController ()
@property (weak, nonatomic) IBOutlet JVFloatLabeledTextField *nameInput;


@end

@implementation ASAddAssetFillInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNameInput];
}

- (void)setupNameInput {
    self.nameInput.floatingLabelTextColor = [UIColor blackColor];
    self.nameInput.floatingLabelYPadding = -2.0;
    [self.nameInput setPlaceholder:@"资产名称"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View events

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    ASAssetManager *assetManager = [ASAssetManager sharedManager];
    [assetManager createAssetWithName:self.nameInput.text barCodeId:self.barCodeId snapshotImage:self.snapshotImage complete:^(BOOL succeeded, NSError *error) {
        NSLog(@"OK");
        if (error) {
            NSLog(@"%@", error);
        }
        [self cancel:self];
    }];
}

@end
