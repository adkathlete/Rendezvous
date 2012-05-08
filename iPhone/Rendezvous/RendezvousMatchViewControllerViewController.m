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
    [super viewDidLoad];
    [self lookForMatch];
}

/*
 Gets the ID of the user whom someone is matched. If a match exists, it will set the photo and the name label
 */
-(void)lookForMatch
{
    self.responseData = [NSMutableData data];
    RendezvousCurrentUser *sharedSingelton=[RendezvousCurrentUser sharedInstance];
    NSString * userId = [sharedSingelton userId];
    NSString * urlString = [@"http://rendezvous.cs147.org/getMatch.php?id=" stringByAppendingString:userId];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
    NSLog(urlString);
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	self.responseData = nil;
}

#pragma mark Process loan data
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSString *matchedUserId = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    if ([matchedUserId length] == 0)
    {
        [nameLabel setText:@"Unfortunately, you don't have a \n match loser :("];
    }
    else
    {
        [self getFacebookName:matchedUserId];
        matchPhoto.image= [self imageForObject:matchedUserId];
    }
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

- (void) getFacebookName: (NSString *) userID {
    RendezvousAppDelegate *delegate = (RendezvousAppDelegate *)[[UIApplication sharedApplication] delegate];
    [[delegate facebook] requestWithGraphPath:userID andDelegate:self]; 
}

/*  Fetches the name of the matched user given an id and sets it    */
- (void)request:(FBRequest *)request didLoad:(id)result
{
    NSLog(@"Bitch request %@ loaded", [request url]);
    NSDictionary *matchInfo = (NSDictionary *)result;
    matchName = [matchInfo objectForKey:@"name"];
    [nameLabel setText: matchName];
}


@end
