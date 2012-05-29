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
    NSArray *_photos;
    int currentfbRequest;
}

@property (weak, nonatomic) NSString *userName;
@property (weak, nonatomic) NSString *userId;
@property (weak, nonatomic) IBOutlet UIImageView *userPhoto;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic, retain) NSArray *photos;
@property (weak, nonatomic) IBOutlet UIButton *photoButton;

@end
