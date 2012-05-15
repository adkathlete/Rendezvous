//
//  RendezvousMatchViewControllerViewController.m
//  Rendezvous
//
//  Created by akonig on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RendezvousMatchViewControllerViewController.h"

@interface RendezvousMatchViewControllerViewController ()

@end

@implementation RendezvousMatchViewControllerViewController
@synthesize nameLabel,matchName,matchPhoto, matchedUserId, responseData;


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
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0xB6/255.0f
                                                                        green:0xED/255.0f
                                                                         blue:0xFD/255.0f alpha:1]; 
    sharedSingleton = [RendezvousCurrentUser sharedInstance];
    
    if ([[sharedSingleton matchedUserId] length] == 0)
    {
        [nameLabel setText:@"Unfortunately, you don't have a \n match loser :("];
    }
    else
    {
        [nameLabel setText: [sharedSingleton matchName]];
        matchPhoto.image= [self imageForObject: [sharedSingleton matchedUserId]];
    }
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [self setNameLabel:nil];
    [self setMatchName:nil];
    [self setMatchPhoto:nil];
    [self setMatchPhoto:nil];
    [self setMatchPhoto:nil];
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
