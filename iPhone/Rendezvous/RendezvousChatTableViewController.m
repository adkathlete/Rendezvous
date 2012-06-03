//
//  RendezvousChatTableViewController.m
//  Rendezvous
//
//  Created by akonig on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RendezvousChatTableViewController.h"
#define FONT_SIZE 16.0f
#define CELL_CONTENT_WIDTH 170.0f
#define CELL_CONTENT_MARGIN 10.0f


@interface RendezvousChatTableViewController ()

@end

@implementation RendezvousChatTableViewController

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
    [super viewDidLoad];
    RendezvousCurrentUser *s = [RendezvousCurrentUser sharedInstance];
    [self setTitle:[[s messageUserInfo] objectForKey:[s visitingMessageId]]];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    RendezvousCurrentUser *s = [RendezvousCurrentUser sharedInstance];
    return [[[s messages] objectForKey:[s visitingMessageId]] count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    RendezvousCurrentUser *s = [RendezvousCurrentUser sharedInstance];
    NSArray *chatMessages=[[s messages] objectForKey:[s visitingMessageId]];
    NSString *text= [[chatMessages objectAtIndex:indexPath.row] objectForKey:@"message"];
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    CGFloat height = MAX(size.height, 44.0f);
    
    return height + (CELL_CONTENT_MARGIN * 2);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RendezvousCurrentUser *s = [RendezvousCurrentUser sharedInstance];
    NSArray *chatMessages=[[s messages] objectForKey:[s visitingMessageId]];
    NSString *mainLabelText= [[chatMessages objectAtIndex:indexPath.row] objectForKey:@"message"];
    
    static NSString *CellIdentifier=nil;
    if([[[chatMessages objectAtIndex:indexPath.row] objectForKey:@"from_id"] isEqualToString:[s userId]])
    {
        CellIdentifier= @"toCellIdentifier";   
    } else {
        CellIdentifier = @"fromCellIdentifier";
    }
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    

    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier];
        
    }
    
    UILabel *label = (UILabel *)[cell viewWithTag:1];
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH, 20000.0f);
    
    CGSize size = [mainLabelText sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    [label setText:mainLabelText];
    
    if([[[chatMessages objectAtIndex:indexPath.row] objectForKey:@"from_id"] isEqualToString:[s userId]])
    {
        label.textAlignment=UITextAlignmentRight;  
        [label setFrame:CGRectMake(320-CELL_CONTENT_MARGIN-CELL_CONTENT_WIDTH,CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH, MAX(size.height, 44.0f))];  
    } else {
        [label setFrame:CGRectMake(CELL_CONTENT_MARGIN, CELL_CONTENT_MARGIN, CELL_CONTENT_WIDTH, MAX(size.height, 44.0f))];
    }

    
    return cell;

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
}

@end
