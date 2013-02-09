//
//  ARAppDelegate.m
//  StrategyGame
//
//  Created by Ahmad al-Moraly on 1/4/13.
//  Copyright (c) 2013 Artgine. All rights reserved.
//

#import "ARAppDelegate.h"
#import "ARGameViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation ARAppDelegate

-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscape;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[ARGameViewController alloc] initWithNibName:@"ARGameViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [MagicalRecord setupCoreDataStack];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Saves changes in the application's managed object context before the application terminates.
    [MagicalRecord cleanUp];
}

+ (void)saveScreenshotWithClassName:(NSString *)className context:(id)context
{
    [(ARAppDelegate *)[[UIApplication sharedApplication] delegate] saveScreenshotWithClassName:className context:context];
}

- (void)saveScreenshotWithClassName:(NSString *)className context:(id)context
{
    CGSize size = self.window.bounds.size;// CGSizeMake(self.window.bounds.size.height, self.window.bounds.size.width);
    CGFloat scale = [UIScreen mainScreen].scale;
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
    {
        UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    }
    else
    {
        UIGraphicsBeginImageContext(size);
    }
    [self.window.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGRect cropRect =  CGRectMake(20*scale, 0, (size.width-20)*scale, size.height*scale);
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], cropRect);
    image = [UIImage imageWithCGImage:imageRef];
    UIGraphicsEndImageContext();
    
    // saveing image to disk
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *imagePath;
    NSArray *arr = [Bookmark MR_findAllWithPredicate:[NSPredicate predicateWithFormat:@"classType == %@", className]];
    if (arr.count)
    {
        Bookmark *book = arr.lastObject;
        imagePath = book.imageURL;
        [fm removeItemAtPath:imagePath error:nil];
        
        book.context = context;
    }
    else
    {
        [fm createDirectoryAtPath:[self applicationStorageDirectory] withIntermediateDirectories:YES attributes:nil error:nil];
        imagePath = [[[self applicationStorageDirectory] stringByAppendingPathComponent:[self GetUUID]] stringByAppendingPathExtension:@"png"];
        
        Bookmark *book = [Bookmark MR_createEntity];
        book.imageURL = imagePath;
        book.classType = className;
        book.context = context;
    }
    [fm createFileAtPath:imagePath contents:UIImagePNGRepresentation(image) attributes:nil];
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:nil];
}

- (NSString *)GetUUID
{
    CFUUIDRef theUUID = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, theUUID);
    CFRelease(theUUID);
    return (NSString *)CFBridgingRelease(string);
}
- (NSString *) MR_directory:(int) type
{
    return [NSSearchPathForDirectoriesInDomains(type, NSUserDomainMask, YES) lastObject];
}
- (NSString *)applicationStorageDirectory
{
    NSString *applicationName = [[[NSBundle mainBundle] infoDictionary] valueForKey:(NSString *)kCFBundleNameKey];
    return [[self MR_directory:NSApplicationSupportDirectory] stringByAppendingPathComponent:applicationName];
}

@end
