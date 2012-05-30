//
//  RendezvousMessagesViewController.h
//  Rendezvous
//
//  Created by akonig on 5/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RendezvousCurrentUser.h"

@interface RendezvousMessagesViewController : UITableViewController <UISearchDisplayDelegate, UISearchBarDelegate,FBDialogDelegate,FBRequestDelegate>


@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@end


