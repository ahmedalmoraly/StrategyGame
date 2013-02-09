//
//  ARTechnologyCell.h
//  StrategyGame
//
//  Created by Ali Amin on 2/9/13.
//  Copyright (c) 2013 Artgine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIGridViewCell.h"

@interface ARTechnologyCell : UIGridViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *price;

@end
