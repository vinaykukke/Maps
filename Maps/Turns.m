//
//  Turns.m
//  Maps
//
//  Created by vinay kukke on 23/10/14.
//  Copyright (c) 2014 vinay kukke. All rights reserved.
//

#import "Turns.h"

@implementation Turns
@synthesize htmlInstructionsArray;
@synthesize arrayCount;

-(id)initWithArray:(NSArray *)_htmlInstructionsArray
{
    if (self = [super init]) {
        self.htmlInstructionsArray = [_htmlInstructionsArray copy];
        arrayCount = [self.htmlInstructionsArray count];
    }
    
    return self;
}


@end
