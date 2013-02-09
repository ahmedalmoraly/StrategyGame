//
//  ARGameMenuViewController.m
//  StrategyGame
//
//  Created by Ahmad al-Moraly on 1/5/13.
//  Copyright (c) 2013 Artgine. All rights reserved.
//

#import "ARGameMenuViewController.h"
#import "ARGameViewController.h"
#import "DDPageControl.h"
#import "ARLoginViewController.h"
#import "MessagesViewController.h"
#import "ARMemberProfileViewController.h"
#import "ARTechnologiesViewController.h"

@interface ARGameMenuViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIButton *messagesButton;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end

@implementation ARGameMenuViewController
{
    DDPageControl* pageControl_;
    int numberOfPages_;
	bool pageControlBeingUsed_;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedStringFromTable(@"Menu_Page_Title", @"GameMenuStrings", @"Menu_Page_Title");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    numberOfPages_ = 2;
    self.pageControl.numberOfPages = numberOfPages_;
    self.scroll.pagingEnabled=YES;
    self.scroll.delegate = self;
    
    CGSize size = self.scroll.frame.size;
    self.scroll.contentSize = CGSizeMake(size.width * numberOfPages_ , 230);
    self.scroll.directionalLockEnabled = YES;
    //self.messagesButton addTarget:self action:@selector(messages:) forControlEvents:UIControlEventTouchUpInside];
    
    if (IS_ARABIC)
    {
        self.scroll.contentOffset = CGPointMake(size.width * (numberOfPages_ -1), 0);
    }
}

- (IBAction)messages:(id)sender
{
    MessagesViewController *messages = [[MessagesViewController alloc] initWithNibName:@"MessagesViewController" bundle:nil];
    messages.title = NSLocalizedStringFromTable(@"Messages_Page_Title", @"GameMenuStrings", @"Messages_Page_Title");
    [(id)self.parentViewController pushViewController:messages animated:YES];
    
    //ARLoginViewController *login = [[ARLoginViewController alloc] initWithNibName:@"ARLoginViewController" bundle:nil];
    //[(id)self.parentViewController pushViewController:login animated:YES];
}


- (IBAction)hallOfWar:(id)sender
{
    ARMemberProfileViewController *memberProfile = [[ARMemberProfileViewController alloc] initWithNibName:@"ARMemberProfileViewController" bundle:nil];
    [(id)self.parentViewController pushViewController:memberProfile animated:YES];
}

- (IBAction)technologies:(id)sender
{
    ARTechnologiesViewController *technology = [[ARTechnologiesViewController alloc] initWithNibName:@"ARTechnologiesViewController" bundle:nil];
    [(id)self.parentViewController pushViewController:technology animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = self.scroll.frame.size.width;
    int page = floor((self.scroll.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    self.pageControl.currentPage = page;
}

- (void)viewDidUnload {
    [self setScroll:nil];
    [self setMessagesButton:nil];
    [self setPageControl:nil];
    [super viewDidUnload];
}
@end
