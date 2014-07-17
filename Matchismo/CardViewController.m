//
//  CardViewController.m
//  Matchismo
//
//  Created by Elliott Wood on 7/14/14.
//  Copyright (c) 2014 Elliott Wood. All rights reserved.
//

#import "CardViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardViewController ()

@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *matchMode;

@end

@implementation CardViewController

- (CardMatchingGame *)game
{
    if (!_game) {
        [self resetGame];
    }
    return _game;
}

- (void)resetGame
{
    _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                          withMatchMode:[self.matchMode selectedSegmentIndex] + 2
                                              usingDeck:[self createDeck]];
}

- (IBAction)cardClick:(UIButton *)sender
{
    self.matchMode.enabled = NO;
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

- (IBAction)newGameClick:(UIButton *)sender
{
    [self resetGame];
    [self updateUI];
    self.game = nil;
    self.matchMode.enabled = YES;
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitleColor:[card color] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
    return card.isChosen ? nil : [UIImage imageNamed:@"CardBack"];
}

- (Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}


@end
