//
//  RendezvousAddTableViewController.h
//  Rendezvous
//
//  Created by akonig on 5/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RendezvousCurrentUser.h"

@interface RendezvousAddTableViewController : UITableViewController <UISearchDisplayDelegate, UISearchBarDelegate,FBDialogDelegate,FBRequestDelegate>
{
    NSMutableDictionary *listUserInfo;
    NSMutableArray *listIDs;
    NSMutableData *responseData;
    NSArray *friendsList;
    NSMutableArray	*filteredListContent;
    UIBarButtonItem *addButton;
    NSMutableString *transID;
    NSMutableString *transName;
    int error;
}

@property ( nonatomic) NSMutableString* transID;
@property ( nonatomic) NSMutableString* transName;
@property ( nonatomic) NSMutableData* responseData;
@property ( nonatomic) NSMutableArray* listIDs;
@property ( nonatomic) NSMutableDictionary* listUserInfo;
@property (nonatomic) NSMutableArray *filteredListContent;
@property ( nonatomic) IBOutlet UISearchBar *searchBar;
@property ( nonatomic) IBOutlet UIBarButtonItem *saveButton;


@end
