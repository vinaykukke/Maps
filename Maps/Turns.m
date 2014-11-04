//
//  Turns.m
//  Maps
//
//  Created by vinay kukke on 23/10/14.
//  Copyright (c) 2014 vinay kukke. All rights reserved.
//

#import "Turns.h"

@implementation Turns
@synthesize fromCoordinate;
@synthesize toCoordinate;
@synthesize htmlInstructions;

-(id)initWithFromCoordinate:(CLLocationCoordinate2D)_fromCoordinate andToCoordinate:(CLLocationCoordinate2D)_toCoordinate andHTMLInstructions:(NSString *)_htmlInstructions{
    if(self = [super init]){
        self.fromCoordinate = _fromCoordinate;
        self.toCoordinate = _toCoordinate;
        self.htmlInstructions = _htmlInstructions;
    }
    
    return self;
}


@end
