//
//  Card.m
//  Matchismo
//
//  Created by Elliott Wood on 7/14/14.
//  Copyright (c) 2014 Elliott Wood. All rights reserved.
//

#import "Card.h"
#import <UIKit/UIKit.h>

@interface Card()

@end

@implementation Card


- (int)match:(NSArray *)cards
{
    int score = 0;
    
    for(Card *card in cards) {
        if ([card.contents isEqualToString:self.contents]) {
            score = 1;
        }
    }
    return score;
}

- (UIColor *)color
{
    return [UIColor blackColor];
}

@end
