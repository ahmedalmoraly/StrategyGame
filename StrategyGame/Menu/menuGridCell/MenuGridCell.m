//
//  MenuGridCell.m
//  StrategyGame
//
//  Created by Ahmad al-Moraly on 11/29/12.
//  Copyright (c) 2012 Artgine. All rights reserved.
//

#import "MenuGridCell.h"

@implementation MenuGridCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/


-(void)setCellWithBtnsArray:(NSArray *)btns AndEnglishLanguage:(BOOL)english{
    if (english) {
        if (btns.count>1) {
            [self.leftBtn setImage:[[btns objectAtIndex:0]objectForKey:@"image"] forState:UIControlStateNormal];
            [self.leftBtn setTag:[[[btns objectAtIndex:0]objectForKey:@"tag"]integerValue ]];
        }
        if (btns.count>2) {
            [self.centerBtn setImage:[[btns objectAtIndex:1]objectForKey:@"image"] forState:UIControlStateNormal];
            [self.centerBtn setTag:[[[btns objectAtIndex:1]objectForKey:@"tag"]integerValue ]];
        }
        if (btns.count>3) {
            [self.rightBtn setImage:[[btns objectAtIndex:2]objectForKey:@"image"] forState:UIControlStateNormal];
            [self.rightBtn setTag:[[[btns objectAtIndex:2]objectForKey:@"tag"]integerValue ]];
        }
    }
    else{
        if (btns.count>1) {
            [self.rightBtn setImage:[[btns objectAtIndex:0]objectForKey:@"image"] forState:UIControlStateNormal];
            [self.rightBtn setTag:[[[btns objectAtIndex:0]objectForKey:@"tag"]integerValue ]];
        }
        if (btns.count>2) {
            [self.centerBtn setImage:[[btns objectAtIndex:1]objectForKey:@"image"] forState:UIControlStateNormal];
            [self.centerBtn setTag:[[[btns objectAtIndex:1]objectForKey:@"tag"]integerValue ]];
        }
        if (btns.count>3) {
            [self.leftBtn setImage:[[btns objectAtIndex:2]objectForKey:@"image"] forState:UIControlStateNormal];
            [self.leftBtn setTag:[[[btns objectAtIndex:2]objectForKey:@"tag"]integerValue ]];
        }
    }
}
@end
