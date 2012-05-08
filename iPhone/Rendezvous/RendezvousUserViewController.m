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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadUserProfile) name:@"loadingUserPage" object:nil];
    [super viewDidLoad];
}


-(void)loadUserProfile
{
    RendezvousCurrentUser *sharedSingelton=[RendezvousCurrentUser sharedInstance];
    NSLog([sharedSingelton visitingId]);
    NSLog(@"New User ID");
    NSString * userId = [sharedSingelton visitingId];
    [self getFacebookName:userId];
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

- (void) getFacebookName: (NSString *) userID {
    RendezvousAppDelegate *delegate = (RendezvousAppDelegate *)[[UIApplication sharedApplication] delegate];
    [[delegate facebook] requestWithGraphPath:userID andDelegate:self]; 
}

/*  Fetches the name of the matched user given an id and sets it    */
- (void)request:(FBRequest *)request didLoad:(id)result
{
    NSLog(@"Bitch request %@ loaded", [request url]);
    NSDictionary *userInfo = (NSDictionary *)result;
    userName = [userInfo objectForKey:@"name"];
    [nameLabel setText: userName];
    userPhoto.image= [self imageForObject:[userInfo objectForKey:@"id"]];
    self.title=[NSString stringWithFormat:@"%@'s Page",[userInfo objectForKey:@"name"]];
}


@end
