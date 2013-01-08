//
//  MessageViewCell.m
//  Game
//
//  Created by Artgin on 12/15/12.
//  Copyright (c) 2012 Innovaton. All rights reserved.
//

#import "MessageViewCell.h"

@interface MessageViewCell ()

@property (strong, nonatomic) UIImage *backImage;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UIImageView *senderImageView;
@property (weak, nonatomic) IBOutlet UILabel *senderNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;
@end

@implementation MessageViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.backImage = [UIImage imageNamed:@"message_BG"];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setupWithData:(NSDictionary *)data
{
    self.backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    self.senderNameLabel.text = [data objectForKey:@"sender"];
    self.dateLabel.text = [NSString stringWithFormat:@"%@", [data objectForKey:@"date"]];
    
    self.messageTextView.text = [data objectForKey:@"body"];
    
    self.messageTextView.frame = (CGRect){self.messageTextView.frame.origin, self.messageTextView.contentSize};

    self.backgroundImage.image = [self.backImage resizableImageWithCapInsets:UIEdgeInsetsMake(14, 0, 14, 0)];
}
@end
