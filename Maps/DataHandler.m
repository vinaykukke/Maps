//
//  DataHandler.m
//  Maps
//
//  Created by vinay kukke on 21/10/14.
//  Copyright (c) 2014 vinay kukke. All rights reserved.
//

#import "DataHandler.h"

@interface DataHandler ()
{
    GMSMarker *marker1;
    GMSMarker *marker2;
    GMSMarker *marker3;
    GMSMarker *marker4;
}

@end

@implementation DataHandler

- (void)createMarkerObjectWithJson:(NSDictionary *)json
{
    NSMutableSet *mutableSet = [[NSMutableSet alloc] initWithSet:self.markerSet];
    DrawMarker *draw = [[DrawMarker init] alloc];
    //Making markers
    self.markerSet = [ NSSet setWithObjects:marker1, marker2, marker3, marker4, nil];
    for (NSArray *markerData in json) {
        
        if (![markerData isEqual:@"status"]) {
            GMSMarker *startPointMarker = [[GMSMarker alloc]init];
            GMSMarker *endPointMarker = [[GMSMarker alloc] init];
            
            NSArray *routes = [json objectForKey:@"routes"];
            
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
                    [draw drawPolyline:thePath];
                    
                }
                
                //Drawing the points on the map
                CLLocationCoordinate2D coordinate1 = CLLocationCoordinate2DMake(latitude1, longitude1);
                CLLocationCoordinate2D coordinate2 = CLLocationCoordinate2DMake(latitude2, longitude2);
                
                startPointMarker.position = coordinate1;
                startPointMarker.snippet = @"snippet";
                startPointMarker.title = [startPoint objectForKey:@"start_address"];
                startPointMarker.map = nil;
                [mutableSet addObject:startPointMarker];
                
                endPointMarker.position = coordinate2;
                endPointMarker.snippet = @"snippet";
                endPointMarker.title = [startPoint objectForKey:@"end_address"];
                endPointMarker.map = nil;
                [mutableSet addObject:endPointMarker];
                
            }
        }
    }
    
    //Making an immutable copy of the mutable set
    draw.theNewMarkerSet = [mutableSet copy];
    [draw drawMarker];
}


@end
