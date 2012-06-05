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

@interface RendezvousUserViewController : UIViewController <MWPhotoBrowserDelegate>
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
    
    BOOL isInClock;
    BOOL isInInfo;
}


@property (retain, nonatomic) NSMutableData *responseData;
@property (weak, nonatomic) NSString *userName;
@property (weak, nonatomic) NSString *userId;
@property (weak, nonatomic) IBOutlet UIImageView *userPhoto;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) NSArray *photos;
@property (weak, nonatomic) IBOutlet UIButton *photoButton;
@property (retain, nonatomic) UIScrollView *scroll;
@property (retain, nonatomic) NSTimer *timer;


@end
