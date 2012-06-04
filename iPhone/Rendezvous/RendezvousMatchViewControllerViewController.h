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


@interface RendezvousMatchViewControllerViewController : UIViewController <FBDialogDelegate,FBRequestDelegate,MWPhotoBrowserDelegate>
{
    
    NSMutableData *responseData;
    RendezvousCurrentUser *sharedSingleton;
    NSArray *_photos;
    int currentfbRequest;
    IBOutlet UIButton*clockButton;
    IBOutlet UIButton*infoButton;
    UIImage *slideImage;
    UIImage *slideImage2;
    UIImage *slideImage3;
    UIImage *slideImage4;
    UIImage *slideImage5;
    UIImage *slideImage6;
    UIImageView *slideImageView;
    UIImageView *slideImageView2;
    UIImageView *slideImageView3;
    UIImageView *slideImageView4;
    UIImageView *slideImageView5;
    UIImageView *slideImageView6;
    UITextView *timeBox;
    UITextView *infoBox;
    BOOL isInClock;
    BOOL isInInfo;
}
@property (retain, nonatomic) NSMutableData *responseData;
@property (retain, nonatomic) UIScrollView *scroll;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *initial;
@property (weak, nonatomic) NSString *matchName;
@property (weak, nonatomic) NSString *matchedUserId;
@property (weak, nonatomic) IBOutlet UIImageView *matchPhoto;
@property (nonatomic, retain) NSArray *photos;
@property (retain, nonatomic) NSTimer *timer;


-(IBAction)ButtonPressed:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *photoButton;

@end


