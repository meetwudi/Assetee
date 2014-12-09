//
//  CoreDataManager.h
//  Assetee
//
//  Created by Tom Hu on 12/6/14.
//  Copyright (c) 2014 吴迪（子回）. All rights reserved.
//

#import <Foundation/Foundation.h>

@import CoreData;

@interface CoreDataManager : NSObject

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

+ (instancetype)sharedManager;

- (void)writeData:(NSArray *)array;
- (void)clearData;
- (NSMutableArray *)readData;

@end
