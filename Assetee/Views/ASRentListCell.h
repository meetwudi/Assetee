//
//  ASRentListCellTableViewCell.h
//  Assetee
//
//  Created by Wu Di on 12/5/14.
//  Copyright (c) 2014 吴迪（子回）. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ASRentListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *rentDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *rentInfoLabel;
@property (weak, nonatomic) IBOutlet UIImageView *snapshotImage;

@end
