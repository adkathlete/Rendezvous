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
    [self performSegueWithIdentifier:@"test" sender: self];
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

@end
