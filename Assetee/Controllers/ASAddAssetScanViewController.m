//
//  ASAddAssetViewController.m
//  Assetee
//
//  Created by Wu Di on 12/5/14.
//  Copyright (c) 2014 吴迪（子回）. All rights reserved.
//

#import "ASAddAssetScanViewController.h"
#import "ASAddAssetFillInfoViewController.h"


@interface ASAddAssetScanViewController ()
@property (nonatomic) NSString *barCodeId;
@end

@implementation ASAddAssetScanViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupScanner];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View events
- (IBAction)cancel:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)didDetectedBarCodeWithId:(NSString *)barCodeId {
    self.barCodeId = barCodeId;
    [self performSegueWithIdentifier:@"Asset Information" sender:self];
}


#pragma mark - others
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Asset Information"]) {
        if ([segue.destinationViewController isKindOfClass:[ASAddAssetFillInfoViewController class]]) {
            // Fill Info
            ASAddAssetFillInfoViewController *destination = (ASAddAssetFillInfoViewController*)segue.destinationViewController;
            destination.barCodeId = _barCodeId;
            // Get preview layer image data
            destination.snapshotImage = _snapshot;

        }
    }
}

@end
