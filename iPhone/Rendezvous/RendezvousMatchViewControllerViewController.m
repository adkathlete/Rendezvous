//
//  RendezvousMatchViewControllerViewController.m
//  Rendezvous
//
//  Created by akonig on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RendezvousMatchViewControllerViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface RendezvousMatchViewControllerViewController ()

@end

@implementation RendezvousMatchViewControllerViewController
@synthesize nameLabel,matchName,matchPhoto, matchedUserId, responseData, timer, scroll,initial;

@synthesize photoButton;
@synthesize photos = _photos;


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
    
    isInClock = true;
    isInInfo = true;
    UINavigationBar *NavBar = [[self navigationController] navigationBar];
    UIImage *back = [UIImage imageNamed:@"Bar.png"];
    [NavBar setBackgroundImage:back forBarMetrics:UIBarMetricsDefault];
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 40, 640, 640/11)];
    [label setFont:[UIFont fontWithName:@"Verdana-Bold" size:27.0]];
    label.textAlignment = UITextAlignmentCenter;
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor colorWithRed:209.0/255.0 green:209.0/255.0 blue:209.0/255.0 alpha:1.0];
    label.shadowColor = [UIColor colorWithRed:26.0/255.0 green:26.0/255.0 blue:26.0/255.0 alpha:1.0];
    label.shadowOffset = CGSizeMake(0, 1.3);
    label.text = @"    MY MATCH";
    self.navigationItem.titleView = label;
    
    //    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MyList.png"]];
    //    UIBarButtonItem * item = [[UIBarItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"yourimage2.jpg"]]];    
    //    self.navigationItem.rightBarButtonItem = item; 
    //    
    UIImage *selectedImage0 = [UIImage imageNamed:@"list.png"];
    UIImage *unselectedImage0 = [UIImage imageNamed:@"list.png"];
    
    UIImage *selectedImage1 = [UIImage imageNamed:@"heart.png"];
    UIImage *unselectedImage1 = [UIImage imageNamed:@"heart.png"];
    
    UIImage *selectedImage2 = [UIImage imageNamed:@"messageIcon2.png"];
    UIImage *unselectedImage2 = [UIImage imageNamed:@"messageIcon2.png"];
    
    UITabBar *tabBar = self.tabBarController.tabBar;
    UITabBarItem *item0 = [tabBar.items objectAtIndex:0];
    UITabBarItem *item1 = [tabBar.items objectAtIndex:1];
    UITabBarItem *item2 = [tabBar.items objectAtIndex:2];
    
    [item0 setFinishedSelectedImage:selectedImage0 withFinishedUnselectedImage:unselectedImage0];
    [item1 setFinishedSelectedImage:selectedImage1 withFinishedUnselectedImage:unselectedImage1];
    [item2 setFinishedSelectedImage:selectedImage2 withFinishedUnselectedImage:unselectedImage2];
    [self.navigationController setNavigationBarHidden: NO animated:NO];
    
    RendezvousCurrentUser *s = [RendezvousCurrentUser sharedInstance];
    if ([s.matchedUserId length] != 0) {
        [self loadUserPhotos];
    } 
    [super loadView];
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"stripeBack.png"]]];
    
    if ([s.matchedUserId length] != 0) {
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [spinner setCenter:self.view.center];
    [spinner startAnimating];
    [self.view addSubview:spinner];
    [self.view bringSubviewToFront:spinner];
    }
    
    UITextView *pleaseWait = [[UITextView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/2 + 20, self.view.frame.size.width, self.view.frame.size.height)];
    [pleaseWait setUserInteractionEnabled:NO];
    [pleaseWait setFont:[UIFont fontWithName:@"Verdana-Bold" size:17.0]];
    pleaseWait.textAlignment = UITextAlignmentCenter;
    pleaseWait.backgroundColor = [UIColor clearColor];
    pleaseWait.textColor = [UIColor colorWithRed:209.0/255.0 green:209.0/255.0 blue:209.0/255.0 alpha:1.0];
    pleaseWait.text = @"loading...";
    if ([s.matchedUserId length] == 0) pleaseWait.text = @"Sorry, you do not currently have a match.";
    [self.view addSubview:pleaseWait];
    [self.view bringSubviewToFront: pleaseWait];

    UIImage *frameImage = [UIImage imageNamed:@"photoBrowserBackground3.png"];
    UIImageView *frameView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height -47)];
    frameView.image = frameImage;
    [self.view addSubview:frameView];
    [self.view bringSubviewToFront: frameView];
    
    if ([s.matchedUserId length] == 0) [self displayPage];
}

-(void) onPress {
    [self performSegueWithIdentifier:@"home" sender: self];
}

-(IBAction)ClockPressed:(id)sender
{
    if (isInClock) {
        isInClock = false;
        slideImageView.center = CGPointMake(self.view.frame.size.width - slideImage.size.width/2 - 190, 60);
        slideImageView2.center = CGPointMake(self.view.frame.size.width - slideImage2.size.width/2 - 190, 43);
        slideImageView3.center = CGPointMake(self.view.frame.size.width - slideImage3.size.width/2-190, 74);
        [clockButton setCenter:CGPointMake(self.view.frame.size.width - 204, 60)];
        timeBox.hidden = NO;
    } else {
        isInClock = true;
        slideImageView.center = CGPointMake(self.view.frame.size.width - slideImage.size.width/2, 60);
        slideImageView2.center = CGPointMake(self.view.frame.size.width - slideImage2.size.width/2, 43);
        slideImageView3.center = CGPointMake(self.view.frame.size.width - slideImage3.size.width/2, 74);
        [clockButton setCenter:CGPointMake(self.view.frame.size.width - 14, 60)];
        timeBox.hidden = YES;
    }
    
}

-(IBAction)infoPressed:(id)sender
{
    if (isInInfo) {
        isInInfo = false;
        slideImageView4.center = CGPointMake(self.view.frame.size.width - slideImage4.size.width/2 - 190, 106);
        slideImageView5.center = CGPointMake(self.view.frame.size.width - slideImage5.size.width/2 - 190, 89);
        slideImageView6.center = CGPointMake(self.view.frame.size.width - slideImage6.size.width/2-190, 120);
        [infoButton setCenter:CGPointMake(self.view.frame.size.width - 204, 106)];
        infoBox.hidden = NO;
    } else {
        isInInfo = true;
        slideImageView4.center = CGPointMake(self.view.frame.size.width - slideImage4.size.width/2, 106);
        slideImageView5.center = CGPointMake(self.view.frame.size.width - slideImage5.size.width/2, 89);
        slideImageView6.center = CGPointMake(self.view.frame.size.width - slideImage6.size.width/2, 120);
        [infoButton setCenter:CGPointMake(self.view.frame.size.width - 14, 106)];
        infoBox.hidden = YES;
    }
    
}


- (void)loadUserPhotos
{
    NSLog(@"Load user Photos please");
    currentfbRequest=kLoadAlbums;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(displayPage) name:@"UserPhotosLoaded" object:nil];
    
    sharedSingleton = [RendezvousCurrentUser sharedInstance];
    RendezvousAppDelegate *delegate = (RendezvousAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *path=[NSString stringWithFormat:@"%@/albums",[sharedSingleton matchedUserId]];
    [[delegate facebook] requestWithGraphPath:path andDelegate:self];
    NSLog(@"Sent Facebook Load Command");
    
}

- (void)displayPage
{    
    sharedSingleton = [RendezvousCurrentUser sharedInstance];
    
    if ([sharedSingleton.matchedUserId length] != 0) {
        
        [nameLabel setText:[[sharedSingleton matchInfo] objectForKey:[sharedSingleton matchedUserId]]];
        
        matchPhoto.image= [self imageForObject: [sharedSingleton matchedUserId]];
        
        scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        scroll.scrollEnabled = YES;
        scroll.showsHorizontalScrollIndicator = NO;
        scroll.showsVerticalScrollIndicator = NO;
        UIImage *bar = [UIImage imageNamed:@"Jagged3.png"];
        UIImage *barLeft = [UIImage imageNamed:@"Jagged3.png"];
        UIImage *barRight = [UIImage imageNamed:@"Jagged3.png"];
        NSInteger numberOfViews = self.photos.count;
        NSInteger startX = 0;
        for (int i = 0; i < numberOfViews; i++) {
            UIImage *newImage = [self.photos objectAtIndex:i];
            NSInteger mesWidth = newImage.size.width * (self.view.frame.size.height /  newImage.size.height);
            
            UIImageView *awesomeView = [[UIImageView alloc] initWithFrame:CGRectMake(startX, 3, mesWidth, self.view.frame.size.height)];
            awesomeView.contentMode = UIViewContentModeScaleAspectFill;
            awesomeView.image=[self.photos objectAtIndex:i];
            [scroll addSubview:awesomeView];
            
            UIImageView *barView;
            if (i == 0) {
                barView = [[UIImageView alloc] initWithFrame:CGRectMake(startX - 15, 3, 30, self.view.frame.size.height)];
                barView.image=barLeft;
            } else {
                barView = [[UIImageView alloc] initWithFrame:CGRectMake(startX - 14, 3, 30, self.view.frame.size.height)];
                barView.image=bar;
            }
//            [scroll addSubview:barView];
            startX += mesWidth;
            if (i == numberOfViews-1 ) {
                UIImageView *barView = [[UIImageView alloc] initWithFrame:CGRectMake(startX - 13, 3, 30, self.view.frame.size.height)];
                barView.image=barRight;
                [scroll addSubview:barView];
            }
        }
        [scroll setContentOffset:CGPointMake(100, 0)];
        scroll.contentSize = CGSizeMake(startX, self.view.frame.size.height);
        scroll.backgroundColor = [UIColor whiteColor];
        
        [self.view addSubview:scroll];
        
        RendezvousCurrentUser *s = [RendezvousCurrentUser sharedInstance];
        UIGraphicsBeginImageContext(scroll.bounds.size);
        [scroll.layer renderInContext:UIGraphicsGetCurrentContext()];
        s.backgroundImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
        
        UIImage *frameImage = [UIImage imageNamed:@"photoBrowserBackground3.png"];
        UIImageView *frameView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height +2)];
        frameView.image = frameImage;
        [self.view addSubview:frameView];
        
        timeBox = [[UITextView alloc] initWithFrame:CGRectMake(129, 40, 192, 38)];
        [timeBox setUserInteractionEnabled:NO];
        NSDate *date=[NSDate date];
        int secondsNow=(int)[date timeIntervalSince1970];
        NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy"];
        int currentYear = [[formatter stringFromDate:date] intValue];
        int nextYear=currentYear+1;
        NSString *nextYearBegin=[NSString stringWithFormat:@"%d0101",nextYear];
        [formatter setDateFormat:@"yyyyMMdd"];
        NSDate *otherDate=[formatter dateFromString:nextYearBegin];
        int secondsTarget=(int)[otherDate timeIntervalSince1970];
        int differenceSeconds=secondsTarget-secondsNow;
        int days=(int)((double)differenceSeconds/(3600.0*24.00));
        int diffDay=differenceSeconds-(days*3600*24);
        int hours=(int)((double)diffDay/3600.00);
        int diffMin=diffDay-(hours*3600);
        int minutes=(int)(diffMin/60.0);
        int seconds=diffMin-(minutes*60);
        timeBox.text = [NSString stringWithFormat:@"%d:%d:%d:%d",days,hours,minutes,seconds];
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFired:) userInfo:nil repeats:YES];
        [timeBox setTextColor:[UIColor whiteColor]];
        [timeBox setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.7]];
        [timeBox setFont:[UIFont fontWithName: @"Verdana" size: 13.0f]]; 
        timeBox.hidden = YES;
        [self.view addSubview:timeBox];
        
        slideImage = [UIImage imageNamed:@"sideBarExtend.png"];
        slideImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, slideImage.size.width, slideImage.size.height +20)];
        slideImageView.image = slideImage;
        [self.view addSubview:slideImageView];
        slideImageView.center = CGPointMake(self.view.frame.size.width - slideImage.size.width/2, 60);
        
        slideImage2 = [UIImage imageNamed:@"sideBarTop.png"];
        slideImageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, slideImage2.size.width, slideImage2.size.height)];
        slideImageView2.image = slideImage2;
        [self.view addSubview:slideImageView2];
        slideImageView2.center = CGPointMake(self.view.frame.size.width - slideImage2.size.width/2, 43);
        
        slideImage3 = [UIImage imageNamed:@"sideBarBottom.png"];
        slideImageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, slideImage3.size.width, slideImage3.size.height)];
        slideImageView3.image = slideImage3;
        [self.view addSubview:slideImageView3];
        slideImageView3.center = CGPointMake(self.view.frame.size.width - slideImage3.size.width/2, 74);
        
        infoBox = [[UITextView alloc] initWithFrame:CGRectMake(129, 86, 192, 280)];
        infoBox.text = @"Rejection sucks.\n\nRendezvous is here to help.\n\nThis is the no nonsense, totally risk-free app that finds out if your crushes are crushing on you.\n\nWe know you've got an \"i-would-totally-makeout-with-this-person\" list in your head. So do all of your friends and classmates. Wouldn't it be cool if there was some way to discreetly match people with a mutual interest in each other?";
        [infoBox setTextColor:[UIColor whiteColor]];
        [infoBox setBackgroundColor:[UIColor colorWithWhite:0.0 alpha:0.7]];
        [infoBox setFont:[UIFont fontWithName: @"Verdana" size: 11.0f]]; 
        infoBox.hidden = YES;
        [infoBox setUserInteractionEnabled:NO];
        [self.view addSubview:infoBox];
        
        clockButton =  [UIButton buttonWithType:UIButtonTypeCustom];
        [clockButton setImage:[UIImage imageNamed:@"clock.png"] forState:UIControlStateNormal];
        [clockButton addTarget:self action:@selector(ClockPressed:) forControlEvents:UIControlEventTouchUpInside];
        [clockButton setFrame:CGRectMake(10, 285, 60, 60)];
        [clockButton setCenter:CGPointMake(self.view.frame.size.width - 14, 61)];
        [self.view addSubview:clockButton];
        
        slideImage4 = [UIImage imageNamed:@"sideBarExtend.png"];
        slideImageView4 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, slideImage4.size.width, slideImage4.size.height +20)];
        slideImageView4.image = slideImage4;
        [self.view addSubview:slideImageView4];
        slideImageView4.center = CGPointMake(self.view.frame.size.width - slideImage4.size.width/2, 106);
        
        slideImage5 = [UIImage imageNamed:@"sideBarTop.png"];
        slideImageView5 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, slideImage5.size.width, slideImage5.size.height)];
        slideImageView5.image = slideImage5;
        [self.view addSubview:slideImageView5];
        slideImageView5.center = CGPointMake(self.view.frame.size.width - slideImage5.size.width/2, 89);
        
        slideImage6 = [UIImage imageNamed:@"sideBarBottom.png"];
        slideImageView6 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, slideImage6.size.width, slideImage6.size.height)];
        slideImageView6.image = slideImage6;
        [self.view addSubview:slideImageView6];
        slideImageView6.center = CGPointMake(self.view.frame.size.width - slideImage6.size.width/2, 120);
        
        infoButton =  [UIButton buttonWithType:UIButtonTypeCustom];
        [infoButton setImage:[UIImage imageNamed:@"info.png"] forState:UIControlStateNormal];
        [infoButton addTarget:self action:@selector(infoPressed:) forControlEvents:UIControlEventTouchUpInside];
        [infoButton setFrame:CGRectMake(10, 285, 60, 60)];
        [infoButton setCenter:CGPointMake(self.view.frame.size.width - 14, 106)];
        [self.view addSubview:infoButton];
        
        slideImage7 = [UIImage imageNamed:@"sideBarExtend.png"];
        slideImageView7 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, slideImage7.size.width, slideImage7.size.height +20)];
        slideImageView7.image = slideImage7;
        [self.view addSubview:slideImageView7];
        slideImageView7.center = CGPointMake(self.view.frame.size.width - slideImage7.size.width/2, 152);
        
        slideImage8 = [UIImage imageNamed:@"sideBarTop.png"];
        slideImageView8 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, slideImage8.size.width, slideImage8.size.height)];
        slideImageView8.image = slideImage8;
        [self.view addSubview:slideImageView8];
        slideImageView8.center = CGPointMake(self.view.frame.size.width - slideImage8.size.width/2,135);
        
        slideImage9 = [UIImage imageNamed:@"sideBarBottom.png"];
        slideImageView9 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, slideImage9.size.width, slideImage9.size.height)];
        slideImageView9.image = slideImage9;
        [self.view addSubview:slideImageView9];
        slideImageView9.center = CGPointMake(self.view.frame.size.width - slideImage9.size.width/2, 166);
        
    if ([sharedSingleton.matchedUserId length] != 0) {

    
        messageButton =  [UIButton buttonWithType:UIButtonTypeCustom];
        [messageButton setImage:[UIImage imageNamed:@"messageIcon2.png"] forState:UIControlStateNormal];
        [messageButton addTarget:self action:@selector(messagePressed:) forControlEvents:UIControlEventTouchUpInside];
        [messageButton setFrame:CGRectMake(10, 285, 60, 60)];
        [messageButton setCenter:CGPointMake(self.view.frame.size.width - 14, 148)];
        [self.view addSubview:messageButton];
    }
        
        NSLog(@"%f width", self.view.frame.size.height);
        
    
    
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
    timeBox.text = [NSString stringWithFormat:@"%d:%d:%d:%d",days,hours,minutes,seconds];
}


- (void)viewDidUnload
{
    [self setNameLabel:nil];
    [self setMatchName:nil];
    [self setMatchPhoto:nil];
    [self setMatchPhoto:nil];
    [self setMatchPhoto:nil];
    [self setPhotoButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(IBAction) messagePressed:(id)sender
{
    RendezvousCurrentUser *s = [RendezvousCurrentUser sharedInstance];
    s.visitingMessageId = s.matchedUserId;
    s.shouldSegueMessages = @"Yes";
    //self.tabBarController.selectedViewController = [self.tabBarController.viewControllers objectAtIndex:2];
    //NSLog(@"Seguing to messages");
    //NSLog(matchedUserId);
    [self performSegueWithIdentifier:@"toUserMessage" sender: self];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (UIImage *)imageForObject:(NSString *)objectID {
    
    NSString *url = [[NSString alloc] initWithFormat:@"https://graph.facebook.com/%@/picture?type=large",objectID];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
    
    
    return image;
}
- (IBAction)loadMatchPhotos:(id)sender {
    if ([[sharedSingleton matchIDs] count] != 0)
    {
        currentfbRequest=kLoadAlbums;
        
        RendezvousCurrentUser *sharedSingleton=[RendezvousCurrentUser sharedInstance];
        RendezvousAppDelegate *delegate = (RendezvousAppDelegate *)[[UIApplication sharedApplication] delegate];
        NSString *path=[NSString stringWithFormat:@"%@/albums",[sharedSingleton matchedUserId]];
        [[delegate facebook] requestWithGraphPath:path andDelegate:self];
    }
}
- (IBAction)messageUser:(id)sender {
    if ([[sharedSingleton matchIDs] count] != 0)
    {
        RendezvousCurrentUser *s = [RendezvousCurrentUser sharedInstance];
        s.visitingMessageId=[s matchedUserId];
        
        if([[s uniqueMessageUserIDs] containsObject:s.matchedUserId]){
            [self performSegueWithIdentifier:@"matchChat" sender: self];
        }else{
            NSMutableArray *newChat = [[NSMutableArray alloc] init];
            [[s messages] setValue:newChat forKey:s.matchedUserId];
            [self performSegueWithIdentifier:@"matchChat" sender: self];
            
        }
    }
    
    
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



#pragma mark - MWPhotoBrowserDelegate

//- (MWCaptionView *)photoBrowser:(MWPhotoBrowser *)photoBrowser captionViewForPhotoAtIndex:(NSUInteger)index {
//    MWPhoto *photo = [self.photos objectAtIndex:index];
//    MWCaptionView *captionView = [[MWCaptionView alloc] initWithPhoto:photo];
//    return [captionView autorelease];
//}

- (void)request:(FBRequest *)request didFailWithError:(NSError *)error {
    NSLog(@"Facebook Bad Request");
}


#pragma mark - FB callback

- (void)request:(FBRequest *)request didLoad:(id)result
{
    
    
    switch (currentfbRequest) {
        case kLoadAlbums:
        {
            
            NSLog(@"Facebook request %@ loaded", [request url]);
            NSArray *resultData = [result objectForKey:@"data"];
            for (NSDictionary *album in resultData) {
                NSLog([album   objectForKey:@"name"]);
                
                if([@"Profile Pictures" compare:[album objectForKey:@"name"]] ==NSOrderedSame)
                {
                    NSLog(@"Matched Album");
                    currentfbRequest=kloadPhotos;
                    RendezvousAppDelegate *delegate = (RendezvousAppDelegate *)[[UIApplication sharedApplication] delegate];
                    NSString *path=[NSString stringWithFormat:@"%@/photos",[album objectForKey:@"id"]];
                    [[delegate facebook] requestWithGraphPath:path andDelegate:self];
                }
                
            }
            
            break;
            
        }
        case kloadPhotos:
        {
            
            NSLog(@"Facebook request %@ loaded", [request url]);
            NSArray *resultData = [result objectForKey:@"data"];
            NSMutableArray *photos=[[NSMutableArray alloc] init];
            
            NSLog(@"Loading Photos");
            for (NSDictionary *photo in resultData) {
                NSLog([photo  objectForKey:@"source"]);
                [photos addObject:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[photo objectForKey:@"source"]]]]];
            }
            
            self.photos = photos;
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"UserPhotosLoaded" object:nil];
            break;
        }
    }
    
    
}


@end


