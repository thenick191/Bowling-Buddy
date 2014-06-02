//
//  NewSessionViewController.m
//  Bowling Buddy
//
//  Created by Nicholas Lucchesi on 5/24/14.
//  Copyright (c) 2014 Nicholas Lucchesi. All rights reserved.
//

#import "NewSessionViewController.h"
#import "Game.h"
#import "UserAccount.h"
#import "Session.h"
#import "Season.h"
#import "SeasonViewController.h"

@interface NewSessionViewController ()

@end

@implementation NewSessionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    mGames = [[NSMutableArray alloc] init];
    mSeasonLabel.text = ((Season*)[UserAccount getUserAccount].selectedSeason).seasonName;
    
    if ([UserAccount getUserAccount].selectedSession)
    {
        mSession = [UserAccount getUserAccount].selectedSession;
        mDatePicker.date = mSession.date;
        [mGames addObjectsFromArray:[mSession getGames]];
    }
    
    [mScoreTable reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)AddScore:(id)sender
{
    int score = [mScoreField.text intValue];
    Game* game = [[Game alloc] init];
    game.score = score;
    [mGames addObject:game];
    
    mScoreField.text = @"";
    [mScoreField resignFirstResponder];
    [mScoreTable reloadData];
}

- (IBAction)RemoveScore:(id)sender
{
    int selectedIndex = mScoreTable.indexPathForSelectedRow.row;
    if (selectedIndex >= 0)
    {
        if (mGames.count >= selectedIndex + 1)
        {
            Game* game = [mGames objectAtIndex:selectedIndex];
            [mGames removeObjectAtIndex:selectedIndex];
            [game release];
            
            mScoreField.text = @"";
            [mScoreTable reloadData];
        }
    }
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return mGames.count;
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
    
    cell.textLabel.text = [NSString stringWithFormat:@"Score: %i", ((Game*)mGames[indexPath.row]).score];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    mScoreField.text = [NSString stringWithFormat:@"%i", ((Game*)mGames[indexPath.row]).score];
}

- (IBAction)BackPressed:(id)sender
{
    [[mSession getGames] removeAllObjects];
    for (Game* game in mGames)
    {
        [[UserAccount getUserAccount].selectedSession addGame:game];
    }
    mSession.date = mDatePicker.date;
    [[UserAccount getUserAccount] save];
    [((SeasonViewController*)[self presentingViewController]) reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
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
