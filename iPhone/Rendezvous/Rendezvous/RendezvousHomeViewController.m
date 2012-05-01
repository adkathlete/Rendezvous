//
//  RendezvousViewController.m
//  Rendezvous
//
//  Created by akonig on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RendezvousHomeViewController.h"

@interface RendezvousHomeViewController ()

@end

@implementation RendezvousHomeViewController
@synthesize nameLabel,userName,userPhoto;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSURL *newurl = [NSURL URLWithString:@"http://mtnweekly.com/wp-content/uploads/2011/10/Stanford.jpg"];
    //UIImage *img = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:newurl]];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ourMethod) name:@"DataModelComplete" object:nil];
    //RendezvousCurrentUser *sharedSingelton=[RendezvousCurrentUser sharedInstance];
    //NSLog(@"hello");
    //NSLog([sharedSingelton userId]);
    //[self apiGraphFriends];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)ourMethod
{
    RendezvousCurrentUser *sharedSingelton=[RendezvousCurrentUser sharedInstance];
    [nameLabel setText:[[sharedSingelton userInfo] objectForKey:@"firstName"]];
    userPhoto.image= [self imageForObject:[sharedSingelton userId]];
    
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

- (void)request:(FBRequest *)request didLoad:(id)result
{
    NSLog(@"We Got Us A Response");
    NSLog(@"Facebook request %@ loaded", [request url]);
    
    
    
}


@end
