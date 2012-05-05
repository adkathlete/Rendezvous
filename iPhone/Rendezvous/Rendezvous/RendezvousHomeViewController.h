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

@interface RendezvousHomeViewController : UIViewController <FBDialogDelegate,FBRequestDelegate>{
    
    UIImageView *userPhoto;
}
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) NSString *userName;
@property (retain, nonatomic) IBOutlet UIImageView *userPhoto;


@end