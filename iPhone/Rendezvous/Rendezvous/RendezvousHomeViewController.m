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
@synthesize photoButton;
@synthesize nameLabel,userName,userPhoto;
@synthesize photos = _photos;

- (void)viewDidLoad
{
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0xB6/255.0f
                                                                        green:0xED/255.0f
                                                                         blue:0xFD/255.0f alpha:1]; 
    
    [super viewDidLoad];
    
    
    NSURL *newurl = [NSURL URLWithString:@"http://mtnweekly.com/wp-content/uploads/2011/10/Stanford.jpg"];
    //UIImage *img = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:newurl]];
    [self ourMethod];
    
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ourMethod) name:@"DataModelComplete" object:nil];
    //RendezvousCurrentUser *sharedSingelton=[RendezvousCurrentUser sharedInstance];
    //NSLog(@"hello");
    //NSLog([sharedSingelton userId]);
    //[self apiGraphFriends];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)ourMethod
{
    RendezvousCurrentUser *sharedSingelton=[RendezvousCurrentUser sharedInstance];
    [nameLabel setText:[[sharedSingelton userInfo] objectForKey:@"firstName"]];
    userPhoto.image= [self imageForObject:[sharedSingelton userId]];
    //userPhoto.image=[[[sharedSingelton photos] objectAtIndex:0] underlyingImage];
    NSLog(@"rahrahrahrhahrahrahr");
    NSLog([sharedSingelton userId]);
    RendezvousAppDelegate *delegate = (RendezvousAppDelegate *)[[UIApplication sharedApplication] delegate];
    [[delegate facebook] requestWithGraphPath:@"me/picture" andDelegate:self];
    //[self apiGraphFriends];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setNameLabel:nil];
    [self setUserPhoto:nil];
    [self setPhotoButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (UIImage *)imageForObject:(NSString *)objectID {
    // Get the object image
    NSString *url = [[NSString alloc] initWithFormat:@"https://graph.facebook.com/%@/picture?type=large",objectID];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
    return image;
}

- (IBAction)displayUserPhotos:(id)sender {
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = YES;
    //browser.wantsFullScreenLayout = NO;
    //[browser setInitialPageIndex:2];
    
    RendezvousCurrentUser *sharedSingelton=[RendezvousCurrentUser sharedInstance];
    self.photos = [sharedSingelton photos];
    [self.navigationController pushViewController:browser animated:YES];

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

- (void)request:(FBRequest *)request didLoad:(id)result
{
    NSLog(@"We Got Us A Response");
    NSLog(@"Facebook request %@ loaded", [request url]);
    
    
    
}


@end
