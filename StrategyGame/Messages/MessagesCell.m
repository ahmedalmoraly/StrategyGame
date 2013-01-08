//
//  MessagesCell.m
//  Game
//
//  Created by Ahmad al-Moraly on 12/12/12.
//  Copyright (c) 2012 Innovaton. All rights reserved.
//

#import "MessagesCell.h"

@implementation MessagesCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setMessageBackgroundHidden:(BOOL)read
{
    self.backgroundImageView.hidden = read;
}

-(void)setMessageRead:(BOOL)read
{
    if (read)
    {
        self.messageReadStatusIndicatorImageView.image = [UIImage imageNamed:@"dot_read"];
    }
    else
    {
        self.messageReadStatusIndicatorImageView.image = [UIImage imageNamed:@"dot_unread"];
    }
}

-(void)setMessageTitle:(NSString *)title
{
    self.messageTitleLabel.text = title;
}

-(void)setMessageSender:(NSString *)sender
{
    self.messageByUserLabel.text = sender;
}

-(void)setMessageSenderImage:(UIImage *)image
{
    self.messageUserImageView.image = image;
}

-(void)setMessageDate:(NSString *)date
{
    self.messageDateLabel.text = date;
}

-(void)setMessageBody:(NSString *)message
{
    self.messageDescriptionLabel.text = message;
}

-(void)setMessageCount:(NSString *)count
{
    [self.messageCountButton setTitle:count forState:UIControlStateNormal];
}


@end
