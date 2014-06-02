//
//  NewSessionViewController.h
//  Bowling Buddy
//
//  Created by Nicholas Lucchesi on 5/24/14.
//  Copyright (c) 2014 Nicholas Lucchesi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Session;
@interface NewSessionViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    IBOutlet UIDatePicker* mDatePicker;
    IBOutlet UITextField* mScoreField;
    IBOutlet UITableView* mScoreTable;
    IBOutlet UILabel* mSeasonLabel;
    
    NSMutableArray* mGames;
    
    Session* mSession;
}

- (IBAction)AddScore:(id)sender;
- (IBAction)RemoveScore:(id)sender;

- (IBAction)BackPressed:(id)sender;

@end
