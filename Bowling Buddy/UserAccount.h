//
//  UserAccount.h
//  Bowling Buddy
//
//  Created by Nicholas Lucchesi on 5/24/14.
//  Copyright (c) 2014 Nicholas Lucchesi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Season;
@class Session;

@interface UserAccount : NSObject
{
    NSString* mUsername;
    NSMutableArray* mSeasons;
    
    Session* mSelectedSession;
    Season* mSelectedSeason;
}

@property (nonatomic, retain) NSMutableArray* seasons;
@property (nonatomic, assign) Season* selectedSeason;
@property (nonatomic, assign) Session* selectedSession;

+ (UserAccount*)getUserAccount;

- (void)save;

@end
