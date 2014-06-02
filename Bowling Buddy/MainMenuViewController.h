//
//  MainMenuViewController.h
//  Bowling Buddy
//
//  Created by Nicholas Lucchesi on 5/24/14.
//  Copyright (c) 2014 Nicholas Lucchesi. All rights reserved.
//

#import "ViewController.h"
#import <iAd/iAd.h>

@interface MainMenuViewController : ViewController<UITableViewDataSource, UITableViewDelegate, ADBannerViewDelegate>
{
    IBOutlet UITableView* mTableView;
    IBOutlet ADBannerView* mBannerView;
}
@property (nonatomic, retain) UITableView* tableView;

- (IBAction)ChooseSeason:(id)sender;

@end
