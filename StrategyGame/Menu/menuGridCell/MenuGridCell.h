//
//  MenuGridCell.h
//  StrategyGame
//
//  Created by Ahmad al-Moraly on 11/29/12.
//  Copyright (c) 2012 Artgine. All rights reserved.
//

#import "UIGridViewCell.h"
#import "PSTCollectionViewCell.h"


@interface MenuGridCell : PSTCollectionViewCell//UICollectionViewCell

@property (unsafe_unretained, nonatomic) IBOutlet UIButton *leftBtn;

@property (unsafe_unretained, nonatomic) IBOutlet UIButton *centerBtn;

@property (unsafe_unretained, nonatomic) IBOutlet UIButton *rightBtn;

-(void)setCellWithBtnsArray:(NSArray*)btns AndEnglishLanguage:(BOOL)english;
@end
