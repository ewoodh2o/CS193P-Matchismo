//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Elliott Wood on 7/17/14.
//  Copyright (c) 2014 Elliott Wood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                    withMatchMode:(NSUInteger)matchMode
                        usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) NSInteger matchMode;
@property (nonatomic, readonly) NSString *lastAction;

@end
