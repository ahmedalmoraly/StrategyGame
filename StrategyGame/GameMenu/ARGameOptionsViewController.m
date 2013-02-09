//
//  ARGameOptionsViewController.m
//  StrategyGame
//
//  Created by Ali Amin on 2/9/13.
//  Copyright (c) 2013 Artgine. All rights reserved.
//

#import "ARGameOptionsViewController.h"
#import "iCarousel.h"
#import "FXImageView.h"

@interface ARGameOptionsViewController ()<iCarouselDataSource, iCarouselDelegate>

@property (weak, nonatomic) IBOutlet iCarousel *carousel;
@property (strong, nonatomic) NSArray *dataSource;

@end

@implementation ARGameOptionsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        self.dataSource = [Bookmark MR_findAll];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.carousel.type = iCarouselTypeRotary;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self setCarousel:nil];
    [super viewDidUnload];
}

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return self.dataSource.count;
}
- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    if (view == nil)
    {
        FXImageView *imageView = [[[FXImageView alloc] initWithFrame:CGRectMake(0, 0, 150.0f, 300.0f)] autorelease];
          imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.asynchronous = YES;
//        imageView.reflectionScale = 0.5f;
//        imageView.reflectionAlpha = 0.25f;
//        imageView.reflectionGap = 10.0f;
//        imageView.shadowOffset = CGSizeMake(0.0f, 2.0f);
//        imageView.shadowBlur = 5.0f;
        imageView.transform = CGAffineTransformMakeRotation(90 * M_PI / 180);
        imageView.clipsToBounds = YES;
        view = imageView;
    }
    
    //show placeholder
    ((FXImageView *)view).processedImage = [UIImage imageNamed:@"placeholder.png"];
    
    //set image with URL. FXImageView will then download and process the image
    [(FXImageView *)view setImageWithContentsOfFile:[self.dataSource[index] imageURL]];
    

    return view;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{   
    Bookmark *book = self.dataSource[index];
    Class class = NSClassFromString(book.classType);
    id viewController = [[class alloc] initWithNibName:book.classType bundle:nil];

    [(id)self.parentViewController pushViewController:viewController animated:YES];
}

@end
