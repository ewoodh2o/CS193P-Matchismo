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
@property (nonatomic, readwrite) NSString *lastAction;

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
    NSMutableArray *selectedCards = [self selectedCards];
    
    self.lastAction = nil;

    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
            self.score -= PEEK_COST;
        } else {

            // If enough cards have been selected, try to match them
            if ([selectedCards count] == self.matchMode - 1) {
                int matchScore = [card match:selectedCards];
                if (matchScore) {
                    card.matched = YES;
                    self.score += matchScore * MATCH_BONUS;
                    for(Card *otherCard in selectedCards) {
                        otherCard.matched = YES;
                    }
                    self.lastAction = [self matchMessageForCard:card
                                                     withOthers:selectedCards
                                                       forScore:matchScore * MATCH_BONUS];
                } else {
                    self.score -= MISMATCH_PENALTY;
                    for(Card *otherCard in selectedCards) {
                        otherCard.chosen = NO;
                    }
                    self.lastAction = [self mismatchMessageForCard:card
                                                        withOthers:selectedCards
                                                          forScore:MISMATCH_PENALTY];
                }
            }

            card.chosen = YES;
        }
    }
    
    [self fillLastActionWithSelection];
}

- (NSMutableArray *)selectedCards
{
    NSMutableArray *selectedCards = [[NSMutableArray alloc] init];
    
    for (Card *card in self.cards) {
        if(card.isChosen && !card.isMatched) {
            [selectedCards addObject:card];
        }
    }
    
    return selectedCards;
}

- (void)fillLastActionWithSelection
{
    if (self.lastAction) {
        return;
    }

    NSArray *selectedCards = [self selectedCards];
    if ([selectedCards count] > 0) {
        self.lastAction = [NSString stringWithFormat:@"%@selected",
                           [self cardContentsAsString:selectedCards]];
    }
}

- (NSString *)cardContentsAsString:(NSArray *)cards
{
    NSMutableString *retVal = [[NSMutableString alloc] init];
    
    for (Card *card in cards) {
        [retVal appendFormat:@"%@ ", card.contents];
    }
    
    return [retVal copy];
}

- (NSString *)mismatchMessageForCard:(Card *)card withOthers:(NSArray *)otherCards forScore:(int)score
{
    NSArray *cards = [otherCards arrayByAddingObject:card];
    
    return [NSString stringWithFormat:@"%@ don't match! -%d points",
            [self cardContentsAsString:cards],
            score];
}

- (NSString *)matchMessageForCard:(Card *)card withOthers:(NSArray *)otherCards forScore:(int)score
{
    NSArray *cards = [otherCards arrayByAddingObject:card];
    
    return [NSString stringWithFormat:@"Matched %@for %d points.",
            [self cardContentsAsString:cards],
            score];
}

@end
