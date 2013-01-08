//
//  MenuViewController.m
//  StrategyGame
//
//  Created by Ahmad al-Moraly on 11/28/12.
//  Copyright (c) 2012 Artgine. All rights reserved.
//

#import "MenuViewController.h"

@interface MenuViewController ()
{
    NSArray* arabicMenuItems;
    NSArray* englishMenuItems;
    
    NSArray* dataSource;
}
@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    arabicMenuItems=[[NSArray alloc]initWithObjects:[NSDictionary dictionaryWithObjectsAndKeys:@"",@"image",@"",@"tag", nil], nil];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma -marl collection view data source and delegate 

-(NSInteger)collectionView:(PSTCollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 18;
}
@end
