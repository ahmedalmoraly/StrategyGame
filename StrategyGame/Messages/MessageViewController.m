//
//  MessageViewController.m
//  Game
//
//  Created by Artgin on 12/15/12.
//  Copyright (c) 2012 Innovaton. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageViewCell.h"
#import "YIPopupTextView.h"

#define DISMISS_OPTION_MENU_BUTTON_TAG 999

@interface MessageViewController () <YIPopupTextViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *table;

@property (strong, nonatomic) NSMutableArray *messagesArray;
@property (weak, nonatomic) IBOutlet UIView *optionsView;

@property (weak, nonatomic) IBOutlet MessageViewCell *messageCell;

- (IBAction)toggleOptionsMenuView:(id)sender;
- (IBAction)reply:(id)sender;

@end

@implementation MessageViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self loadMessages];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toggleOptionsMenuView:(id)sender
{
    if (CGAffineTransformIsIdentity(self.optionsView.transform))
    {
        UIButton *dismissBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        dismissBtn.tag = DISMISS_OPTION_MENU_BUTTON_TAG;
        dismissBtn.frame = self.view.frame;
        [dismissBtn addTarget:self action:@selector(hideOptionsMenu:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view insertSubview:dismissBtn belowSubview:self.optionsView];
        [self showOptionsMenu];
    }
    else
    {
        [[self.view viewWithTag:DISMISS_OPTION_MENU_BUTTON_TAG] removeFromSuperview];
        [self hideOptionsMenu:nil];
    }
    
}

- (IBAction)reply:(id)sender
{
    [self toggleOptionsMenuView:nil];
    [self showReplyTextView];
}

-(void)showOptionsMenu
{
    __weak MessageViewController *weakself = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakself.optionsView.transform = CGAffineTransformMakeTranslation(-58, 0);
    }];
}

-(void)hideOptionsMenu:(UIButton *)sender
{
    __weak MessageViewController *weakself = self;
    [UIView animateWithDuration:0.25 animations:^{
        weakself.optionsView.transform = CGAffineTransformIdentity;
    }];
    [sender removeFromSuperview];
}

-(void)loadMessages
{
    NSDictionary *message = @{@"title" : @"Message title", @"sender" : @"Ahmad al-Moraly", @"date" : @"12/12/2012", @"body" : @"Message body message body message body message body message body", @"sent" : @(YES)};
    NSDictionary *message2 = @{@"title" : @"Message title", @"sender" : @"BODY", @"date" : @"12/12/2012", @"body" : @"Message body message body message body message body message body message body message body Message body message body message body message body message body message body message body Message body message body message body message body message body message body message body", @"sent" : @(NO)};
    
    self.messagesArray = [@[message, message2, message, message2, message, message, message, message, message2, message, message,  message2, message, message2, message, message, message, message, message2, message, message2, message, message, message,  message2, message2] mutableCopy];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messagesArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"LeftMessageViewCell";
    NSDictionary *message = self.messagesArray[indexPath.row];
    if (message[@"sent"] == @(YES))
    {
        cellIdentifier = @"RightMessageViewCell";
    }
    else
    {
        cellIdentifier = @"LeftMessageViewCell";
    }
    
    MessageViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = self.messageCell;
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *message = self.messagesArray[indexPath.row];
    
    CGSize size = [message[@"body"] sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:(CGSize){290, MAXFLOAT}];
    
    return (size.height + 80.0f < 131) ? 131 : size.height + 80.0f;
    
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // delete datasource
        [self deleteMessageAtIndex:indexPath.row];
        // delete row
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}


-(void)configureCell:(MessageViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *message = self.messagesArray[indexPath.row];
    [cell setupWithData:message];
}

-(void)deleteMessageAtIndex:(NSInteger)index
{
    // remove from memory
    [self.messagesArray removeObjectAtIndex:index];
    
    // TODO: remove from remote server
}

-(void)showReplyTextView
{
     // NOTE: maxCount = 0 to hide count
 
    YIPopupTextView* popupTextView = [[YIPopupTextView alloc] initWithPlaceHolder:@"input here" maxCount:0 buttonStyle:YIPopupTextViewButtonStyleRightCancelAndDone tintsDoneButton:YES];
    
    popupTextView.delegate = self;
    
    popupTextView.caretShiftGestureEnabled = YES;   // default = NO
    
    [popupTextView showInView:self.view];

}

-(void)sendMessage:(NSString *)message
{
    // add to messagesArray
    
    NSDictionary *messageDic = @{@"title" : @"Message title", @"sender" : @"Ahmad al-Moraly", @"date" : [NSDate date], @"body" : message, @"sent" : @(YES)};
    [self.messagesArray addObject:messageDic];
    // add new row
    [self.table reloadData];
    [self.table scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(self.messagesArray.count - 1) inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    //[self.table insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:(self.messagesArray.count - 1) inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    // TODO: Send to remote
}

#pragma mark -

#pragma mark YIPopupTextViewDelegate

- (void)popupTextView:(YIPopupTextView *)textView willDismissWithText:(NSString *)text cancelled:(BOOL)cancelled
{
    NSLog(@"will dismiss: cancelled=%d withText: %@",cancelled, text);
    //self.textView.text = text;
}

- (void)popupTextView:(YIPopupTextView *)textView didDismissWithText:(NSString *)text cancelled:(BOOL)cancelled
{
    NSLog(@"did dismiss: cancelled=%d",cancelled);
    if (!cancelled && text && text.length) [self sendMessage:text];
}


#pragma mark -

#pragma mark Actions

- (IBAction)homeBtnTouched:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)optionsBtnTouched:(id)sender {
}

- (IBAction)moreBtnTouched:(id)sender {
}

- (IBAction)refreshBtnTouched:(id)sender {
}

- (IBAction)backBtnTouched:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
