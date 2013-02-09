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

+ (void)saveScreenshotWithClassName:(NSString *)className context:(id)context;

@end
