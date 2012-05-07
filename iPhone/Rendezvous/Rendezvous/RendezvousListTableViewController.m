//
//  RendezvousListTableViewController.m
//  Rendezvous
//
//  Created by akonig on 4/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#define kLatestKivaLoansURL @"http://rendezvous.cs147.org/getList.php?id="
#define deleteListURL @"http://rendezvous.cs147.org/deleteList.php?from_id="
#define updatePositionURL @"http://rendezvous.cs147.org/updatePosition.php?from_id="



#import "RendezvousListTableViewController.h"


@interface RendezvousListTableViewController ()

@end

@implementation RendezvousListTableViewController

@synthesize responseData,listIDs,listUserInfo,addButton;

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
    checkLoad = 0;
    
    self.navigationItem.leftBarButtonItem=self.editButtonItem;
    
    //addButton=self.navigationItem.rightBarButtonItem;
    //addButton= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNew)];
     //self.navigationItem.rightBarButtonItem=addButton;
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

#pragma mark - Add New
/*
-(void) addNew
 {
 NSLog(@"Add");  
 }


 -(void) setEditing:(BOOL)editing animated:(BOOL)animated
 {
 
 [super setEditing:editing animated:animated];
 if(editing)
 {
 self.navigationItem.rightBarButtonItem=nil;
 }else {
 self.navigationItem.rightBarButtonItem=addButton;
 }
 
 }
 */
 
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
    checkLoad = 1;
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
    
    if (checkLoad == 1) {
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
        
        RendezvousCurrentUser *sharedSingelton=[RendezvousCurrentUser sharedInstance];
        NSString *deleteString1 = [deleteListURL stringByAppendingString:([sharedSingelton userId])];
        NSString *deleteString2 = [deleteString1 stringByAppendingString:(@"&to_id=")];
        NSString *deleteString3 = [deleteString2 stringByAppendingString:([listIDs objectAtIndex:indexPath.row])];
        
        NSURLRequest *request = [NSURLRequest requestWithURL:([NSURL URLWithString:deleteString3])];
        [[NSURLConnection alloc] initWithRequest:request delegate:self];
        
        NSLog(deleteString3);
        [listIDs removeObjectAtIndex:indexPath.row];
        
        //[listUserInfo removeObjectForKey:[listIDs objectAtIndex:indexPath.row]];
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    NSLog(@"Arrange Override");
    RendezvousCurrentUser *sharedSingelton=[RendezvousCurrentUser sharedInstance];
    
    NSLog([NSString stringWithFormat:@"%d", fromIndexPath.row]);
    NSLog([NSString stringWithFormat:@"%d", toIndexPath.row]);
    
    NSString *temp1 = [listIDs objectAtIndex:fromIndexPath.row];
    [listIDs removeObjectAtIndex:fromIndexPath.row];
    [listIDs insertObject:temp1 atIndex:toIndexPath.row];
    
    int position = 1;
    for (NSString *item in listIDs) {
        NSString *updateString1 = [updatePositionURL stringByAppendingString:([sharedSingelton userId])];
        NSString *updateString2 = [updateString1 stringByAppendingString:(@"&to_id=")];
        NSString *updateString3 = [updateString2 stringByAppendingString: item];
        NSString *updateString4 = [updateString3 stringByAppendingString:(@"&position=")];
        NSString *pos = [NSString stringWithFormat:@"%d", position];
        NSString *updateString5 = [updateString4 stringByAppendingString: pos];
        NSLog(updateString5);
        NSURLRequest *request = [NSURLRequest requestWithURL:([NSURL URLWithString:updateString5])];
        [[NSURLConnection alloc] initWithRequest:request delegate:self];
        position++;
    }
    
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
        checkLoad = 0;
    }
}



@end