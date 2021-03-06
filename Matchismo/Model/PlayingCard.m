//
//  PlayingCard.m
//  Matchismo
//
//  Created by Elliott Wood on 7/14/14.
//  Copyright (c) 2014 Elliott Wood. All rights reserved.
//

#import "PlayingCard.h"
#import <UIKit/UIKit.h>


@implementation PlayingCard

- (int)match:(NSArray *)cards {
    int cardCount = [cards count] + 1;
    
    NSMutableSet *ranks = [[NSMutableSet alloc] init];
    NSMutableSet *suits = [[NSMutableSet alloc] init];
    
    [ranks addObject:[NSString stringWithFormat:@"%d", self.rank]];
    [suits addObject:self.suit];
    
    for(PlayingCard *otherCard in cards) {
        [ranks addObject:[NSString stringWithFormat:@"%d", otherCard.rank]];
        [suits addObject:otherCard.suit];
    }

    if ([ranks count] < cardCount) {
        return pow(4, cardCount - [ranks count]);
    }
    
    if ([suits count] < cardCount) {
        return cardCount - [suits count];
    }
    
    return 0;
}

- (NSString *)contents {
    return [[PlayingCard rankStrings][self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit; // because we provide the setter AND getter

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)validSuits
{
    return @[@"♠︎", @"♣︎", @"♥︎", @"♦︎"];
}

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6",
             @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger)maxRank
{
    return [[self rankStrings] count]-1;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

- (UIColor *)color
{
    if ([@[@"♥︎", @"♦︎"] containsObject:self.suit]) {
        return [UIColor redColor];
    } else {
        return [UIColor blackColor];
    }
}

@end
