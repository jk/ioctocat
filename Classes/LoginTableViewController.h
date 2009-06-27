//
//  LoginTableViewController.h
//  iOctocat
//
//  Created by Jens Kohl on 27.06.09.
//  Copyright 2009 Jens Kohl. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LoginTableViewController : UITableViewController <UITextFieldDelegate> {
	id target;
	SEL selector;
	NSUserDefaults *defaults;
	NSString *username;
	NSString *token;
}

@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSString *token;

- (id)initWithTarget:(id)theTarget andSelector:(SEL)theSelector;
- (IBAction)submit:(id)sender;
- (void)failWithMessage:(NSString *)theMessage;
@end
