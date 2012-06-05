//
//  RendezvousSearchDisplayController.m
//  Rendezvous
//
//  Created by akonig on 5/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RendezvousSearchDisplayController.h"

@implementation RendezvousSearchDisplayController


//Subclass SearchDisplayController for Custom TableView
-(UITableView *) searchResultsTableView {
[self setValue:[NSNumber numberWithInt:UITableViewStyleGrouped]
        forKey:@"_searchResultsTableViewStyle"];
return [super searchResultsTableView];
}

@end
