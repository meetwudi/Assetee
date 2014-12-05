//
//  ASRentAssetScanViewController.m
//  Assetee
//
//  Created by Wu Di on 12/5/14.
//  Copyright (c) 2014 吴迪（子回）. All rights reserved.
//

#import "ASOperateAssetScanViewController.h"
#import "ASAssetManager.h"
#import "ASReturnAssetConfirmViewController.h"
#import <AVOSCloud/AVOSCloud.h>

@interface ASOperateAssetScanViewController ()
@property (nonatomic) AVObject *asset;
@end

@implementation ASOperateAssetScanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupScanner];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)didDetectedBarCodeWithId:(NSString *)barCodeId {
    [self addOverlayView];
    // check asset state
    ASAssetManager *assetManager = [ASAssetManager sharedManager];
    [assetManager getAssetWithBarCodeId:barCodeId complete:^(ASAssetState state, AVObject *asset) {
        if (state == ASAssetStateNotFound) {
            // The asset is not found and user is required to scan again
            [self showAlertWithMessage:@"未查找到该资产"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else {
            self.asset = asset;
            if (state == ASAssetStateRented) {
                // the asset is rented
                [self performSegueWithIdentifier:@"Confirm Return" sender:self];
            }
            else if (state == ASAssetStateNotRented) {
                // oh yeah not rented
                [self performSegueWithIdentifier:@"Renter Information" sender:self];
            }
        }
        [self removeOverlayView];
    }];
}

#pragma mark - segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString: @"Renter Information"]) {
        // rent
    }
    else if ([segue.identifier isEqualToString: @"Confirm Return"]) {
        // return
        if ([segue.destinationViewController isKindOfClass:[ASReturnAssetConfirmViewController class]]) {
            ASReturnAssetConfirmViewController *dst = (ASReturnAssetConfirmViewController*)segue.destinationViewController;
            dst.asset = self.asset;
        }
    }
    
}


@end
