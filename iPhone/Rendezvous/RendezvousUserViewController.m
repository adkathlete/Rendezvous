//
//  RendezvousUserViewController.m
//  Rendezvous
//
//  Created by akonig on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RendezvousUserViewController.h"
#import <QuartzCore/QuartzCore.h>



@interface RendezvousUserViewController ()

@end

@implementation RendezvousUserViewController
@synthesize nameLabel,userName,userPhoto, userId;
@synthesize photos = _photos;
@synthesize photoButton;
@synthesize messageButton;


- (CGRect)getFrameSizeForImage:(UIImage *)image inImageView:(UIImageView *)imageView {
    
    float hfactor = image.size.width / imageView.frame.size.width;
    float vfactor = image.size.height / imageView.frame.size.height;
    
    float factor = fmax(hfactor, vfactor);
    
    // Divide the size by the greater of the vertical or horizontal shrinkage factor
    float newWidth = image.size.width / factor;
    float newHeight = image.size.height / factor;
    
    // Then figure out if you need to offset it to center vertically or horizontally
    float leftOffset = (imageView.frame.size.width - newWidth) / 2;
    float topOffset = (imageView.frame.size.height - newHeight) / 2;
    
    return CGRectMake(leftOffset, topOffset, newWidth, newHeight);
}

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
    NSLog(userId);
    userName = [[sharedSingleton listUserInfo] objectForKey:userId];
    if(!userName){
        userName=[[sharedSingleton matchInfo] objectForKey:userId];
    }
    [nameLabel setText: userName];
    userPhoto.image= [self imageForObject:userId];
    [userPhoto.layer setBorderColor: [[UIColor whiteColor] CGColor]];
    [userPhoto.layer setBorderWidth: 4.0];
    CGRect frame = [self getFrameSizeForImage:userPhoto.image inImageView:userPhoto];
    CGRect imageViewFrame = CGRectMake(userPhoto.frame.origin.x + frame.origin.x, userPhoto.frame.origin.y + frame.origin.y, frame.size.width, frame.size.height);
    userPhoto.frame = imageViewFrame;


    self.title=[NSString stringWithFormat:@"%@'s Page",userName];

}

- (void)viewDidUnload
{
    [self setPhotoButton:nil];
    [self setMessageButton:nil];
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
    NSLog(@"SEND MESSAGE!");
    NSLog(@"Message Id is: %@",[s visitingMessageId]);
    s.visitingMessageId=[s visitingId];
    
    if([[s uniqueMessageUserIDs] containsObject:s.visitingId]){
        [self performSegueWithIdentifier:@"userChat" sender: self];
    }else{
        NSMutableArray *newChat = [[NSMutableArray alloc] init];
        [[s messages] setValue:newChat forKey:s.visitingId];
        NSLog(@"Add new Chat!");
        NSLog([s visitingMessageId]);
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

