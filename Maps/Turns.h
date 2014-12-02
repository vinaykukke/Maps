//
//  Turns.h
//  Maps
//
//  Created by vinay kukke on 23/10/14.
//  Copyright (c) 2014 vinay kukke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Turns : NSObject
{
    NSMutableArray *htmlInstructionsArray;
}

@property (nonatomic, strong) NSArray *htmlInstructionsArray;
@property (nonatomic) NSUInteger arrayCount;

-(id)initWithArray:(NSArray *)_htmlInstructionsArray;

@end
