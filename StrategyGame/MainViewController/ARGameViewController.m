//
//  ARGameViewController.m
//  StrategyGame
//
//  Created by Ahmad al-Moraly on 1/5/13.
//  Copyright (c) 2013 Artgine. All rights reserved.
//

#import "ARGameViewController.h"
#import "ARGameMenuViewController.h"
#import "ARGameOptionsViewController.h"

@interface ARGameViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIButton *homeHeaderButton;
@property (weak, nonatomic) IBOutlet UIButton *optionsHeaderButton;
@property (weak, nonatomic) IBOutlet UIButton *moreHeaderButton;
@property (weak, nonatomic) IBOutlet UIButton *refreshHeaderButton;
@property (weak, nonatomic) IBOutlet UIButton *backHeaderButton;
@property (weak, nonatomic) IBOutlet UILabel *pageTitleLabel;

@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation ARGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    // add Root Child
    ARGameMenuViewController *menu = [[ARGameMenuViewController alloc] init];
    [self pushViewController:menu animated:YES];
    
    // hide the back btn
    self.backHeaderButton.hidden = YES;
}


-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

- (void)viewDidUnload {
    [self setBackgroundImage:nil];
    [self setHomeHeaderButton:nil];
    [self setOptionsHeaderButton:nil];
    [self setMoreHeaderButton:nil];
    [self setRefreshHeaderButton:nil];
    [self setBackHeaderButton:nil];
    [self setPageTitleLabel:nil];
    [self setContainerView:nil];
    [super viewDidUnload];
}

#pragma mark - Publich Methods

-(void)setPageTitle:(NSString *)title
{
    self.pageTitleLabel.text = title;
}

-(void)setMoreButtonHidden:(BOOL)hidden
{
    self.moreHeaderButton.hidden = hidden;
}

-(void)setBackButtonHidden:(BOOL)hidden
{
    self.backHeaderButton.hidden = hidden;
}

-(void)setRefreshButtonHidden:(BOOL)hidden
{
    self.refreshHeaderButton.hidden = hidden;
}

-(void)setOptionsButtonHidden:(BOOL)hidden
{
    self.optionsHeaderButton.hidden = hidden;
}

-(void)setHomeButtonHidden:(BOOL)hidden
{
    self.homeHeaderButton.hidden = hidden;
}

- (IBAction)back:(id)sender
{
    [self popViewController:self.childViewControllers.lastObject animated:YES];
}
- (IBAction)home:(id)sender
{
    [self popToRootViewControllerAnimated:YES];
}

-(IBAction)options:(id)sender
{
    ARGameOptionsViewController *options = [[ARGameOptionsViewController alloc] initWithNibName:@"ARGameOptionsViewController" bundle:nil];
    [self pushViewController:options animated:YES];
}

-(void)popViewController:(UIViewController *)controller animated:(BOOL)animated
{
    if (self.childViewControllers.count == 1) return;

    [controller willMoveToParentViewController:nil];
    [controller beginAppearanceTransition:NO animated:animated];
 
    if (animated)
    {
        self.view.userInteractionEnabled = NO;
        UIView* lastView = self.containerView.subviews[self.containerView.subviews.count - 2];
        [UIView transitionWithView:self.containerView duration:0.25 options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState animations:^
         {
             self.pageTitleLabel.alpha = 0;
             controller.view.transform = CGAffineTransformMakeTranslation(controller.view.frame.size.width, 0);
             controller.view.alpha = 0.5;
             lastView.transform = CGAffineTransformIdentity;
             lastView.alpha = 1.0;
         } completion:^(BOOL finished) {
             [controller.view removeFromSuperview];
             [controller endAppearanceTransition];
             [controller removeFromParentViewController];
             if (self.childViewControllers.count == 1) self.backHeaderButton.hidden = YES;
             self.view.userInteractionEnabled = YES;
             [self setPageTitle:[self.childViewControllers.lastObject title]];
             self.pageTitleLabel.alpha = 1;
         }];
    }
    else
    {
        [controller.view removeFromSuperview];
        [self.containerView.subviews.lastObject setTransform:CGAffineTransformIdentity];
        [controller removeFromParentViewController];
        [self setPageTitle:[self.childViewControllers.lastObject title]];
        if (self.childViewControllers.count == 1) self.backHeaderButton.hidden = YES;
    }
}

-(void)popToRootViewControllerAnimated:(BOOL)animated
{
    // get the root child
    UIViewController *root = self.childViewControllers[0];
    [root beginAppearanceTransition:YES animated:animated];
    
    [UIView transitionWithView:self.containerView duration:0.25 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseIn animations:^
    {
        [self.childViewControllers enumerateObjectsUsingBlock:^(UIViewController *child, NSUInteger idx, BOOL *stop) {
            if (idx == 0) return;
           
            [child beginAppearanceTransition:NO animated:YES];
            child.view.transform = CGAffineTransformMakeTranslation(child.view.frame.size.width, 0);
            child.view.alpha = 0.5;
        }];
        self.pageTitleLabel.alpha = 0;
        root.view.transform = CGAffineTransformIdentity;
        root.view.alpha = 1.0;
    } completion:^(BOOL finished)
    {
        [root endAppearanceTransition];
        [self setPageTitle:root.title];
        self.pageTitleLabel.alpha = 1;
        self.backHeaderButton.hidden = YES;
        [self.childViewControllers enumerateObjectsUsingBlock:^(UIViewController *child, NSUInteger idx, BOOL *stop) {
            if (idx == 0) return;
            [child.view removeFromSuperview];
            [child endAppearanceTransition];
            [child removeFromParentViewController];
        }];
    }];
}

-(void)pushViewController:(UIViewController *)controller animated:(BOOL)animated
{
    [controller willMoveToParentViewController:self];
    
    if (animated)
    {
        self.view.userInteractionEnabled = NO;
        UIView* lastView = self.containerView.subviews.lastObject;
        controller.view.alpha = 0.5;
        [self addChildViewController:controller];
        [controller beginAppearanceTransition:YES animated:YES];
        [self.containerView addSubview:controller.view];
        controller.view.frame = self.containerView.bounds;
        controller.view.transform = CGAffineTransformMakeTranslation(controller.view.frame.size.width, 0);
        
        [UIView transitionWithView:self.containerView duration:0.25 options:UIViewAnimationOptionCurveEaseIn animations:^
         {
             self.pageTitleLabel.alpha = 0;
            lastView.transform = CGAffineTransformMakeTranslation(-lastView.frame.size.width-20, 0);
             controller.view.alpha = 1;

             lastView.alpha = 0.5;
             controller.view.transform = CGAffineTransformIdentity;
             self.pageTitleLabel.alpha = 1;
             
        } completion:^(BOOL finished) {
            [controller endAppearanceTransition];
            [controller didMoveToParentViewController:self];
            self.view.userInteractionEnabled = YES;
        }];
        

    }
    else
    {
        [self addChildViewController:controller];
        [controller beginAppearanceTransition:YES animated:NO];
        controller.view.frame = self.containerView.bounds;
        [self.containerView.subviews.lastObject setHidden:YES];
        [self.containerView addSubview:controller.view];
        [controller didMoveToParentViewController:self];
    }
    
    [self setPageTitle:controller.title];
    self.backHeaderButton.hidden = NO;
}

-(void)pushViewController:(UIViewController *)controller animated:(BOOL)animated completion:(void (^)())completionHandler
{
    
    [controller willMoveToParentViewController:self];
    
    if (animated)
    {
        self.view.userInteractionEnabled = NO;
        UIView* lastView = self.containerView.subviews.lastObject;
        controller.view.alpha = 0.5;
        [self addChildViewController:controller];
        [controller beginAppearanceTransition:YES animated:YES];
        [self.containerView addSubview:controller.view];
        controller.view.frame = self.containerView.bounds;
        controller.view.transform = CGAffineTransformMakeTranslation(controller.view.frame.size.width, 0);
        
        [UIView transitionWithView:self.containerView duration:0.25 options:UIViewAnimationOptionCurveEaseIn animations:^
         {
             self.pageTitleLabel.alpha = 0;
             lastView.transform = CGAffineTransformMakeTranslation(-lastView.frame.size.width-20, 0);
             controller.view.alpha = 1;
             
             lastView.alpha = 0.5;
             controller.view.transform = CGAffineTransformIdentity;
             self.pageTitleLabel.alpha = 1;
             
         } completion:^(BOOL finished) {
             [controller endAppearanceTransition];
             [controller didMoveToParentViewController:self];
             self.view.userInteractionEnabled = YES;
             if (completionHandler) {
                 completionHandler();
             }
         }];
        
        
    }
    else
    {
        [self addChildViewController:controller];
        [controller beginAppearanceTransition:YES animated:NO];
        controller.view.frame = self.containerView.bounds;
        [self.containerView.subviews.lastObject setHidden:YES];
        [self.containerView addSubview:controller.view];
        [controller didMoveToParentViewController:self];
        if (completionHandler) {
            completionHandler();
        }
    }
    
    [self setPageTitle:controller.title];
    self.backHeaderButton.hidden = NO;
}

@end
