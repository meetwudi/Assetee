//
//  ASOperateViewController.h
//  Assetee
//
//  Created by Wu Di on 12/5/14.
//  Copyright (c) 2014 吴迪（子回）. All rights reserved.
//

#import "ASBaseViewController.h"

@class ASFloatLabeledTextField;
@class AVObject;

@interface ASOperateViewController : ASBaseViewController
@property (weak, nonatomic) IBOutlet ASFloatLabeledTextField *nameInput;
@property (weak, nonatomic) IBOutlet ASFloatLabeledTextField *renterNameInput;
@property (weak, nonatomic) IBOutlet ASFloatLabeledTextField *renterPhoneInput;
@property (nonatomic) AVObject *asset;

- (void) setupViews;
@end
