//
//  RendezvousViewController.m
//  Rendezvous
//
//  Created by akonig on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RendezvousHomeViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface RendezvousHomeViewController ()

@end

@implementation RendezvousHomeViewController
@synthesize photoButton;
@synthesize nameLabel,userName,userPhoto;
@synthesize photos = _photos;
@synthesize timeLabel,timer;

- (void)viewDidLoad
{
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0xB6/255.0f
                                                                        green:0xED/255.0f
                                                                         blue:0xFD/255.0f alpha:1]; 
    
    [super viewDidLoad];
    
    
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
