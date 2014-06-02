//
//  Session.m
//  Bowling Buddy
//
//  Created by Nicholas Lucchesi on 5/24/14.
//  Copyright (c) 2014 Nicholas Lucchesi. All rights reserved.
//

#import "Session.h"
#import "Game.h"

@implementation Session

@synthesize numberOfGames = mNumberOfGames;
@synthesize date = mDate;

- (id)initWithName:(NSString*)name
{
    if (self = [super init])
    {
        mGames = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)init
{
    if (self = [super init])
    {
        mGames = [[NSMutableArray alloc] init];
    }
    return self;
}

//- (void)setDate:(NSDate *)date
//{
//    [mDate release];
//    
//    self.date = date;
//}

- (void)addGame:(Game *)game
{
    [mGames addObject:game];
}

- (NSMutableArray*)getGames
{
    return mGames;
}

- (int)getHighGame
{
    int highScore = ((Game*)mGames[0]).score;
    for (int i = 1; i < mGames.count; i++)
        if (((Game*)mGames[i]).score > highScore)
            highScore = ((Game*)mGames[i]).score;
    
    return highScore;
}

- (int)getSeries
{
    int series = 0;
    for (Game* game in mGames)
        series += game.score;
    return  series;
}

- (float)getAverage
{
    int series = [self getSeries];
    float average = (float)series/mGames.count;
    return average;
}

- (int)getNumberOfStrikes
{
    int strikes = 0;
    for (Game* game in mGames)
        strikes += game.strikes;
    return strikes;
}

- (int)getNumberOfSpares
{
    int spares = 0;
    for (Game* game in mGames)
        spares += game.spares;
    return spares;
}

- (int)getNumberOfOpens
{
    int opens = 0;
    for (Game* game in mGames)
        opens += game.opens;
    return opens;
}

- (NSString*)stringFromSession
{
    NSMutableString* string = [NSMutableString string];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    [string appendFormat:@"%@,", [dateFormatter stringFromDate:mDate]];
    [dateFormatter release];
    for (Game* game in mGames)
    {
        [string appendFormat:@"%i", game.score];
        if (game != mGames.lastObject)
            [string appendString:@","];
    }
    
    return string;
}

- (NSString*)gamesString
{
    NSMutableString* string = [NSMutableString string];
    if (mGames.count == 0)
        [string appendString:@"No games..."];
    for (Game* game in mGames)
    {
        [string appendFormat:@"%i", game.score];
        if (game != mGames.lastObject)
            [string appendString:@", "];
    }
    
    return string;
}

@end
