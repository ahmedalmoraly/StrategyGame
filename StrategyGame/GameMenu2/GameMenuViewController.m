    //
    //  GameMenuViewController.m
    //  StrategyGame
    //
    //  Created by Ahmad al-Moraly on 11/29/12.
    //  Copyright (c) 2012 Artgine. All rights reserved.
    //

#import "GameMenuViewController.h"
#import "loginViewController.h"
#import "TechnologiesViewController.h"
#import "TimerViewController.h"
#import "AlliancePage.h"
#import "MessagesViewController.h"
#import <QuartzCore/QuartzCore.h>


@interface GameMenuViewController ()
{
    CGRect mainscren;
}


@end

@implementation GameMenuViewController
@synthesize englishScrollView;
@synthesize arabicScrollView;
@synthesize viewController;
@synthesize context;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
            // Custom initialization
    }
    return self;
}


    
    









//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//
//    
//   // = [GameMenuViewController captureView:self.view inSize:CGSizeMake(200, 200)];
//    
//   
//    
//    
//    
//    
//    mainscren= [[UIScreen mainScreen]bounds];
//    
//       NSLog(@"is orientation lans scape : %@  , is status bar land scape: %@",UIDeviceOrientationIsLandscape( self.interfaceOrientation)  ? @"YES" : @"NO",UIDeviceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])  ? @"YES" : @"NO" );
//    
//    NSString *langID = [[NSLocale preferredLanguages] objectAtIndex:0];
//    NSString *lang = [[NSLocale currentLocale] displayNameForKey:NSLocaleLanguageCode value:langID];
//    
//    NSLog(@"current language : %@ ",lang);
//    numberOfPages_ = 2;
//        //pageControl_.numberOfPages = numberOfPages_;
//    
//    [self createPagingControl];
//    
//    self.pageTitleLabel.text=NSLocalizedString(@"MenuTitle", @"");
//    
//    
//        //English
//    
//    if (  [lang rangeOfString:@"العربية"].location==NSNotFound){//[language isEqualToString:@"ar"]) {
//                                                                //    [self.pageTitleLabel setText:@"Menu"];
//        [self.englishScrollView setHidden:NO];
//        [self.arabicScrollView setHidden:YES];
//        
//        
//        [self.englishScrollView setFrame:CGRectMake(self.englishScrollView.frame.origin.x, self.englishScrollView.frame.origin.y, mainscren.size.height, self.englishScrollView.frame.size.height)];
//        for (UIView* view in self.englishScrollView.subviews) {
//            if ([view isKindOfClass:[UIView class]]) {
//                [view setFrame:CGRectMake(mainscren.size.height*view.tag, view.frame.origin.y, mainscren.size.height, view.frame.size.height)];
//            }
//        }
//            //  [self.englishScrollView scrollRectToVisible:CGRectMake(0, 0, 960, 30) animated:NO];
//        [self setEnglishPaging];
//    }else{
//            //  [self.pageTitleLabel setText:@"القائمة"];
//        [self.englishScrollView setHidden:YES];
//        [self.arabicScrollView setHidden:NO];
//        
//        [self.arabicScrollView setFrame:CGRectMake(self.arabicScrollView.frame.origin.x, self.arabicScrollView.frame.origin.y, mainscren.size.height, self.arabicScrollView.frame.size.height)];
//        for (UIView* view in self.arabicScrollView.subviews) {
//            if ([view isKindOfClass:[UIView class]]) {
//                [view setFrame:CGRectMake(mainscren.size.height*view.tag, view.frame.origin.y, mainscren.size.height, view.frame.size.height)];
//            }
//        }
//            //[self.arabicScrollView scrollRectToVisible:CGRectMake(0, 0, 960, 30) animated:NO];
//        [self setArabicPaging];
//    }
//    
//    
//    
//    
//    
//        // Do any additional setup after loading the view from its nib.
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
        // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setEnglishScrollView:nil];
    [self setArabicScrollView:nil];
    [super viewDidUnload];
}




#pragma mark - paging control methods

- (void)createPagingControl {
        // programmatically add the page control
    pageControl_ = [[DDPageControl alloc] init];
    
	[pageControl_ setCenter:CGPointMake(mainscren.size.height/2, self.view.bounds.size.height)] ;
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

-(void)setEnglishPaging{
    
        // pageControl_.currentPage=1;
	self.englishScrollView.pagingEnabled=YES;
    self.englishScrollView.contentSize =
    CGSizeMake(self.englishScrollView.frame.size.width * numberOfPages_ ,
               self.englishScrollView.frame.size.height);
        //   self.englishScrollView.contentOffset=CGPointMake(1000, 0);
        //[self.englishScrollView scrollRectToVisible:CGRectZero animated:NO];
	
    
	[self.englishScrollView setDelegate:self];
    
        //the same code here for arabic view
}

-(void)setArabicPaging{
        //numberOfPages_ = 2;
        //pageControl_.numberOfPages = numberOfPages_;
    
    pageControl_.currentPage=1;
	self.arabicScrollView.pagingEnabled=YES;
    self.arabicScrollView.contentSize =
    CGSizeMake(self.arabicScrollView.frame.size.width * numberOfPages_ ,
               self.arabicScrollView.frame.size.height);
    self.arabicScrollView.contentOffset=CGPointMake(mainscren.size.height, 0);
        //[self.englishScrollView scrollRectToVisible:CGRectZero animated:NO];
	
    
	[self.arabicScrollView setDelegate:self];
    
        //the same code here for arabic view
}

-(IBAction)changedValue:(id)Sender{
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
            CGFloat pageWidth = self.englishScrollView.frame.size.width;
            int page = floor((self.englishScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
            pageControl_.currentPage = page;
                // if we are animating (triggered by clicking on the page control), we update the page control
            [pageControl_ updateCurrentPageDisplay];
            
        }
    }else{
        if (!pageControlBeingUsed_) {
                // Switch the indicator when more than 50% of the previous/next page is visible
                //calculate the same for the arrabic view
            CGFloat pageWidth = self.arabicScrollView.frame.size.width;
            int page = floor((self.arabicScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
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






- (IBAction)menuButtonTouched:(id)sender
{
    int tag=((UIButton*)sender).tag;
    UIAlertView* alert=[[UIAlertView alloc]initWithTitle:@"alert" message:@"" delegate:nil cancelButtonTitle:@"done" otherButtonTitles: nil];
    UIViewController* selectedController;
  
    switch (tag) {
        case 0://messages
        {
            alert.message=@"messages button touched";
            //selectedController=[[loginViewController alloc]initWithNibName:@"loginViewController" bundle:nil];
            selectedController = [[MessagesViewController alloc] initWithNibName:@"MessagesViewController" bundle:nil];
        }
            break;
        case 1://hall of war
            alert.message=@"hall of war button touched";
           
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                
               selectedController = [[Member_Profile alloc] initWithNibName:@"Member_Profile_iPhone" bundle:nil];
            } else {
                selectedController= [[Member_Profile alloc] initWithNibName:@"Member_Profile_iPad" bundle:nil];
            }
            
                //    [self.navigationController pushViewController:self.viewController  animated:YES];
            
            
            
            break;
        case 2://hall of spy
            alert.message=@"hall of spy button touched";
            break;
        case 3://shopping
            alert.message=@"shopping button touched";
            break;
        case 4://members
            alert.message=@"members button touched";
            break;
        case 5://Map
            alert.message=@"map button touched";
            break;
        case 6://castle
            alert.message=@"castle button touched";
            break;
        case 7://technology
            alert.message=@"technology button touched";
            selectedController=[[TechnologiesViewController alloc]init];
            break;
        case 8://Knight_Skills
            alert.message=@"Knight Skills button touched";
            break;
        case 9://Alliance
            selectedController =[[AlliancePage alloc]initWithNibName:@"AlliancePage" bundle:nil];
            
            alert.message=@"Alliance button touched";
            break;
        case 10://news
            alert.message=@"news button touched";
            break;
        case 11://forums
            alert.message=@"forums button touched";
            break;
            
    }
    [alert show];

    [self.navigationController pushViewController:selectedController animated:YES];
}
@end
