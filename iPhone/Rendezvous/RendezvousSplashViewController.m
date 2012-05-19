//
//  RendezvousSplashViewController.m
//  Rendezvous
//
//  Created by Bryce Kam on 5/8/12.
//  Copyright (c) 2012 Stanford University. All rights reserved.
//

#import "RendezvousSplashViewController.h"

@interface RendezvousSplashViewController ()

@end

@implementation RendezvousSplashViewController

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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(switchPage) name:@"DataModelComplete" object:nil];
    
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    RendezvousCurrentUser *sharedSingleton = [RendezvousCurrentUser sharedInstance];
    NSLog(@"sequence = %d",[[sharedSingleton listIDs] count]);

    

}

-(void)switchPage
{
    /*NSLog(@"STARTING SPLASH PAGE");
    
    // Construct your FQL Query 
    //NSString* fql = @"SELECT uid, name FROM user WHERE uid IN (SELECT uid2 FROM friend WHERE uid1 = me()) AND is_app_user = 1";
        NSString* fql = @"SELECT uid, name FROM user WHERE name = 'Bryce Kam'";
    NSLog(fql);
    
    // Create a params dictionary
    NSMutableDictionary* params = [NSMutableDictionary dictionaryWithObject:fql forKey:@"query"];
    
    // Make the request 
    RendezvousAppDelegate *delegate = (RendezvousAppDelegate *)[[UIApplication sharedApplication] delegate];
    [[delegate facebook] requestWithMethodName:@"fql.query" andParams:params andHttpMethod:@"GET" andDelegate:self];*/
    
    NSLog(@"Switching Page");
    RendezvousCurrentUser *sharedSingleton = [RendezvousCurrentUser sharedInstance];
    NSLog([sharedSingleton connectionCheck]);
    if ([[sharedSingleton connectionCheck] isEqualToString:@"Good"]) {
        [self performSegueWithIdentifier:@"test" sender: self];
    } else {
        [self performSegueWithIdentifier:@"badConnection" sender: self];
    }
}

/*- (void)request:(FBRequest*)request didLoad:(id)result {
    NSLog(@"didLoad() received result: %@", result);
}*/

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
