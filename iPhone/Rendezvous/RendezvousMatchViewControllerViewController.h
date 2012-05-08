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

@interface RendezvousMatchViewControllerViewController : UIViewController <FBDialogDelegate,FBRequestDelegate>
{
    NSMutableData *responseData;
}
@property (retain, nonatomic) NSMutableData *responseData;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) NSString *matchName;
@property (weak, nonatomic) NSString *matchedUserId;
@property (weak, nonatomic) IBOutlet UIImageView *matchPhoto;

@end
