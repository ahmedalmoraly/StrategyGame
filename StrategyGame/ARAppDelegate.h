//
//  ARAppDelegate.h
//  StrategyGame
//
//  Created by Ahmad al-Moraly on 1/4/13.
//  Copyright (c) 2013 Artgine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ARAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIViewController *viewController;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
