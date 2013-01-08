//
//  ARLoginViewController.m
//  StrategyGame
//
//  Created by Ahmad al-Moraly on 1/7/13.
//  Copyright (c) 2013 Artgine. All rights reserved.
//

#import "ARLoginViewController.h"

@interface ARLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *user_textField;
@property (weak, nonatomic) IBOutlet UITextField *password_textField;

@end

@implementation ARLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = NSLocalizedStringFromTable(@"Login_Page_Title", @"LoginPageStrings", @"Login_Page_Title");
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


#pragma -mark buttons IBActions

- (IBAction)newPlayerButtonTouched:(id)sender
{
}

- (IBAction)enterTheWorldButtonTouched:(id)sender
{
}

- (IBAction)forgetPasswordButtonTouched:(id)sender
{
}

#pragma -mark other controls events handlers

- (IBAction)backgroundTouched:(id)sender
{
    [self.user_textField resignFirstResponder];
    [self.password_textField resignFirstResponder];
}


#pragma -mark text feild Delagate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.tag == 0)
    {
        self.view.transform = CGAffineTransformMakeTranslation(0, -20);
    }
    else if (textField.tag == 1)
    {
        self.view.transform = CGAffineTransformMakeTranslation(0, -100);
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    self.view.transform = CGAffineTransformIdentity;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self backgroundTouched:nil];
    return NO;
}

- (void)viewDidUnload {
    [self setUser_textField:nil];
    [self setPassword_textField:nil];
    [super viewDidUnload];
}
@end
