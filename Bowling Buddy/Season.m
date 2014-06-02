//
//  Season.m
//  Bowling Buddy
//
//  Created by Nicholas Lucchesi on 5/24/14.
//  Copyright (c) 2014 Nicholas Lucchesi. All rights reserved.
//

#import "Season.h"
#import "Session.h"
#import "Game.h"

@implementation Season
@synthesize advancedStatisticsEnabled = mAdvancedStatisticsEnabled;
@synthesize seasonName = mSeasonName;

- (id)initWithName:(NSString*)name
{
    if (self = [super init])
    {
        mSessions = [[NSMutableArray alloc] init];
        mSeasonName = [name copy];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"dd-MM-yyyy"];
        
        NSString* data = [NSString stringWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.txt", [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"], name] encoding:NSUTF8StringEncoding error:nil];
        
        NSArray* lines = [data componentsSeparatedByString:@"\n"];
        for (NSString* line in lines)
        {
            if ([line isEqualToString:@""])
                continue;
            Session* session = [[Session alloc] init];
            [mSessions addObject:session];
            NSArray* games = [line componentsSeparatedByString:@","];
            NSString* dateString = games.firstObject;
            session.date = [dateFormatter dateFromString:dateString];
            for (NSString* game in games)
            {
                if (game == games.firstObject)
                    continue;   // First object is the date object
                NSArray* parts = [game componentsSeparatedByString:@";"];
                int score = [parts[0] intValue];
                if (score == -1)    // -1 indicates a missed game
                    continue;
                int strikes = -1, spares = -1, opens = -1;
                if (parts.count > 1)
                {
                    strikes = [parts[1] intValue];
                    spares = [parts[2] intValue];
                    opens = [parts[3] intValue];
                }
                Game* game = [[Game alloc] init];
//                NSDate* date = [dateFormatter dateFromString:dateString];
//                NSLog(@"%@", date);
//                game.date = dateString;
                game.score = score;
                game.strikes = strikes;
                game.spares = spares;
                game.opens = opens;
                
                [session addGame:game];
            }
        }
//        [dateFormatter release];
    }
    return self;
}

- (id)init
{
    if (self = [super init])
    {
        mSessions = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)saveSeason
{
    NSMutableString* string = [NSMutableString string];

    if (mSessions.count)
    {
        for (int i = 0; i < mSessions.count - 1; i++)
        {
            [string appendString:[(Session*)mSessions[i] stringFromSession]];
            [string appendString:@"\n"];
        }
        [string appendString:[(Session*)mSessions[mSessions.count-1] stringFromSession]];
    }
    
    NSString* filePath = [NSString stringWithFormat:@"%@/%@.txt", [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"], mSeasonName];
    
    [string writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (void)addSession:(Session*)session
{
    [mSessions addObject:session];
}

- (NSMutableArray*)getSessions
{
    return mSessions;
}

- (int)getHighGame
{
    int highGame = [((Session*)mSessions[0]) getHighGame];
    for (int i = 1; i < mSessions.count; i++)
        if ([((Session*)mSessions[1]) getHighGame] > highGame)
            highGame = [((Session*)mSessions[i]) getHighGame];
    return highGame;
}

- (int)getHighSeries
{
    int series = [((Session*)mSessions[0]) getSeries];
    for (int i = 1; i < mSessions.count; i++)
        if ([((Session*)mSessions[1]) getSeries] > series)
            series = [((Session*)mSessions[i]) getSeries];
    return series;
}

- (int)getTotalPins
{
    int pins = 0;
    for (Session* session in mSessions)
        pins += [session getSeries];
    return pins;
}

- (int)getNumberOfGames
{
    int games = 0;
    for (Session* session in mSessions)
        games += [session getGames].count;
    return games;
}

- (float)getAverage
{
    float totalPins = [self getTotalPins];
    float numberOfGames = [self getNumberOfGames];
    return totalPins/numberOfGames;
}

- (int)getNumberOfStrikes
{
    int strikes = 0;
    for (Session* session in mSessions)
        strikes += [session getNumberOfStrikes];
    return strikes;
}

- (int)getNumberOfSpares
{
    int spares = 0;
    for (Session* session in mSessions)
        spares += [session getNumberOfSpares];
    return spares;
}

- (int)getNumberOfOpens
{
    int opens = 0;
    for (Session* session in mSessions)
        opens += [session getNumberOfOpens];
    return opens;
}

- (float)getAverageStrikesPerGame
{
    float numberOfGames = [self getNumberOfGames];
    float numberOfStrikes = [self getNumberOfStrikes];
    return numberOfStrikes/numberOfGames;
}

- (float)getAverageSparesPerGame
{
    float numberOfGames = [self getNumberOfGames];
    float numberOfSpares = [self getNumberOfSpares];
    return numberOfSpares/numberOfGames;
}

- (float)getAverageOpensPerGame
{
    float numberOfGames = [self getNumberOfGames];
    float numberOfOpens = [self getNumberOfOpens];
    return numberOfOpens/numberOfGames;
}

// TODO work out this algorithm better
- (float)getAveragePinsOverAverage
{
    float currentPins = 0;
    int currentGames = 0;
    for (int i = 0; i < mSessions.count; i++)
    {
        Session* session = mSessions[i];
        float currentAverage = currentPins / currentGames;
        currentPins += [session getSeries];
        
    }
    return currentPins;
}

@end
