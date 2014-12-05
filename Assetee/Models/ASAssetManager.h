//
//  RentItems.h
//  Assetee
//
//  Created by Wu Di on 12/5/14.
//  Copyright (c) 2014 吴迪（子回）. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASAssetManager : NSObject

+ (instancetype) sharedManager;
- (void) fetchRentItemsWithComplete:(void(^)(NSArray *items))complete;

@end
