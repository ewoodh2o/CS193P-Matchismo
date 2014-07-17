//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Elliott Wood on 7/17/14.
//  Copyright (c) 2014 Elliott Wood. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()

@property (nonatomic, readwrite) NSInteger score;
@property (strong, nonatomic) NSMutableArray *cards;  // of Card
@property (nonatomic, readwrite) NSInteger matchMode;

@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                    withMatchMode:(NSUInteger)matchMode
                        usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        if (matchMode >= 2) {
            self.matchMode = matchMode;
        } else {
            self = nil;
            return self;
        }

        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int PEEK_COST = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    NSMutableArray *chosenCards = [[NSMutableArray alloc] init];

    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
            self.score -= PEEK_COST;
        } else {

            // Collect all chosen cards
            for (Card *otherCard in self.cards) {
                if(otherCard.isChosen && !otherCard.isMatched) {
                    [chosenCards addObject:otherCard];
                }
            }
            
            // If enough cards have been selected, try to match them
            if ([chosenCards count] == self.matchMode - 1) {
                int matchScore = [card match:chosenCards];
                if (matchScore) {
                    card.matched = YES;
                    self.score += matchScore * MATCH_BONUS;
                    for(Card *otherCard in chosenCards) {
                        otherCard.matched = YES;
                    }
                } else {
                    self.score -= MISMATCH_PENALTY;
                    for(Card *otherCard in chosenCards) {
                        otherCard.chosen = NO;
                    }
                }
            }

            card.chosen = YES;
        }
    }
}

@end
