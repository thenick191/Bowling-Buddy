//
//  Game.h
//  Bowling Buddy
//
//  Created by Nicholas Lucchesi on 5/23/14.
//  Copyright (c) 2014 Nicholas Lucchesi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Game : NSObject
{
    int mScore;
    int mStrikes;
    int mSpares;
    int mOpens;
    NSDate* mDate;
}

@property (nonatomic, assign) int score, strikes, spares, opens;
@property (nonatomic, copy) NSDate* date;

@end
