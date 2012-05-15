//
//  RendezvousUserViewController.m
//  Rendezvous
//
//  Created by akonig on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RendezvousUserViewController.h"


@interface RendezvousUserViewController ()

@end

@implementation RendezvousUserViewController
@synthesize nameLabel,userName,userPhoto, userId;


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
    NSLog(@"VIEWDIDLOAD");
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadUserProfile) name:@"loadingUserPage" object:nil];
    [self loadUserProfile];
    [super viewDidLoad];
}


-(void)loadUserProfile
{
    RendezvousCurrentUser *sharedSingleton=[RendezvousCurrentUser sharedInstance];
    NSLog([sharedSingleton visitingId]);
    NSLog(@"New User ID");
    NSString * userId = [sharedSingleton visitingId];
    userName = [[sharedSingleton listUserInfo] objectForKey:userId];
    [nameLabel setText: userName];
    userPhoto.image= [self imageForObject:userId];
    self.title=[NSString stringWithFormat:@"%@'s Page",userName];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (UIImage *)imageForObject:(NSString *)objectID {
    // Get the object image
    NSString *url = [[NSString alloc] initWithFormat:@"https://graph.facebook.com/%@/picture?type=large",objectID];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
    return image;
}

@end
