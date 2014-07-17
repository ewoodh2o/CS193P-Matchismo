//
//  CardViewController.m
//  Matchismo
//
//  Created by Elliott Wood on 7/14/14.
//  Copyright (c) 2014 Elliott Wood. All rights reserved.
//

#import "CardViewController.h"
#import "PlayingCardDeck.h"

@interface CardViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) Deck *deck;

@end

@implementation CardViewController

- (void) setFlipCount:(int)flipCount
{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (IBAction)cardClick:(UIButton *)sender
{
    if ([sender.currentTitle length]) {
        [sender setBackgroundImage:[UIImage imageNamed:@"CardBack"] forState:UIControlStateNormal];
        [sender setTitle:nil forState:UIControlStateNormal];
    } else {
        Card *nextCard = [self.deck drawRandomCard];
        if (nextCard) {
            [sender setBackgroundImage:nil forState:UIControlStateNormal];
            [sender setTitleColor:[nextCard color] forState:UIControlStateNormal];
            [sender setTitle:[nextCard contents] forState:UIControlStateNormal];
            self.flipCount++;
        } else {
            self.deck = [[PlayingCardDeck alloc] init];
            self.flipCount = 0;
        }
    }
}

- (Deck *)deck
{
    if (!_deck) {
        self.deck = [self createDeck];
    }
    return _deck;
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}


@end
