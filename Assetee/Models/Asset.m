//
//  Asset.m
//  Assetee
//
//  Created by Tom Hu on 12/6/14.
//  Copyright (c) 2014 吴迪（子回）. All rights reserved.
//

#import "Asset.h"


@implementation Asset

@dynamic barCodeId;
@dynamic name;
@dynamic rentDate;
@dynamic rented;
@dynamic renterName;
@dynamic renterPhone;
@dynamic snapshot;

- (void)initWithAVObject:(AVObject *)obj {
    self.barCodeId = [obj valueForKey:@"barCodeId"];
    self.name = [obj valueForKey:@"name"];
    self.rentDate = [obj valueForKey:@"rentDate"];
    self.rented = [obj valueForKey:@"rented"];
    self.renterName = [obj valueForKey:@"renterName"];
    self.renterPhone = [obj valueForKey:@"renterPhone"];
    AVFile *file = [obj objectForKey:@"snapshot"];
    self.snapshot = [file getData:nil];
//    
//    AVFile *file = [obj objectForKey:@"snapshot"];
//    __weak Asset *weakself = self;
//    [file getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
//        weakself.snapshot = data;
//    }];
}

@end
