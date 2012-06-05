//
//  RendezvousAddTableViewController.m
//  Rendezvous
//
//  Created by akonig on 5/5/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RendezvousAddTableViewController.h"
#define kaddUserURL @"http://www.rendezvousnow.me/addList.php?"


@interface RendezvousAddTableViewController ()

@end

@implementation RendezvousAddTableViewController

@synthesize responseData,listIDs,listUserInfo,filteredListContent,searchBar,saveButton, transName, transID;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    UINavigationBar *NavBar = [[self navigationController] navigationBar];
    UIImage *back = [UIImage imageNamed:@"BarFinal.png"];
    [NavBar setBackgroundImage:back forBarMetrics:UIBarMetricsDefault];
    [super viewDidLoad];
    error = 0;
    
    self.searchBar.backgroundColor =  [UIColor clearColor];
    self.searchDisplayController.searchBar.backgroundImage = [UIImage imageNamed:@"BarFinal.png"];
    self.searchDisplayController.searchResultsTableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.rowHeight = 30;
    RendezvousCurrentUser *sharedSingleton=[RendezvousCurrentUser sharedInstance];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"backStripe.png"]];
    friendsList=[[sharedSingleton userInfo] objectForKey:@"friends"];
    friendsList=[friendsList sortedArrayUsingComparator:^(id a, id b) {
        NSString *first = [(NSDictionary*)a objectForKey:@"name"];
        NSString *second = [(NSDictionary*)b objectForKey:@"name"];
        return [first compare:second options:NSCaseInsensitiveSearch];
    }];
    
    self.filteredListContent = [NSMutableArray arrayWithCapacity:[friendsList count]];
    
    [self.tableView reloadData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"stripeBack.png"]];
    
    
    //    UIButton *addBackButton =  [UIButton buttonWithType:UIButtonTypeCustom];
    //    [addBackButton setImage:[UIImage imageNamed:@"clock.png"] forState:UIControlStateNormal];
    //    [addBackButton addTarget:self action:@selector(addBack) forControlEvents:UIControlEventTouchUpInside];
    //    [addBackButton setFrame:CGRectMake(10, 10, 60, 60)];
    //    [addBackButton setCenter:CGPointMake(self.view.frame.size.width - 13, 200)];
    //    self.navigationController.load
}

-(void) addBack {
    [self performSegueWithIdentifier:@"addBack" sender: self];
}

- (void)viewDidUnload
{
    [self setSearchBar:nil];
    [self setSaveButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark Need to fix for bad content!!!

- (void) searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    NSLog(searchBar.text);
    RendezvousAppDelegate *delegate = (RendezvousAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *path=[NSString stringWithFormat:@"search?q=%@&type=user&limit=10",[searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"]];
    [[delegate facebook] requestWithGraphPath:path andDelegate:self];
    
    
    
}

/*
 - (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
 RendezvousAppDelegate *delegate = (RendezvousAppDelegate *)[[UIApplication sharedApplication] delegate];
 NSString *path=[NSString stringWithFormat:@"search?q=%@&type=user&limit=50",[searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@"%20"]];
 
 [[delegate facebook] requestWithGraphPath:path andDelegate:self];
 }
 */


#pragma mark - Backend Data Loading

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	self.responseData = nil;
}

-(void)errorMethod {
    if (error == 1) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"I'm sure you're really attractive..."
                              message: @"...but unfortunately lists are limited to 10 people."
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
    if (error == 2) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"We know you're really interested in this person..."
                              message: @"...but adding them twice won't increase your chances."
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
    
    NSLog(@"Seguing Back To List");
    [self performSegueWithIdentifier:@"mover" sender: self];
}

#pragma mark Process loan data
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"Seguing Back To List");
    RendezvousCurrentUser *sharedSingleton = [RendezvousCurrentUser sharedInstance];
    [[sharedSingleton listIDs] addObject:transID];
    [[sharedSingleton listUserInfo] setObject:transName forKey:transID];
    [self performSegueWithIdentifier:@"mover" sender: self];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"mover"]) 
    {
    }
}

#pragma mark - Table view data source

/*
 - (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
 {
 NSMutableArray *tempArray = [[NSMutableArray alloc] init];
 [tempArray addObject:@"A"];
 [tempArray addObject:@"B"];
 [tempArray addObject:@"C"];
 [tempArray addObject:@"D"];
 [tempArray addObject:@"E"];
 [tempArray addObject:@"F"];
 [tempArray addObject:@"G"];
 [tempArray addObject:@"H"];
 [tempArray addObject:@"I"];
 [tempArray addObject:@"J"];
 [tempArray addObject:@"K"];
 [tempArray addObject:@"L"];
 [tempArray addObject:@"M"];
 [tempArray addObject:@"N"];
 [tempArray addObject:@"O"];
 [tempArray addObject:@"P"];
 [tempArray addObject:@"Q"];
 [tempArray addObject:@"R"];
 [tempArray addObject:@"S"];
 [tempArray addObject:@"T"];
 [tempArray addObject:@"U"];
 [tempArray addObject:@"V"];
 [tempArray addObject:@"W"];
 [tempArray addObject:@"X"];
 [tempArray addObject:@"Y"];
 [tempArray addObject:@"Z"];
 
 return tempArray;
 }
 
 
 - (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
 return [indices indexOfObject:title];
 }
 
 
 - (NSString *)tableView:(UITableView *)aTableView titleForHeaderInSection:(NSInteger)section {
 return [[content objectAtIndex:section] objectForKey:@"headerTitle"];
 
 }
 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
//self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        return [self.filteredListContent count];
    }
	else
	{
        return [self.filteredListContent count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"AddCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
//        UIImage *background = [UIImage imageNamed:@"cellBackgroundUpdatedDark.png"];
//        cell.backgroundView = [[UIImageView alloc] initWithImage:background];
        [[cell textLabel] setTextColor:[UIColor colorWithRed:209.0/255.0 green:209.0/255.0 blue:209.0/255.0 alpha:1.0]];
        [[cell textLabel] setBackgroundColor:[UIColor clearColor]];
        // Get the cell label using its tag and set it.
        cell.textLabel.text=[[filteredListContent objectAtIndex:indexPath.row] objectForKey:@"name"];
        // The object's image
        cell.imageView.image = [self imageForObject:[[filteredListContent objectAtIndex:indexPath.row] objectForKey:@"id"]];
        
    }
	else
	{
        // Get the cell label using its tag and set it
        //UILabel *cellLabel = (UILabel *)[cell viewWithTag:1];
        [cell.textLabel setText:[[friendsList objectAtIndex:indexPath.row] objectForKey:@"name"]];
        // The object's image
        cell.imageView.image = [self imageForObject:[[friendsList objectAtIndex:indexPath.row] objectForKey:@"id"]];
    }
    
//    UIImage *background = [UIImage imageNamed:@"cellBackground.png"];
//    UIImage *backgroundSelected = [UIImage imageNamed:@"cellBackgroundSelected.png"];
//    cell.backgroundView = [[UIImageView alloc] initWithImage:background];
//    cell.selectedBackgroundView = [[UIImageView alloc] initWithImage:backgroundSelected];
    
    //UILabel *cellLabel = (UILabel *)[cell viewWithTag:1];
    //[cellLabel setText:@"Testing Text"];
    
    
    
    return cell;
    
}

- (UIImage *)imageForObject:(NSString *)objectID {
    // Get the object image
    NSString *url = [[NSString alloc] initWithFormat:@"https://graph.facebook.com/%@/picture",objectID];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
    return image;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
    RendezvousCurrentUser *sharedSingleton = [RendezvousCurrentUser sharedInstance];
    NSString *addRequest=[NSString alloc];
    
    if ([[sharedSingleton listIDs] count] != 10) {
        
        if (tableView == self.searchDisplayController.searchResultsTableView)
        {
            NSLog(@"ONE - FILTERED");
            addRequest=[kaddUserURL stringByAppendingFormat:@"from_id=%@&to_id=%@",[sharedSingleton userId],[[filteredListContent objectAtIndex:indexPath.row] objectForKey:@"id"]];
            NSLog(addRequest);
            
            for (int i=0; i<[[sharedSingleton listIDs] count]; i++) {
                if ([[[filteredListContent objectAtIndex:indexPath.row] objectForKey:@"id"] isEqualToString:[[sharedSingleton listIDs] objectAtIndex:i]]) {
                    error = 2;
                }
            }
            if (error != 2) {
                transID = [[filteredListContent objectAtIndex:indexPath.row] objectForKey:@"id"];
                transName = [[filteredListContent objectAtIndex:indexPath.row] objectForKey:@"name"];
            }
        }
        else
        {
            NSLog(@"TWO - NON FILTERED");
            addRequest=[kaddUserURL stringByAppendingFormat:@"from_id=%@&to_id=%@",[sharedSingleton userId],[[friendsList objectAtIndex:indexPath.row] objectForKey:@"id"]];
            NSLog(addRequest);
            
            for (int i=0; i<[[sharedSingleton listIDs] count]; i++) {
                if ([[[friendsList objectAtIndex:indexPath.row] objectForKey:@"id"] isEqualToString:[[sharedSingleton listIDs] objectAtIndex:i]]) {
                    error = 2;
                }
            }
            if (error != 2) {
                transID = [[friendsList objectAtIndex:indexPath.row] objectForKey:@"id"];
                transName = [[friendsList objectAtIndex:indexPath.row] objectForKey:@"name"];
            }
        }
        NSLog(@"THREE");
        
        if (error != 2) {
            NSURLRequest *request = [NSURLRequest requestWithURL:([NSURL URLWithString:addRequest])];
            [[NSURLConnection alloc] initWithRequest:request delegate:self];
        } else {
            [self errorMethod];
        }
    } else {
        error = 1;
        [self errorMethod];
    }
}


#pragma mark -
#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	/*
	 Update the filtered array based on the search text and scope.
	 */
	
	[self.filteredListContent removeAllObjects]; // First clear the filtered array.
	
	/*
	 Search the main list for products whose type matches the scope (if selected) and whose name matches searchText; add items that match to the filtered array.
	 */
    
	for (NSDictionary *friend in friendsList)
	{
        NSComparisonResult result = [[friend objectForKey:@"name"] compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
        if (result == NSOrderedSame)
        {
            [self.filteredListContent addObject:friend];
        }
	}
}


#pragma mark -
#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text] scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller {
    // Re-style the search controller's table view
    UITableView *tableView = controller.searchResultsTableView;
    tableView.rowHeight=75.0f;
}

#pragma mark - FB callback

- (void)request:(FBRequest *)request didLoad:(id)result
{
    
    NSLog(@"Facebook request %@ loaded", [request url]);
    
    NSArray *resultData = [result objectForKey:@"data"];
    //NSDictionary* user = [resultData objectAtIndex:1];
    for (NSDictionary *user in resultData){
        [self.filteredListContent addObject:user];
    }
    
    NSLog(@"Loaded Search Results");
    [self.searchDisplayController.searchResultsTableView reloadData];
    
    
}


@end
