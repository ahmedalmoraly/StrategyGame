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

@interface ARGameMenuViewController ()<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UIButton *messagesButton;

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
    [self createPagingControl];

    self.scroll.pagingEnabled=YES;
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
    
    ARLoginViewController *login = [[ARLoginViewController alloc] initWithNibName:@"ARLoginViewController" bundle:nil];
    //[(id)self.parentViewController pushViewController:login animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createPagingControl {
    // programmatically add the page control
    pageControl_ = [[DDPageControl alloc] init];
    pageControl_.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin;
    pageControl_.backgroundColor = [UIColor blueColor];
	[pageControl_ setCenter:CGPointMake(self.view.bounds.size.height/2, self.view.bounds.size.height)] ;
    [self.view addSubview: pageControl_];
	[pageControl_ setNumberOfPages: numberOfPages_];
	[pageControl_ addTarget: self action: @selector(changedValue:) forControlEvents: UIControlEventValueChanged] ;
	[pageControl_ setDefersCurrentPageDisplay: YES];
    [pageControl_ setHidesForSinglePage:YES];
    [pageControl_ setCurrentPage: 0];
	[pageControl_ setType: DDPageControlTypeOnFullOffFull];
	[pageControl_ setOnColor:UIColorFromRGB(0x669900)];
	[pageControl_ setOffColor:UIColorFromRGB(0x001500)];
	[pageControl_ setIndicatorDiameter: 10.0f];
	[pageControl_ setIndicatorSpace: 12];
    pageControlBeingUsed_ = NO;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
	pageControlBeingUsed_ = NO;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
	pageControlBeingUsed_ = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    if (sender.tag==0) {
        if (!pageControlBeingUsed_) {
            // Switch the indicator when more than 50% of the previous/next page is visible
            //calculate the same for the arrabic view
            CGFloat pageWidth = self.scroll.frame.size.width;
            int page = floor((self.scroll.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
            pageControl_.currentPage = page;
            // if we are animating (triggered by clicking on the page control), we update the page control
            [pageControl_ updateCurrentPageDisplay];
            
        }
    }else{
        if (!pageControlBeingUsed_) {
            // Switch the indicator when more than 50% of the previous/next page is visible
            //calculate the same for the arrabic view
            CGFloat pageWidth = self.scroll.frame.size.width;
            int page = floor((self.scroll.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
            pageControl_.currentPage = page;
            // if we are animating (triggered by clicking on the page control), we update the page control
            [pageControl_ updateCurrentPageDisplay];
            
        }
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)aScrollView
{
    // if we are animating (triggered by clicking on the page control), we update the page control
	[pageControl_ updateCurrentPageDisplay] ;
    
}



- (void)viewDidUnload {
    [self setScroll:nil];
    [self setMessagesButton:nil];
    [super viewDidUnload];
}
@end
