//
//  PlayingCard.h
//  Matchismo
//
//  Created by Elliott Wood on 7/14/14.
//  Copyright (c) 2014 Elliott Wood. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger) maxRank;

@end
