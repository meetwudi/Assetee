//
//  ASRentListCellTableViewCell.m
//  Assetee
//
//  Created by Wu Di on 12/5/14.
//  Copyright (c) 2014 吴迪（子回）. All rights reserved.
//

#import "ASRentListCell.h"
#import <AVOSCloud/AVOSCloud.h>
#import "ASDateFormatter.h"

@interface ASRentListCell()


@end

@implementation ASRentListCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureCellWithAVObject:(AVObject *)obj {
    // set asset name
    self.nameLabel.text = [obj valueForKey:@"name"];
    // set rent date
    NSDate *rentDate = [obj valueForKey:@"rentDate"];
    self.rentDateLabel.text = [[ASDateFormatter zhDateFormatter] stringFromDate:rentDate];
    // set rent info
    self.rentInfoLabel.text = [NSString stringWithFormat:@"借出给%@，电话%@",
                               [obj valueForKey:@"renterName"],
                               [obj valueForKey:@"renterPhone"]];
    AVFile *file = [obj objectForKey:@"snapshot"];
    
    __weak ASRentListCell *weakself = self;
    [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        UIImage *image = [UIImage imageWithData:data];
        weakself.snapshotImage.image = image;
    }];
}

- (void)configureCellWithDictionary:(NSDictionary *)dict {
    // set asset name
    self.nameLabel.text = [dict valueForKey:@"name"];
    // set rent date
    NSDate *rentDate = [dict valueForKey:@"rentDate"];
    self.rentDateLabel.text = [[ASDateFormatter zhDateFormatter] stringFromDate:rentDate];
    // set rent info
    self.rentInfoLabel.text = [NSString stringWithFormat:@"借出给%@，电话%@",
                               [dict valueForKey:@"renterName"],
                               [dict valueForKey:@"renterPhone"]];
    self.snapshotImage.image = [UIImage imageWithData:[dict objectForKey:@"snapshot"]];
}

@end
