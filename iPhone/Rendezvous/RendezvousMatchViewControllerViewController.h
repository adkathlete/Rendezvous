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
    IBOutlet UIButton*moveButton;
    UIImage *slideImage;
    UIImageView *slideImageView;
    UIImageView *slideImageView2;
    UILabel *information;
    BOOL isIn;
}
@property (retain, nonatomic) NSMutableData *responseData;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) NSString *matchName;
@property (weak, nonatomic) NSString *matchedUserId;
@property (weak, nonatomic) IBOutlet UIImageView *matchPhoto;
@property (nonatomic, retain) NSArray *photos;
@property (retain, nonatomic) NSTimer *timer;


-(IBAction)ButtonPressed:(id)sender;

@end
