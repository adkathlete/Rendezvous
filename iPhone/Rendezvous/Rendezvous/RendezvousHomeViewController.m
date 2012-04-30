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
@synthesize nameLabel,userName;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self apiGraphFriends];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setNameLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)apiGraphFriends {
    // Do not set current API as this is commonly called by other methods
    RendezvousAppDelegate *delegate = (RendezvousAppDelegate *)[[UIApplication sharedApplication] delegate];
    [[delegate facebook] requestWithGraphPath:@"me" andDelegate:self];
    NSLog(@"Hey");
}

- (void)request:(FBRequest *)request didLoad:(id)result
{
    NSLog(@"We Got Us A Response");
    NSLog(@"Facebook request %@ loaded", [request url]);
   
    NSString *nameID = [result objectForKey:@"name"];
    
    NSMutableArray *userData = [[NSMutableArray alloc] initWithObjects:
                                [NSDictionary dictionaryWithObjectsAndKeys:
                                 [result objectForKey:@"id"], @"id",
                                 nameID, @"name",
                                 [result objectForKey:@"picture"], @"details",
                                 nil], nil];
    [nameLabel setText:nameID];
    NSLog(nameID);
    
    
    
}


@end
