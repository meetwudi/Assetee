//
//  ASBaseViewController.m
//  Assetee
//
//  Created by Wu Di on 12/5/14.
//  Copyright (c) 2014 吴迪（子回）. All rights reserved.
//

#import "ASBaseViewController.h"

@interface ASBaseViewController ()
@property (nonatomic) UIView *overlayView;
@property (nonatomic) UIActivityIndicatorView* activityIndicator;
@end

@implementation ASBaseViewController

#pragma mark - Overlay View
- (void)addOverlayView {
    self.overlayView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.overlayView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityIndicator.center = self.overlayView.center;
    [self.overlayView addSubview:self.activityIndicator];
    [self.activityIndicator startAnimating];
    [self.navigationController.view addSubview:self.overlayView];
}

- (void)removeOverlayView {
    [self.overlayView removeFromSuperview];
}

#pragma mark - UIAlertView related
- (void)showAlertWithMessage:(NSString*)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Assetee" message:message delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil];
    [alert show];
}

@end
