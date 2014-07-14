//
//  Deck.h
//  Matchismo
//
//  Created by Elliott Wood on 7/14/14.
//  Copyright (c) 2014 Elliott Wood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
