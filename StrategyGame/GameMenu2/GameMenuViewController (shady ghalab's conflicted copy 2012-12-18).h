//
//  GameMenuViewController.h
//  StrategyGame
//
//  Created by Ahmad al-Moraly on 11/29/12.
//  Copyright (c) 2012 Artgine. All rights reserved.
//

#import "MasterViewController.h"
#import "DDPageControl.h"
#import "Member_Profile.h"

@interface GameMenuViewController : MasterViewController<UIScrollViewDelegate>
{
    DDPageControl* pageControl_;
    	int numberOfPages_;
	bool pageControlBeingUsed_;
}
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *englishScrollView;
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *arabicScrollView;
@property (strong, nonatomic) Member_Profile *viewController;

- (IBAction)menuButtonTouched:(id)sender;



@end
