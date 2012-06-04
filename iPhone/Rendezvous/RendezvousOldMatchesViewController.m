//
//  RendezvousOldMatchesViewController.m
//  Rendezvous
//
//  Created by akonig on 5/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RendezvousOldMatchesViewController.h"

#define deleteListURL @"http://rendezvousnow.me/deleteList.php?from_id="
#define updatePositionURL @"http://rendezvousnow.me/updatePosition.php?from_id="


@interface RendezvousOldMatchesViewController ()

@end

@implementation RendezvousOldMatchesViewController

@synthesize responseData;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0xB6/255.0f
                                                                        green:0xED/255.0f
                                                                         blue:0xFD/255.0f alpha:1]; 
    NSLog(@"BRYCE");
    
    sharedSingleton = [RendezvousCurrentUser sharedInstance];
    [super viewDidLoad];
    
    //addButton=self.navigationItem.rightBarButtonItem;
    //addButton= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNew)];
    //self.navigationItem.rightBarButtonItem=addButton;
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getListNamesFromID) name:@"listDataLoaded" object:nil];
    //[self loadData];
    
    
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
    RendezvousCurrentUser *s = [RendezvousCurrentUser sharedInstance];
    NSLog(@"COUNT");
    NSLog(@"%d",[[s matchIDs] count]);
    return [[s matchIDs] count];;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RendezvousCurrentUser *s = [RendezvousCurrentUser sharedInstance];
    
    static NSString *CellIdentifier = @"matchCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Get the cell label using its tag and set it
    //UILabel *cellLabel = (UILabel *)[cell viewWithTag:1];
    NSString *listNumer=[[NSString alloc] initWithFormat:@"%d. ",indexPath.row+1];
    NSString *labelText= [listNumer stringByAppendingString:[[s matchInfo] objectForKey:[[s matchIDs] objectAtIndex:indexPath.row]]];
    [cell.textLabel setText:labelText];
    
    // The object's image
    cell.imageView.image = [self imageForObject:[[s matchIDs] objectAtIndex:indexPath.row]];
    
    return cell;
}

#pragma mark - Backend Data Loading

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
    NSLog(@"LIST");
    sharedSingleton.visitingId = [[sharedSingleton matchIDs] objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"oldMatchToDetailPage" sender: self];
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"loadingUserPage" object:nil];
    
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}


@end