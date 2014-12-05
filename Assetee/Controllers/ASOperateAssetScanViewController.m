//
//  ASRentAssetScanViewController.m
//  Assetee
//
//  Created by Wu Di on 12/5/14.
//  Copyright (c) 2014 吴迪（子回）. All rights reserved.
//

#import "ASOperateAssetScanViewController.h"

@interface ASOperateAssetScanViewController ()

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
}


@end
