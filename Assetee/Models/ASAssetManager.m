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

-(void)createAssetWithName:(NSString *)name barCodeId:(NSString *)barCodeId
             snapshotImage:(UIImage *)snapshotImage
                  complete:(void (^)(BOOL succeeded, NSError *error))complete {
    [self getAssetWithBarCodeId:barCodeId complete:^(ASAssetState state, AVObject *asset) {
        if (state != ASAssetStateNotFound) {
            [asset deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                [self _createAssetWithName:name barCodeId:barCodeId snapshotImage:snapshotImage complete:complete];
            }];
        }
        else {
            [self _createAssetWithName:name barCodeId:barCodeId snapshotImage:snapshotImage complete:complete];
        }
    }];
}

-(void)_createAssetWithName:(NSString *)name barCodeId:(NSString *)barCodeId
             snapshotImage:(UIImage *)snapshotImage
                   complete:(void (^)(BOOL succeeded, NSError *error))complete {
    AVObject *asset = [AVObject objectWithClassName:@"Asset"];
    [asset setObject:name forKey:@"name"];
    [asset setObject:barCodeId forKey:@"barCodeId"];
    NSData *snapshotData = UIImagePNGRepresentation(snapshotImage);
    AVFile *snapshot = [AVFile fileWithData:snapshotData];
    [asset setObject:snapshot forKey:@"snapshot"];
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
        if ([[asset valueForKey:@"rented"] isEqualToValue:@YES]) {
            complete(ASAssetStateRented, asset);
        }
        else {
            complete(ASAssetStateNotRented, asset);
        }
    }];
}


@end
