//
//  SeasonViewController.m
//  Bowling Buddy
//
//  Created by Nicholas Lucchesi on 5/24/14.
//  Copyright (c) 2014 Nicholas Lucchesi. All rights reserved.
//

#import "SeasonViewController.h"
#import "Game.h"
#import "Season.h"
#import "Session.h"
#import "UserAccount.h"

@interface SeasonViewController ()

@end

@implementation SeasonViewController

@synthesize season = mSeason;
@synthesize sessionsTable = mSessionsTable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//- (void)setSeason:(Season *)season
- (void)reloadData
{
    mSeason = [UserAccount getUserAccount].selectedSeason;
    
    // set labels
    mSeasonNameLabel.text = mSeason.seasonName;
    if ([mSeason getNumberOfGames] == 0)
    {
        mNumberOfGamesLabel.text = [NSString stringWithFormat:@"%i games", [mSeason getNumberOfGames]];
        mAverageLabel.text = @"No games bowled...";
        mHighGameLabel.text = @"";
        mHighSeriesLabel.text = @"";
        
        mTotalPinsLabel.text = @"";
    }
    else
    {
        mNumberOfGamesLabel.text = [NSString stringWithFormat:@"%i games", [mSeason getNumberOfGames]];
        mAverageLabel.text = [NSString stringWithFormat:@"Average: %.2f", [mSeason getAverage]];
        mHighGameLabel.text = [NSString stringWithFormat:@"High game: %i", [mSeason getHighGame]];
        mHighSeriesLabel.text = [NSString stringWithFormat:@"High series: %i", [mSeason getHighSeries]];
        
        mTotalPinsLabel.text = [NSString stringWithFormat:@"Total pins: %i", [mSeason getTotalPins]];
    }
    [mSessionsTable reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    mDateFormatter = [[NSDateFormatter alloc] init];
    [mDateFormatter setDateFormat:@"MM-dd-yyyy"];
    [self reloadData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [((Season*)[UserAccount getUserAccount].selectedSeason) getSessions].count > 0 ? [((Season*)[UserAccount getUserAccount].selectedSeason) getSessions].count : 1;
}

- (int)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    if ([((Season*)[UserAccount getUserAccount].selectedSeason) getSessions].count > 0)
    {
        Season* season = [UserAccount getUserAccount].selectedSeason;
        Session* session = [[season getSessions] objectAtIndex:indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@: %@", [mDateFormatter stringFromDate:session.date], [session gamesString]];
    }
    else
    {
        cell.textLabel.text = @"No games bowled...";
    }
    
    return cell;
}

- (IBAction)NewSession:(id)sender
{
    Session* session = [[Session alloc] init];
    session.date = [[NSDate date] retain];
    [[UserAccount getUserAccount].selectedSeason addSession:session];
    [UserAccount getUserAccount].selectedSession = session;
    [self performSegueWithIdentifier:@"edit_session" sender:self];
}

- (IBAction)EditSession:(id)sender
{
    if ([((Season*)[UserAccount getUserAccount].selectedSeason) getSessions].count == 0)
    {
        return;
    }
    [UserAccount getUserAccount].selectedSession = [[((Season*)[UserAccount getUserAccount].selectedSeason) getSessions] objectAtIndex:mSessionsTable.indexPathForSelectedRow.row];
    [self performSegueWithIdentifier:@"edit_session" sender:self];
}

- (IBAction)BackPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc
{
    [mDateFormatter release];
    [super dealloc];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
