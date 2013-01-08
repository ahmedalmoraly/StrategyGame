//
//  MessagesCell.h
//  Game
//
//  Created by Ahmad al-Moraly on 12/12/12.
//  Copyright (c) 2012 Innovaton. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessagesCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UILabel *messageTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageByLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageByUserLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageDescriptionLabel;
@property (weak, nonatomic) IBOutlet UIImageView *messageUserImageView;
@property (weak, nonatomic) IBOutlet UIImageView *messageReadStatusIndicatorImageView;
@property (weak, nonatomic) IBOutlet UIButton *messageCountButton;


-(void)setMessageBackgroundHidden:(BOOL)read;

-(void)setMessageRead:(BOOL)read;
-(void)setMessageTitle:(NSString *)title;
-(void)setMessageSender:(NSString *)sender;
-(void)setMessageSenderImage:(UIImage *)image;
-(void)setMessageDate:(NSString *)date;
-(void)setMessageBody:(NSString *)message;
-(void)setMessageCount:(NSString *)count;


@end
