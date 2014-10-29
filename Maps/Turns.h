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
    CLLocationCoordinate2D fromCoordinate;
    CLLocationCoordinate2D toCoordinate;
    NSString* htmlInstructions;
}
@property(nonatomic , retain)NSString* htmlInstructions;
@property(nonatomic)CLLocationCoordinate2D fromCoordinate;
@property(nonatomic)CLLocationCoordinate2D toCoordinate;

-(id)initWithFromCoordinate:(CLLocationCoordinate2D)_fromCoordinate andToCoordinate:(CLLocationCoordinate2D)_toCoordinate andHTMLInstructions:(NSString *)_htmlInstructions;

@end
