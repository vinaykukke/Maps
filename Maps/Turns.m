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

/*- (void)getPointsAndPolylines:(NSDictionary *)_ponitsAndPolylines
{
    NSArray *routes = [_ponitsAndPolylines objectForKey:@"routes"];
    
    //Using this loop to get rid of some error that i was facing
    for (NSDictionary *theRoutes in routes) {
        NSArray *legs = theRoutes [@"legs"];
        
        //Getting the starting point
        NSDictionary *startPoint = [legs objectAtIndex:0];
        NSDictionary *start_location = [startPoint objectForKey:@"start_location"];
        double latitude1 = [start_location[@"lat"] doubleValue];
        double longitude1 = [start_location[@"lng"] doubleValue];
        
        //Getting the enp point
        NSDictionary *end_location = [startPoint objectForKey:@"end_location"];
        double latitude2 = [end_location[@"lat"] doubleValue];
        double longitude2 = [end_location[@"lng"] doubleValue];
        NSArray *steps = [startPoint objectForKey:@"steps"];
        self.polyline.map = nil;
        
        //I got the html instructions here in this step
        for (int i = 0; i < steps.count; i++) {
            NSDictionary *instructions = [steps objectAtIndex:i];
            NSDictionary *routeOverviewPolyline = [instructions objectForKey:@"polyline"];
            NSString *points = [routeOverviewPolyline objectForKey:@"points"];
            thePath = [GMSPath pathFromEncodedPath:points];
            [self drawPolyline:thePath];

}*/

@end
