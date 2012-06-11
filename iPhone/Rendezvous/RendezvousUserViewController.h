//
//  RendezvousUserViewController.h
//  Rendezvous
//
//  Created by akonig on 5/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RendezvousCurrentUser.h"

typedef enum fbRequest {
    kLoadAlbums,
    kloadPhotos
} fbRequest;

@interface RendezvousUserViewController : UIViewController
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
    UITextView *pleaseWait;
    UIActivityIndicatorView *spinner;
    int count;
    BOOL isInClock;
    BOOL isInInfo;
}


@property ( nonatomic) NSMutableData *responseData;
@property ( nonatomic) NSString *userName;
@property ( nonatomic) NSString *userId;
@property ( nonatomic) IBOutlet UIImageView *userPhoto;
@property ( nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic) NSArray *photos;
@property ( nonatomic) IBOutlet UIButton *photoButton;
@property ( nonatomic) UIScrollView *scroll;
@property ( nonatomic) NSTimer *timer;


@end
