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
    int currentfbRequest;
    NSArray *_photos;
}
@property (retain, nonatomic) NSMutableData *responseData;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) NSString *matchName;
@property (weak, nonatomic) NSString *matchedUserId;
@property (weak, nonatomic) IBOutlet UIImageView *matchPhoto;
@property (weak, nonatomic) IBOutlet UIButton *photoButton;
@property (nonatomic, retain) NSArray *photos;

@end
