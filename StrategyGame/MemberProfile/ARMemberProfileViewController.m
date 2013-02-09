//
//  ARMemberProfileViewController.m
//  StrategyGame
//
//  Created by Artgin on 1/26/13.
//  Copyright (c) 2013 Artgine. All rights reserved.
//

#import "ARMemberProfileViewController.h"
#import "InfinitePagingView.h"
#import "FTAnimation+UIView.h"

typedef NS_ENUM(NSInteger, Move )
{
    NEXT = 1,
    PREVIOUS = 2,
    NEXTCASTLES = 3,
    PREVIOUS_CASTLE= 4
};
#define DUMMY_BACKGROUND_VIEW_TAG 999

@interface ARMemberProfileViewController ()

@property (weak, nonatomic) IBOutlet InfinitePagingView *userProfile;
@property (weak, nonatomic) IBOutlet InfinitePagingView *castles;
@property (weak, nonatomic) IBOutlet UIView *spywar;

@end

@implementation ARMemberProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedStringFromTable(@"Member_Profile_Page_Title", @"MemberProfileStrings", @"Title of the Member Page to display in the header");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSArray *userProfileImgs = @[@"MyProfile_castle.png", @"MyProfile_castle.png", @"MyProfile_castle.png", @"MyProfile_castle.png", @"MyProfile_castle.png"];
    
    NSArray *castlesImgs = @[@"MyProfile_castle.png", @"MyProfile_castle.png", @"MyProfile_castle.png"];
    
    self.userProfile.pageSize = CGSizeMake(120.f, self.view.frame.size.height);
    self.userProfile.clipsToBounds = YES;
    
    [userProfileImgs enumerateObjectsUsingBlock:^(NSString * img ,NSUInteger idx ,BOOL *stop)
    {
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.frame = CGRectMake(2, 0.f, 100.f, self.userProfile.frame.size.height);
        [addButton setBackgroundImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        // [addButton setBackgroundImage:[UIImage imageNamed:img] forState:UIControlStateHighlighted];
        // [addButton addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
        [addButton setTag:idx];
        addButton.contentMode = UIViewContentModeScaleAspectFit;
        [self.userProfile addPageView:addButton];
        
    }];
    
    self.castles.pageSize = CGSizeMake(100.f, self.view.frame.size.height);
    self.castles.clipsToBounds = YES;
    
    [castlesImgs enumerateObjectsUsingBlock:^(NSString * img ,NSUInteger idx ,BOOL *stop)
    {    
        UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        addButton.frame = CGRectMake(0.f, 0.f, 45.f, self.castles.frame.size.height);
        [addButton setBackgroundImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
        [addButton addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
        [addButton setTag:idx];
        addButton.contentMode = UIViewContentModeScaleAspectFit;
        [self.castles addPageView:addButton];
    }];

}

-(void)show:(UIButton *)sender
{
    //NSInteger castleIndex = sender.tag;
    [self.view addSubview:[self dummyBackground]];
    [self.view addSubview:self.spywar];
    [self.spywar popIn:.5 delegate:self];
}

-(void)close:(id)sender
{
    [self.spywar flyOut:0.25 delegate:self startSelector:nil stopSelector:@selector(remove)];
}

-(void)remove
{
    [self.spywar removeFromSuperview];
    [[self.view viewWithTag:DUMMY_BACKGROUND_VIEW_TAG] removeFromSuperview];
}

-(UIControl *)dummyBackground
{
    UIControl *back = [[UIControl alloc] initWithFrame:self.view.frame];
    [back addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
    back.tag = DUMMY_BACKGROUND_VIEW_TAG;
    return back;
}

-(UIView *)spywar
{
    if (!_spywar) {
        [[NSBundle mainBundle] loadNibNamed:@"SpyWarPopup" owner:self options:nil];
        _spywar.center = self.view.center;
    }
    return _spywar;
}

-(IBAction)NextPrevious:(UIButton *)sender
{
    switch (sender.tag)
    {
        case NEXT:
            [self.userProfile scrollToNextPage];
            break;
        case PREVIOUS:
            [self.userProfile scrollToPreviousPage];
            break;
        case NEXTCASTLES:
            [self.castles scrollToNextPage];
            break;
        case PREVIOUS_CASTLE:
            [self.castles scrollToPreviousPage];
            break;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Touch The Right & Left Buttons in Castle View
    // Get the point of button and send it to show: Method
    
    NSArray *hitView  =  [[[self.castles subviews]objectAtIndex:0]subviews];
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:self.castles._innerScrollView];
    for (UIButton * obj in hitView)
    {
        if (CGRectContainsPoint([obj frame], location) && [obj isKindOfClass:[UIButton class]])
        {
            [self show:obj];
            break;
        }
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setUserProfile:nil];
    [self setCastles:nil];
    [self setSpywar:nil];
    [super viewDidUnload];
}
@end
