//
//  RendezvousMatchViewControllerViewController.h
//  Rendezvous
//
//  Created by akonig on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RendezvousAppDelegate.h"
#import "RendezvousCurrentUser.h"

typedef enum fbRequest {
    kLoadAlbums,
    kloadPhotos
} fbRequest;


@interface RendezvousMatchViewControllerViewController : UIViewController <FBDialogDelegate,FBRequestDelegate>
{
    
    NSMutableData *responseData;
    RendezvousCurrentUser *sharedSingleton;
    NSArray *_photos;
    int currentfbRequest;
    IBOutlet UIButton*clockButton;
    IBOutlet UIButton*infoButton;
    IBOutlet UIButton*messageButton;
    UIImage *slideImage;
    UIImage *slideImage2;
    UIImage *slideImage3;
    UIImage *slideImage4;
    UIImage *slideImage5;
    UIImage *slideImage6;
    UIImage *slideImage7;
    UIImage *slideImage8;
    UIImage *slideImage9;
    UIImageView *slideImageView;
    UIImageView *slideImageView2;
    UIImageView *slideImageView3;
    UIImageView *slideImageView4;
    UIImageView *slideImageView5;
    UIImageView *slideImageView6;
    UIImageView *slideImageView7;
    UIImageView *slideImageView8;
    UIImageView *slideImageView9;
    UITextView *timeBox;
    UITextView *infoBox;
    UIButton *backButton;
    BOOL isInClock;
    BOOL isInInfo;
    UITextView *pleaseWait;
    UIActivityIndicatorView *spinner;
}
@property ( nonatomic) NSMutableData *responseData;
@property ( nonatomic) UIScrollView *scroll;
@property ( nonatomic) IBOutlet UILabel *nameLabel;
@property ( nonatomic) IBOutlet UIImageView *initial;
@property ( nonatomic) NSString *matchName;
@property ( nonatomic) NSString *matchedUserId;
@property ( nonatomic) IBOutlet UIImageView *matchPhoto;
@property (nonatomic) NSArray *photos;
@property ( nonatomic) NSTimer *timer;


-(IBAction)ButtonPressed:(id)sender;
@property ( nonatomic) IBOutlet UIButton *photoButton;

@end


