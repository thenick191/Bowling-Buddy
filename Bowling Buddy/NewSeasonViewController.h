//
//  NewSeasonViewController.h
//  Bowling Buddy
//
//  Created by Nicholas Lucchesi on 5/26/14.
//  Copyright (c) 2014 Nicholas Lucchesi. All rights reserved.
//

#import "ViewController.h"

@interface NewSeasonViewController : ViewController<UITextFieldDelegate>
{
    IBOutlet UITextField* mSeasonNameField;
    IBOutlet UITextField* mGameCountField;
    
    IBOutlet UISwitch* mAdvancedSwitch;
}

- (IBAction)CreatePressed:(id)sender;
- (IBAction)CancelPressed:(id)sender;

@end
