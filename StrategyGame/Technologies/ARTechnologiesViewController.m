//
//  ARTechnologiesViewController.m
//  StrategyGame
//
//  Created by Ali Amin on 2/9/13.
//  Copyright (c) 2013 Artgine. All rights reserved.
//

#import "ARTechnologiesViewController.h"
#import "ARTechnologyCell.h"
#import "UIGridView.h"
#import "UIGridViewDelegate.h"

@interface ARTechnologiesViewController ()
@property (weak, nonatomic) IBOutlet UIGridView *gridView;
@property (weak, nonatomic) IBOutlet ARTechnologyCell *cell;
@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation ARTechnologiesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedStringFromTable(@"Technologies_Page_Title", @"TechnologiesStrings", @"Technologies_Page_Title");

        [self loadTableData];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidUnload {
    [self setGridView:nil];
    [self setCell:nil];
    [super viewDidUnload];
}


-(void)loadTableData
{
    //load dummy data
    for (float i = 1; i < 11; i++)
    {
        [self.dataSource addObject: @{@"price" : [NSString stringWithFormat:@"%g$", i-0.01], @"title" : [NSString stringWithFormat:@"tech %i", (int)i]}];
    }
}

-(NSMutableArray *)dataSource
{
    if (!_dataSource)
    {
        _dataSource = [@[] mutableCopy];
    }
    return _dataSource;
}
- (CGFloat) gridView:(UIGridView *)grid widthForColumnAt:(int)columnIndex
{
    return 160;
}
- (CGFloat) gridView:(UIGridView *)grid heightForRowAt:(int)rowIndex
{
    return 140;
}

- (NSInteger) numberOfColumnsOfGridView:(UIGridView *) grid
{
    return 3;
}
- (NSInteger) numberOfCellsOfGridView:(UIGridView *) grid
{
    return self.dataSource.count;
}

- (UIGridViewCell *) gridView:(UIGridView *)grid cellForRowAt:(int)rowIndex AndColumnAt:(int)columnIndex
{
    ARTechnologyCell *cell = (ARTechnologyCell *)[grid dequeueReusableCell];
    if (!cell)
    {
        [[NSBundle mainBundle] loadNibNamed:@"ARTechnologyCell" owner:self options:nil];
        cell = self.cell;
    }
    
    int itemIndex = rowIndex * [self numberOfColumnsOfGridView:grid] + columnIndex;
    cell.title.text = self.dataSource[itemIndex][@"title"];
    cell.price.text = self.dataSource[itemIndex][@"price"];
    
    return cell;
}

- (void) gridView:(UIGridView *)grid didSelectRowAt:(int)rowIndex AndColumnAt:(int)columnIndex
{
    
}

@end
