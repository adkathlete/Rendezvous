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
@synthesize photoButton;
@synthesize nameLabel,matchName,matchPhoto, matchedUserId, responseData;
@synthesize photos = _photos;


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
- (IBAction)loadMatchPhotos:(id)sender {
    currentfbRequest=kLoadAlbums;
    
    RendezvousCurrentUser *sharedSingleton=[RendezvousCurrentUser sharedInstance];
    RendezvousAppDelegate *delegate = (RendezvousAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *path=[NSString stringWithFormat:@"%@/albums",[sharedSingleton matchedUserId]];
    [[delegate facebook] requestWithGraphPath:path andDelegate:self];
    
}
- (IBAction)messageUser:(id)sender {
    RendezvousCurrentUser *s = [RendezvousCurrentUser sharedInstance];
    s.visitingMessageId=[s matchedUserId];
    
    if([[s uniqueMessageUserIDs] containsObject:s.matchedUserId]){
        [self performSegueWithIdentifier:@"matchChat" sender: self];
    }else{
        NSMutableArray *newChat = [[NSMutableArray alloc] init];
        [[s messages] setValue:newChat forKey:s.matchedUserId];
        [self performSegueWithIdentifier:@"matchChat" sender: self];
        
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


