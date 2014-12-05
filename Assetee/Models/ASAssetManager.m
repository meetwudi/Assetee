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

-(void)createAssetWithName:(NSString *)name barCodeId:(NSString *)barCodeId snapshotImage:(UIImage *)snapshotImage complete:(void (^)(BOOL succeeded, NSError *error))complete {
    AVObject *asset = [AVObject objectWithClassName:@"Asset"];
    [asset setObject:name forKey:@"name"];
    [asset setObject:barCodeId forKey:@"barCodeId"];
    NSData *snapshotData = UIImagePNGRepresentation(snapshotImage);
    AVFile *snapshot = [AVFile fileWithData:snapshotData];
    [asset setObject:snapshot forKey:@"snapshot"];
    // 临时的
    [asset setObject:@YES forKey:@"rented"];
    [asset saveInBackgroundWithBlock:complete];
}

- (void) getAssetWithBarCodeId:(NSString*)barCodeId
                           complete:(void(^)(ASAssetState state, AVObject *asset))complete {
    AVQuery *query = [AVQuery queryWithClassName:@"Asset"];
    [query whereKey:@"barCodeId" equalTo:barCodeId];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if ([objects count] == 0) {
            complete(ASAssetStateNotFound, nil);
            return;
        }
        AVObject *asset = [objects objectAtIndex:0];
        BOOL rented = [asset valueForKey:@"rented"];
        if (rented) {
            complete(ASAssetStateRented, asset);
        }
        else {
            complete(ASAssetStateNotRented, asset);
        }
    }];
}


@end
