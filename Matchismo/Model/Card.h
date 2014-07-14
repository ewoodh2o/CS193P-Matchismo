//
//  Card.h
//  Matchismo
//
//  Created by Elliott Wood on 7/14/14.
//  Copyright (c) 2014 Elliott Wood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

- (int)match:(NSArray *)cards;
- (UIColor *)color;

@end
