//
//  RendezvousUserViewController.m
//  Rendezvous
//
//  Created by akonig on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RendezvousUserViewController.h"
#import "QuartzCore/QuartzCore.h"



@interface RendezvousUserViewController ()

@end

@implementation RendezvousUserViewController
@synthesize nameLabel,userName,userPhoto, userId;
@synthesize photos = _photos;
@synthesize photoButton;


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
    UIImage *back = [UIImage imageNamed:@"Bar.png"];
    [NavBar setBackgroundImage:back forBarMetrics:UIBarMetricsDefault];
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
    userPhoto.layer.masksToBounds = YES;
    userPhoto.layer.borderWidth = 4.0;
    userPhoto.layer.borderColor = [[UIColor whiteColor] CGColor];
    userPhoto.layer.shadowColor = [UIColor blackColor].CGColor;
    userPhoto.layer.shadowOffset = CGSizeMake(5, 8);
    userPhoto.layer.shadowOpacity = 100;
    userPhoto.layer.shadowRadius = 4.0;
    userPhoto.clipsToBounds = NO;
    
    self.title=[NSString stringWithFormat:@"%@'s Page",userName];

}


- (void)viewDidUnload
{
    [self setPhotoButton:nil];
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

- (IBAction)photoButtonPressed:(id)sender {
    
    currentfbRequest=kLoadAlbums;
    
    RendezvousCurrentUser *sharedSingleton=[RendezvousCurrentUser sharedInstance];
    RendezvousAppDelegate *delegate = (RendezvousAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *path=[NSString stringWithFormat:@"%@/albums",[sharedSingleton visitingId]];
    [[delegate facebook] requestWithGraphPath:path andDelegate:self];
    
    }

/*
-(void) updateUserPhotos
{
    NSLog(@"Loading Photos");
    // Create browser
    NSMutableArray *photos = [[NSMutableArray alloc] init];
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = YES;
    //browser.wantsFullScreenLayout = NO;
    //[browser setInitialPageIndex:2];
    [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm4.static.flickr.com/3567/3523321514_371d9ac42f_b.jpg"]]];
    [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm4.static.flickr.com/3629/3339128908_7aecabc34b_b.jpg"]]];
    [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm4.static.flickr.com/3364/3338617424_7ff836d55f_b.jpg"]]];
    [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm4.static.flickr.com/3590/3329114220_5fbc5bc92b_b.jpg"]]];
    
    self.photos = photos;
    [self.navigationController pushViewController:browser animated:YES];
    

    
}
*/

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
            
            NSLog(@"Loading Photos");
            // Create browser
            NSMutableArray *photos = [[NSMutableArray alloc] init];
            MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
            browser.displayActionButton = YES;
            //browser.wantsFullScreenLayout = NO;
            //[browser setInitialPageIndex:2];
            
            for (NSDictionary *photo in resultData) {
                NSLog([photo  objectForKey:@"source"]);
                [photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:[photo objectForKey:@"source"]]]];
            }
            
            self.photos = photos;
            [self.navigationController pushViewController:browser animated:YES];

            //[[NSNotificationCenter defaultCenter] postNotificationName:@"UserPhotosLoaded" object:nil];
            break;
        }
    }
    
    
}


@end

