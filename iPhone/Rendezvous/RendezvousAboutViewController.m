//
//  RendezvousAboutViewController.m
//  Rendezvous
//
//  Created by akonig on 5/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RendezvousAboutViewController.h"

@interface RendezvousAboutViewController ()

@end

@implementation RendezvousAboutViewController
@synthesize aboutLabel;

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
    UINavigationBar *NavBar = [[self navigationController] navigationBar];
    UIImage *back = [UIImage imageNamed:@"BarAbout.png"];
    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 640, 640/11)];
//    [label setFont:[UIFont fontWithName:@"Verdana-Bold" size:27.0]];
//    label.textAlignment = UITextAlignmentCenter;
//    label.backgroundColor = [UIColor colorWithRed:20.0/255.0 green:19.0/255.0 blue:19.0/255.0 alpha:1.0];
//    label.textColor = [UIColor colorWithRed:11.0/255.0 green:11.0/255.0 blue:11.0/255.0 alpha:1.0];
//    label.shadowColor = [UIColor colorWithRed:26.0/255.0 green:26.0/255.0 blue:26.0/255.0 alpha:1.0];
//    label.shadowOffset = CGSizeMake(0, 0.9);
//    label.text = @"ABOUT";
//    self.navigationItem.titleView = label;
    
    [NavBar setBackgroundImage:back forBarMetrics:UIBarMetricsDefault];
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
