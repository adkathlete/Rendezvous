//
//  RendezvousViewController.h
//  Rendezvous
//
//  Created by akonig on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RendezvousAppDelegate.h"
#import "RendezvousCurrentUser.h"

@interface RendezvousHomeViewController : UIViewController <FBDialogDelegate,FBRequestDelegate>
{
    NSArray *_photos;
    UIImageView *userPhoto;
}
@property (retain, nonatomic) NSTimer *timer;
@property (retain, nonatomic) IBOutlet UILabel *nameLabel;
@property (retain, nonatomic) IBOutlet UILabel *timeLabel;
@property (retain, nonatomic) IBOutlet UILabel *dayLabel;
@property (retain, nonatomic) IBOutlet UILabel *hourLabel;
@property (retain, nonatomic) IBOutlet UILabel *minuteLabel;
@property (retain, nonatomic) IBOutlet UILabel *secondLabel;
@property (retain, nonatomic) NSString *userName;
@property (retain, nonatomic) IBOutlet UIImageView *userPhoto;
@property (retain, nonatomic) IBOutlet UIButton *photoButton;
@property (nonatomic, retain) NSArray *photos;

@end
