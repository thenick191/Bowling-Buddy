//
//  Session.h
//  Bowling Buddy
//
//  Created by Nicholas Lucchesi on 5/24/14.
//  Copyright (c) 2014 Nicholas Lucchesi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Game;

@interface Session : NSObject
{
    NSMutableArray* mGames;
    NSDate* mDate;
    int mNumberOfGames;
}

@property (nonatomic, assign) int numberOfGames;
@property (nonatomic, copy) NSDate* date;

- (id)initWithName:(NSString*)name;

- (NSMutableArray*)getGames;
- (void)addGame:(Game*)game;
- (int)getHighGame;
- (int)getSeries;
- (float)getAverage;

- (int)getNumberOfStrikes;
- (int)getNumberOfSpares;
- (int)getNumberOfOpens;

- (NSString*)stringFromSession;
- (NSString*)gamesString;
@end
