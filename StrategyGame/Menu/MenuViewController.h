//
//  MenuViewController.h
//  StrategyGame
//
//  Created by Ahmad al-Moraly on 11/28/12.
//  Copyright (c) 2012 Artgine. All rights reserved.
//

#import "MasterViewController.h"
#import "DDPageControl.h"
#import "PSTCollectionView.h"

@interface MenuViewController : MasterViewController<PSTCollectionViewDataSource,PSTCollectionViewDelegate>
{
    int numberOfPages_;
    DDPageControl* imagePageControl_;
    DDPageControl* videoPageControl_;
    bool imagePageControlBeingUsed_;
}
@end
