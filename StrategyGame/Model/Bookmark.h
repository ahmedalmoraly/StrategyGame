//
//  Bookmark.h
//  StrategyGame
//
//  Created by Ali Amin on 2/9/13.
//  Copyright (c) 2013 Artgine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Bookmark : NSManagedObject

@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * classType;
@property (nonatomic, retain) id context;

@end
