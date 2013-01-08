//
//  ARGameViewController.h
//  StrategyGame
//
//  Created by Ahmad al-Moraly on 1/5/13.
//  Copyright (c) 2013 Artgine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ARGameViewController : UIViewController


-(void)setPageTitle:(NSString *)title;

-(void)setMoreButtonHidden:(BOOL)hidden;
-(void)setBackButtonHidden:(BOOL)hidden;
-(void)setRefreshButtonHidden:(BOOL)hidden;
-(void)setOptionsButtonHidden:(BOOL)hidden;
-(void)setHomeButtonHidden:(BOOL)hidden;

-(void)pushViewController:(UIViewController *)controller animated:(BOOL)animated;

@end
