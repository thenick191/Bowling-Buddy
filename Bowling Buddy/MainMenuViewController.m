//
//  MainMenuViewController.m
//  Bowling Buddy
//
//  Created by Nicholas Lucchesi on 5/24/14.
//  Copyright (c) 2014 Nicholas Lucchesi. All rights reserved.
//

#import "MainMenuViewController.h"
#import "UserAccount.h"
#import "Season.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController
@synthesize tableView = mTableView;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ChooseSeason:(id)sender
{
    [UserAccount getUserAccount].selectedSeason = [UserAccount getUserAccount].seasons[mTableView.indexPathForSelectedRow.row];
    [self performSegueWithIdentifier:@"choose_season" sender:self];
}


- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [UserAccount getUserAccount].seasons.count;
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
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", ((Season*)[UserAccount getUserAccount].seasons[indexPath.row]).seasonName];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"Games: %i", [((Season*)[UserAccount getUserAccount].seasons[indexPath.row]) getNumberOfGames]];
    
    return cell;
}

- (void)bannerViewDidLoadAd:(ADBannerView *)banner
{
    banner.hidden = NO;
}

- (BOOL)bannerViewActionShouldBegin:(ADBannerView *)banner willLeaveApplication:(BOOL)willLeave
{
    [[UserAccount getUserAccount] save];
    
    return willLeave;
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
