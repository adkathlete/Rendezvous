//
//  RendezvousOldMatchesViewController.h
//  Rendezvous
//
//  Created by akonig on 5/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RendezvousCurrentUser.h"

@interface RendezvousOldMatchesViewController : UITableViewController <FBDialogDelegate,FBRequestDelegate>
{
    NSMutableData *responseData;
    RendezvousCurrentUser *sharedSingleton;
}

@property (retain, nonatomic) NSMutableData* responseData;


@end
