//
//  NewSeasonViewController.m
//  Bowling Buddy
//
//  Created by Nicholas Lucchesi on 5/26/14.
//  Copyright (c) 2014 Nicholas Lucchesi. All rights reserved.
//

#import "NewSeasonViewController.h"
#import "Season.h"
#import "UserAccount.h"
#import "AppDelegate.h"
#import "MainMenuViewController.h"

@interface NewSeasonViewController ()

@end

@implementation NewSeasonViewController

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

- (IBAction)CreatePressed:(id)sender
{
    Season* season = [[Season alloc] init];
    season.seasonName = mSeasonNameField.text;
    [[UserAccount getUserAccount].seasons addObject:season];
    [[UserAccount getUserAccount] save];
    
    
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
//    NSArray* vcs = delegate.window.subviews;
//    UIViewController* vc = [delegate.window.subviews firstObject];
    MainMenuViewController* mmvc = (MainMenuViewController*)[self presentingViewController];
    [mmvc.tableView reloadData];
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)CancelPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [mSeasonNameField resignFirstResponder];
    [mGameCountField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
