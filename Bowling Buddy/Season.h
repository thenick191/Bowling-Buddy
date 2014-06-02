//
//  Season.h
//  Bowling Buddy
//
//  Created by Nicholas Lucchesi on 5/24/14.
//  Copyright (c) 2014 Nicholas Lucchesi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Session;

@interface Season : NSObject
{
    NSMutableArray* mSessions;
    NSString* mSeasonName;
    
    BOOL mAdvancedStatisticsEnabled;
}

@property (nonatomic, assign) BOOL advancedStatisticsEnabled;
@property (nonatomic, copy) NSString* seasonName;

- (id)initWithName:(NSString*)name;
- (void)addSession:(Session*)session;
- (NSMutableArray*)getSessions;
- (int)getHighGame;
- (int)getHighSeries;
- (float)getAverage;
- (int)getTotalPins;
- (int)getNumberOfGames;

- (float)getAverageStrikesPerGame;
- (float)getAverageSparesPerGame;
- (float)getAverageOpensPerGame;
- (float)getAveragePinsOverAverage;

- (void)saveSeason;
@end
