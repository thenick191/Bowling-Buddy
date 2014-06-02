//
//  SeasonViewController.h
//  Bowling Buddy
//
//  Created by Nicholas Lucchesi on 5/24/14.
//  Copyright (c) 2014 Nicholas Lucchesi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Season;

@interface SeasonViewController : UIViewController
{
    IBOutlet UILabel* mNumberOfGamesLabel;
    IBOutlet UILabel* mSeasonNameLabel;
    IBOutlet UILabel* mAverageLabel;
    IBOutlet UILabel* mHighGameLabel;
    IBOutlet UILabel* mHighSeriesLabel;
    IBOutlet UILabel* mTotalPinsLabel;
    
    IBOutlet UITableView* mSessionsTable;
    
    NSDateFormatter* mDateFormatter;
    
    Season* mSeason;
}

@property (nonatomic, assign) Season* season;
@property (nonatomic, retain) UITableView* sessionsTable;

- (IBAction)EditSession:(id)sender;
- (IBAction)NewSession:(id)sender;
- (IBAction)BackPressed:(id)sender;
- (void)reloadData;

@end
