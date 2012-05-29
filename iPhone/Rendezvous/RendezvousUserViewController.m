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

- (IBAction)photoButtonPressed:(id)sender 
{
    
    currentfbRequest=kLoadAlbums;
    
    RendezvousCurrentUser *sharedSingleton=[RendezvousCurrentUser sharedInstance];
    RendezvousAppDelegate *delegate = (RendezvousAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *path=[NSString stringWithFormat:@"%@/albums",[sharedSingleton visitingId]];
    [[delegate facebook] requestWithGraphPath:path andDelegate:self];
    
}

- (IBAction)sendMessage:(id)sender {
    RendezvousCurrentUser *s = [RendezvousCurrentUser sharedInstance];
    s.visitingMessageId=[s visitingId];
    
    if([[s uniqueMessageUserIDs] containsObject:s.visitingId]){
        [self performSegueWithIdentifier:@"userChat" sender: self];
    }else{
        NSMutableArray *newChat = [[NSMutableArray alloc] init];
        [[s messages] setValue:newChat forKey:s.visitingId];
        NSLog(@"Add new Chat!");
        [self performSegueWithIdentifier:@"userChat" sender: self];
        
    }

}

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

