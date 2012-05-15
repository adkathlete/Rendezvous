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
}

@property (retain, nonatomic) NSMutableString* transID;
@property (retain, nonatomic) NSMutableString* transName;
@property (retain, nonatomic) NSMutableData* responseData;
@property (retain, nonatomic) NSMutableArray* listIDs;
@property (retain, nonatomic) NSMutableDictionary* listUserInfo;
@property (nonatomic, retain) NSMutableArray *filteredListContent;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;


@end
