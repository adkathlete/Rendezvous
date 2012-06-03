//
//  RendezvousViewController.m
//  Rendezvous
//
//  Created by akonig on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RendezvousHomeViewController.h"

#import "QuartzCore/QuartzCore.h"



@interface RendezvousHomeViewController ()

@end


@implementation RendezvousHomeViewController
@synthesize nameLabel,userName,userPhoto,timer,timeLabel, dayLabel, hourLabel, minuteLabel, secondLabel;

@synthesize photoButton;
@synthesize photos = _photos;

- (void)viewDidLoad
{
    UINavigationBar *NavBar = [[self navigationController] navigationBar];
    UIImage *back = [UIImage imageNamed:@"Bar.png"];
    [NavBar setBackgroundImage:back forBarMetrics:UIBarMetricsDefault];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 40, 640, 640/11)];
    [label setFont:[UIFont fontWithName:@"Verdana-Bold" size:23.0]];
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor colorWithRed:209.0/255.0 green:209.0/255.0 blue:209.0/255.0 alpha:1.0];
    label.shadowColor = [UIColor colorWithRed:26.0/255.0 green:26.0/255.0 blue:26.0/255.0 alpha:1.0];
    label.shadowOffset = CGSizeMake(0, 1.3);
    label.text = @"THE COUNT DOWN";
    self.navigationItem.titleView = label;
   
    UIImage *selectedImage0 = [UIImage imageNamed:@"list.png"];
    UIImage *unselectedImage0 = [UIImage imageNamed:@"list.png"];
    
    UIImage *selectedImage1 = [UIImage imageNamed:@"heart.png"];
    UIImage *unselectedImage1 = [UIImage imageNamed:@"heart.png"];
    
    UIImage *selectedImage2 = [UIImage imageNamed:@"messageIcon.png"];
    UIImage *unselectedImage2 = [UIImage imageNamed:@"messageIcon.png"];
    
    UITabBar *tabBar = self.tabBarController.tabBar;
    UITabBarItem *item0 = [tabBar.items objectAtIndex:0];
    UITabBarItem *item1 = [tabBar.items objectAtIndex:1];
    UITabBarItem *item2 = [tabBar.items objectAtIndex:2];
    
    [item0 setFinishedSelectedImage:selectedImage0 withFinishedUnselectedImage:unselectedImage0];
    [item1 setFinishedSelectedImage:selectedImage1 withFinishedUnselectedImage:unselectedImage1];
    [item2 setFinishedSelectedImage:selectedImage2 withFinishedUnselectedImage:unselectedImage2];
    
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"info.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(onPress) forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(0, 0, 36, 36)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    NSDate *date=[NSDate date];
    int secondsNow=(int)[date timeIntervalSince1970];
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    int currentYear = [[formatter stringFromDate:date] intValue];
    int nextYear=currentYear+1;
    NSString *nextYearBegin=[NSString stringWithFormat:@"%d0101",nextYear];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *otherDate=[formatter dateFromString:nextYearBegin];
    // NSLog(@"%@",[otherDate description]);
    int secondsTarget=(int)[otherDate timeIntervalSince1970];
    int differenceSeconds=secondsTarget-secondsNow;
    int days=(int)((double)differenceSeconds/(3600.0*24.00));
    int diffDay=differenceSeconds-(days*3600*24);
    int hours=(int)((double)diffDay/3600.00);
    int diffMin=diffDay-(hours*3600);
    int minutes=(int)(diffMin/60.0);
    int seconds=diffMin-(minutes*60);
    timeLabel.text = [NSString stringWithFormat:@"%d Days %d Hours %d Minutes %d Seconds",days,hours,minutes,seconds];
    
    dayLabel.text = [NSString stringWithFormat:@"%d Days",days];
    hourLabel.text = [NSString stringWithFormat:@"%d Hours",hours];
    minuteLabel.text = [NSString stringWithFormat:@"%d Minutes",minutes];
    secondLabel.text = [NSString stringWithFormat:@"%d Seconds",seconds];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    NSDate *date=[NSDate date];
    int secondsNow=(int)[date timeIntervalSince1970];
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    int currentYear = [[formatter stringFromDate:date] intValue];
    int nextYear=currentYear+1;
    NSString *nextYearBegin=[NSString stringWithFormat:@"%d0101",nextYear];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *otherDate=[formatter dateFromString:nextYearBegin];
   // NSLog(@"%@",[otherDate description]);
    int secondsTarget=(int)[otherDate timeIntervalSince1970];
    int differenceSeconds=secondsTarget-secondsNow;
    int days=(int)((double)differenceSeconds/(3600.0*24.00));
    int diffDay=differenceSeconds-(days*3600*24);
    int hours=(int)((double)diffDay/3600.00);
    int diffMin=diffDay-(hours*3600);
    int minutes=(int)(diffMin/60.0);
    int seconds=diffMin-(minutes*60);
    timeLabel.text = [NSString stringWithFormat:@"%d Days %d Hours %d Minutes %d Seconds",days,hours,minutes,seconds];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
    
    
    
    
    NSURL *newurl = [NSURL URLWithString:@"http://mtnweekly.com/wp-content/uploads/2011/10/Stanford.jpg"];
    //UIImage *img = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:newurl]];
    [self ourMethod];
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ourMethod) name:@"DataModelComplete" object:nil];
    //RendezvousCurrentUser *sharedSingelton=[RendezvousCurrentUser sharedInstance];
    //NSLog(@"hello");
    //NSLog([sharedSingelton userId]);
    //[self apiGraphFriends];
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)timerFired:(NSTimer *)timer{
    NSDate *date=[NSDate date];
    int secondsNow=(int)[date timeIntervalSince1970];
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    int currentYear = [[formatter stringFromDate:date] intValue];
    int nextYear=currentYear+1;
    NSString *nextYearBegin=[NSString stringWithFormat:@"%d0101",nextYear];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *otherDate=[formatter dateFromString:nextYearBegin];
    //NSLog(@"%@",[otherDate description]);
    int secondsTarget=(int)[otherDate timeIntervalSince1970];
    int differenceSeconds=secondsTarget-secondsNow;
    int days=(int)((double)differenceSeconds/(3600.0*24.00));
    int diffDay=differenceSeconds-(days*3600*24);
    int hours=(int)((double)diffDay/3600.00);
    int diffMin=diffDay-(hours*3600);
    int minutes=(int)(diffMin/60.0);
    int seconds=diffMin-(minutes*60);
    timeLabel.text = [NSString stringWithFormat:@"%d Days %d Hours %d Minutes %d Seconds",days,hours,minutes,seconds];
    dayLabel.text = [NSString stringWithFormat:@"%d Days",days];
    hourLabel.text = [NSString stringWithFormat:@"%d Hours",hours];
    minuteLabel.text = [NSString stringWithFormat:@"%d Minutes",minutes];
    secondLabel.text = [NSString stringWithFormat:@"%d Seconds",seconds];
}

-(void) onPress {
    [self performSegueWithIdentifier:@"about" sender: self];
}

+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (void)timerFired:(NSTimer *)timer{
    NSDate *date=[NSDate date];
    int secondsNow=(int)[date timeIntervalSince1970];
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    int currentYear = [[formatter stringFromDate:date] intValue];
    int nextYear=currentYear+1;
    NSString *nextYearBegin=[NSString stringWithFormat:@"%d0101",nextYear];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSDate *otherDate=[formatter dateFromString:nextYearBegin];
    //NSLog(@"%@",[otherDate description]);
    int secondsTarget=(int)[otherDate timeIntervalSince1970];
    int differenceSeconds=secondsTarget-secondsNow;
    int days=(int)((double)differenceSeconds/(3600.0*24.00));
    int diffDay=differenceSeconds-(days*3600*24);
    int hours=(int)((double)diffDay/3600.00);
    int diffMin=diffDay-(hours*3600);
    int minutes=(int)(diffMin/60.0);
    int seconds=diffMin-(minutes*60);
    timeLabel.text = [NSString stringWithFormat:@"%d Days %d Hours %d Minutes %d Seconds",days,hours,minutes,seconds];
}

- (void)ourMethod
{
    RendezvousCurrentUser *sharedSingelton=[RendezvousCurrentUser sharedInstance];
    [nameLabel setText:[[sharedSingelton userInfo] objectForKey:@"firstName"]];
    userPhoto.image= [self imageForObject:[sharedSingelton userId]];
    //userPhoto.image=[[[sharedSingelton photos] objectAtIndex:0] underlyingImage];
    NSLog(@"rahrahrahrhahrahrahr");
    NSLog([sharedSingelton userId]);
    RendezvousAppDelegate *delegate = (RendezvousAppDelegate *)[[UIApplication sharedApplication] delegate];
    [[delegate facebook] requestWithGraphPath:@"me/picture" andDelegate:self];
    //[self apiGraphFriends];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setNameLabel:nil];
    [self setUserPhoto:nil];
    [self setPhotoButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (UIImage *)imageForObject:(NSString *)objectID {
    // Get the object image
    NSString *url = [[NSString alloc] initWithFormat:@"https://graph.facebook.com/%@/picture?type=large",objectID];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
    return image;
}

- (IBAction)displayUserPhotos:(id)sender {
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = YES;
    //browser.wantsFullScreenLayout = NO;
    //[browser setInitialPageIndex:2];
    
    RendezvousCurrentUser *sharedSingelton=[RendezvousCurrentUser sharedInstance];
    self.photos = [sharedSingelton photos];
    [self.navigationController pushViewController:browser animated:YES];

}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (MWPhoto *)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

//- (MWCaptionView *)photoBrowser:(MWPhotoBrowser *)photoBrowser captionViewForPhotoAtIndex:(NSUInteger)index {
//    MWPhoto *photo = [self.photos objectAtIndex:index];
//    MWCaptionView *captionView = [[MWCaptionView alloc] initWithPhoto:photo];
//    return [captionView autorelease];
//}

- (void)request:(FBRequest *)request didLoad:(id)result
{
    NSLog(@"We Got Us A Response");
    NSLog(@"Facebook request %@ loaded", [request url]);
    
    
    
}


@end
