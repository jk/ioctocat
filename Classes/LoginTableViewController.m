//
//  LoginTableViewController.m
//  iOctocat
//
//  Created by Jens Kohl on 27.06.09.
//  Copyright 2009 Jens Kohl. All rights reserved.
//

#import "LoginTableViewController.h"

#define MAINLABEL_TAG 1
#define TXTVALUE_TAG 2
#define BUTTON_TAG 3

@implementation LoginTableViewController

@synthesize username;
@synthesize token;



- (id)initWithTarget:(id)theTarget andSelector:(SEL)theSelector {
	[super initWithNibName:@"LoginTableViewController" bundle:nil];
	target = theTarget;
	selector = theSelector;
	return self;
}

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/

- (void)viewDidLoad {
    [super viewDidLoad];
	defaults = [NSUserDefaults standardUserDefaults];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
}


/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	return @"Authentication";
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellKeyId = @"KeyValue";
	static NSString *CellBtnId = @"Button";
    
    UITableViewCell *cell;
	
	if (indexPath.row < 2) {
		cell = [tableView dequeueReusableCellWithIdentifier:CellKeyId];
		
		UILabel *mainLabel;
		UITextField *txtValue;
		
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellKeyId] autorelease];
			
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			
			// Description label
			mainLabel = [[UILabel alloc] initWithFrame:CGRectMake(30.0, 15.0, 100.0, 15.0)];
			mainLabel.tag = MAINLABEL_TAG;
			mainLabel.font = [UIFont boldSystemFontOfSize:14.0];
			mainLabel.text = @"Test";
			mainLabel.textColor = [UIColor blackColor];
			mainLabel.backgroundColor = [UIColor clearColor];
			mainLabel.textAlignment = UITextAlignmentRight;
			mainLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
			[cell.contentView addSubview:mainLabel];
			[mainLabel release];
			
			// TextField
			txtValue = [[UITextField alloc] initWithFrame:CGRectMake(120.0, 10.0, 175.0, 20.0)];
			txtValue.tag = TXTVALUE_TAG;
			txtValue.delegate = self;
			txtValue.placeholder = @"Placeholder";
			txtValue.textColor = [UIColor blackColor];
			txtValue.backgroundColor = [UIColor clearColor];
			txtValue.textAlignment = UITextAlignmentLeft;
			txtValue.borderStyle = UITextBorderStyleNone;
			txtValue.clearButtonMode = UITextFieldViewModeWhileEditing;
			txtValue.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
			[cell.contentView addSubview:txtValue];
			[txtValue release];
		} else {
			mainLabel = (UILabel *)[cell viewWithTag:MAINLABEL_TAG];
			txtValue  = (UITextField *)[cell viewWithTag:TXTVALUE_TAG];
		}
		
		if (indexPath.row == 0) {
			mainLabel.text = @"Username";
			txtValue.placeholder = @"";
			txtValue.text = [defaults valueForKey:kUsernameDefaultsKey];
		} else {
			mainLabel.text = @"API Token";
			txtValue.placeholder = @"";
			txtValue.text = [defaults valueForKey:kTokenDefaultsKey];
		}


	} else {
		cell = [tableView dequeueReusableCellWithIdentifier:CellBtnId];
		
		UILabel *buttonText;
		
		if(cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellBtnId] autorelease];
			
			UIFont *labelFont = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];

			// Description label
			buttonText = [[UILabel alloc] initWithFrame:cell.frame];
			buttonText.tag = BUTTON_TAG;
			buttonText.font = labelFont;
			buttonText.text = @"Search";
			buttonText.textColor = [UIColor blackColor];
			buttonText.backgroundColor = [UIColor clearColor];
			buttonText.textAlignment = UITextAlignmentCenter;
			buttonText.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
			[cell.contentView addSubview:buttonText];
			[buttonText release];
		} else {
			buttonText = (UILabel *)[cell viewWithTag:BUTTON_TAG];
		}

	}

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
	if (indexPath.row == 2)
		[self submit:nil];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/
#pragma mark -
#pragma mark custom methods
- (void)failWithMessage:(NSString *)theMessage {
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Authentication failed" message:theMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}

- (IBAction)submit:(id)sender {
	NSLog(@"username: %@", self.username);
	NSLog(@"Username: %@, Token: %@", self.username, self.token);
	if (![self.username isEqualToString:@""] && ![self.token isEqualToString:@""]) {
		[defaults setValue:self.username forKey:kUsernameDefaultsKey];
		[defaults setValue:self.token forKey:kTokenDefaultsKey];
		[defaults synchronize];
		[target performSelector:selector];
	} else {
		[self failWithMessage:@"Please enter your login\nand API token"];
	}
}

#pragma mark UITextFieldDelegate Methods
- (BOOL)textFieldShouldReturn:(UITextField *)textField {

	UITableViewCell *theCell = (UITableViewCell *)[[textField superview] superview];
	NSIndexPath *cellPath = [self.tableView indexPathForCell:theCell];
	
	switch (cellPath.row) {
		case 0:
			self.username = textField.text;
			break;
		case 1:
			self.token = textField.text;
			break;
		default:
			break;
	}

	[textField resignFirstResponder];
	return YES;
}


- (void)dealloc {
	[defaults release];
	self.username = nil;
	self.token = nil;
    [super dealloc];
}


@end

