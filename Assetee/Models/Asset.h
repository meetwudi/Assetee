//
//  Asset.h
//  Assetee
//
//  Created by Tom Hu on 12/6/14.
//  Copyright (c) 2014 吴迪（子回）. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@import AVOSCloud;

@interface Asset : NSManagedObject

@property (nonatomic, retain) NSString * barCodeId;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * rentDate;
@property (nonatomic, retain) NSNumber * rented;
@property (nonatomic, retain) NSString * renterName;
@property (nonatomic, retain) NSString * renterPhone;
@property (nonatomic, retain) NSData * snapshot;

- (void)initWithAVObject:(AVObject *)obj;

@end
