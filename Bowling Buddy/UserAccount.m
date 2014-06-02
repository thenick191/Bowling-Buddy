//
//  UserAccount.m
//  Bowling Buddy
//
//  Created by Nicholas Lucchesi on 5/24/14.
//  Copyright (c) 2014 Nicholas Lucchesi. All rights reserved.
//

#import "UserAccount.h"
#import "Season.h"

@implementation UserAccount
@synthesize seasons = mSeasons;
@synthesize selectedSeason = mSelectedSeason;
@synthesize selectedSession = mSelectedSession;
static UserAccount* userAccount;

+ (UserAccount*)getUserAccount
{
    if (!userAccount)
        userAccount = [[UserAccount alloc] init];
    return userAccount;
}

- (id)init
{
    if (self = [super init])
    {
        mUsername = [[NSUserDefaults standardUserDefaults] stringForKey:@"username"];
        if (!mUsername)
        {
            mUsername = @"default";
            [[NSUserDefaults standardUserDefaults] setValue:mUsername forKey:@"username"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        mSeasons = [[NSMutableArray alloc] init];
        
        NSString* seasonsFileData = [NSString stringWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.txt", [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"], mUsername] encoding:NSUTF8StringEncoding error:nil];
        
        if (seasonsFileData != nil)
        {
            NSArray* seasonNames = [seasonsFileData componentsSeparatedByString:@"\n"];
            for (NSString* seasonName in seasonNames)
            {
//                NSString* fileData = [NSString stringWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.txt", [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"], seasonName] encoding:NSUTF8StringEncoding error:nil];
                Season* season = [[Season alloc] initWithName:seasonName];
                [mSeasons addObject:season];
            }
        }
        
    }
    return self;
}

- (void)save
{
    NSMutableString* seasonNamesFileData = [NSMutableString string];
    
    for (Season* season in mSeasons)
    {
        [seasonNamesFileData appendFormat:@"%@", season.seasonName];
        
        [season saveSeason];
        
        if ([season isEqual:mSeasons.lastObject] == NO)
        {
            [seasonNamesFileData appendString:@"\n"];
        }
    }
    
    [seasonNamesFileData writeToFile:[NSString stringWithFormat:@"%@/%@.txt", [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"], mUsername] atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

@end
