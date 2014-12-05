//
//  RentItems.m
//  Assetee
//
//  Created by Wu Di on 12/5/14.
//  Copyright (c) 2014 吴迪（子回）. All rights reserved.
//

#import "ASAssetManager.h"
#import <AVOSCloud/AVOSCloud.h>

@interface ASAssetManager()

@property (nonatomic) NSArray* items;

@end

@implementation ASAssetManager

+(instancetype)sharedManager {
    static ASAssetManager *rentItemsManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!rentItemsManager) {
            rentItemsManager = [[ASAssetManager alloc] init];
        }
    });
    return rentItemsManager;
}

-(void)fetchRentItemsWithComplete:(void (^)(NSArray *))complete {
    AVQuery *query = [AVQuery queryWithClassName:@"Asset"];
    [query whereKey:@"rented" equalTo:@YES];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error == nil) {
            complete(objects);
        }
    }];
}

@end
