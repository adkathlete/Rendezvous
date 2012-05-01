//
//  RendezvousListTableViewController.m
//  Rendezvous
//
//  Created by akonig on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#define kLatestKivaLoansURL @"http://rendezvous.cs147.org/getList.php?id="


#import "RendezvousListTableViewController.h"


@interface RendezvousListTableViewController ()

@end

@implementation RendezvousListTableViewController
 
@synthesize responseData,listIDs,listUserInfo;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    listUserInfo = [[NSMutableDictionary alloc] init];
    
    self.navigationItem.leftBarButtonItem=self.editButtonItem;
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getListNamesFromID) name:@"listDataLoaded" object:nil];
    [self loadData];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (UIImage *)imageForObject:(NSString *)objectID {
    // Get the object image
    NSString *url = [[NSString alloc] initWithFormat:@"https://graph.facebook.com/%@/picture",objectID];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
    return image;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [listIDs count];;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Get the cell label using its tag and set it
    UILabel *cellLabel = (UILabel *)[cell viewWithTag:1];
    [cellLabel setText:[listUserInfo objectForKey:[listIDs objectAtIndex:indexPath.row]]];
    
    // The object's image
    cell.imageView.image = [self imageForObject:[listIDs objectAtIndex:indexPath.row]];
    
    return cell;
}

#pragma mark - Backend Data Loading

-(void)loadData
{
	self.responseData = [NSMutableData data];
    RendezvousCurrentUser *sharedSingelton=[RendezvousCurrentUser sharedInstance];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[kLatestKivaLoansURL stringByAppendingString:[[sharedSingelton userInfo] objectForKey:@"id"]]]];
    [[NSURLConnection alloc] initWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	self.responseData = nil;
}

#pragma mark Process loan data
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateTableInfo) name:@"listDataLoaded" object:nil];
    
    NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
	self.responseData = nil;
	NSLog(responseString);
    listIDs = [responseString componentsSeparatedByString:@","];
    [self.tableView reloadData];
    
    RendezvousAppDelegate *delegate = (RendezvousAppDelegate *)[[UIApplication sharedApplication] delegate];
    for (NSString *item in listIDs) {
        NSLog(item);
        [[delegate facebook] requestWithGraphPath:item andDelegate:self];
    }
    
    
        
}

-(void) updateTableInfo{
    NSLog(@"Time To Update!");
    [self.tableView reloadData];

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [listIDs removeObjectAtIndex:indexPath.row];
        [listUserInfo removeObjectForKey:[listIDs objectAtIndex:indexPath.row]];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}


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
}

#pragma mark - Facebook Requests

- (void)request:(FBRequest *)request didLoad:(id)result
{
    NSLog(@"Facebook request %@ loaded", [request url]);
    
    [listUserInfo setObject:[result objectForKey:@"name"] forKey:[result objectForKey:@"id"]];
    
    //NSLog(@"%",listUserInfo);
    if(listIDs.count==listUserInfo.count){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"listDataLoaded" object:nil];
    }
}



@end
