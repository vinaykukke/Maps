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
    NSDictionary *startPoint;
    NSDictionary *start_location;
    double latitude1;
    double longitude1;
    NSDictionary *end_location;
    double latitude2;
    double longitude2;
    NSString *htmlTurnByTurnInstructions;
}

@end

@implementation DataHandler
@synthesize allHtmlTrunByTurnInstructions;

- (void)createMarkerObjectWithJson:(NSDictionary *)json
{
    NSMutableSet *mutableSet = [[NSMutableSet alloc] initWithSet:self.markerSet];
    //Making markers
    self.markerSet = [ NSSet setWithObjects:marker1, marker2, marker3, marker4, nil];
    
    //looking for key "routes" in the json dictionary
    NSArray *theRoutesArray = [json objectForKey:@"routes"];
    
            //creating the two GMS markers that we need
            GMSMarker *startPointMarker = [[GMSMarker alloc]init];
            GMSMarker *endPointMarker = [[GMSMarker alloc] init];
    
            //Initializing the mutable array.
            allHtmlTrunByTurnInstructions = [[NSMutableArray alloc]init];
    
            //Getting the points for coordinates and polylines
            [self getPointsAndPolylines:theRoutesArray];
            
            //Creating the coordinates
            CLLocationCoordinate2D coordinate1 = CLLocationCoordinate2DMake(latitude1, longitude1);
            CLLocationCoordinate2D coordinate2 = CLLocationCoordinate2DMake(latitude2, longitude2);
            turnAndPolylinesData = [[Turns alloc]initWithArray:allHtmlTrunByTurnInstructions];
    
                //setting the properties for the markers
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


    //Making an immutable copy of the mutable set
    //When you use copy here it means that you are taking ownership of the object
    self.markerSet = [mutableSet copy];
}

- (void)getPointsAndPolylines:(NSArray *)_ponitsAndPolylines
{

        NSDictionary *routes = [_ponitsAndPolylines objectAtIndex:0];
    
        //Getting the starting point
         NSArray *legs = [routes objectForKey:@"legs"];
         startPoint = [legs objectAtIndex:0];
        start_location = [startPoint objectForKey:@"start_location"];
        latitude1 = [start_location[@"lat"] doubleValue];
        longitude1 = [start_location[@"lng"] doubleValue];
        
        //Getting the enp point
        end_location = [startPoint objectForKey:@"end_location"];
        latitude2 = [end_location[@"lat"] doubleValue];
        longitude2 = [end_location[@"lng"] doubleValue];
        NSArray *steps = [startPoint objectForKey:@"steps"];
        _polyline.map = nil;
        _thePathArray = [[NSMutableArray alloc] init];
    
        //getting the HTML turn by turn instructions and the points for polyline information
        for (int i = 0; i < steps.count; i++) {
            NSDictionary *instructions = [steps objectAtIndex:i];
            htmlTurnByTurnInstructions = [instructions objectForKey:@"html_instructions"];
            
            //adding all the html string directions into an array so it can be used again
            [allHtmlTrunByTurnInstructions addObject:htmlTurnByTurnInstructions];
            NSDictionary *routeOverviewPolyline = [instructions objectForKey:@"polyline"];
            _points = [routeOverviewPolyline objectForKey:@"points"];
            [_thePathArray addObject:_points];
    }
    
}


- (void)drawMarker
{
    //setting the map property so that the google SDK can add the marker to the mapview
    for (GMSMarker *marker in self.markerSet) {
        if (marker.map == nil) {
            marker.appearAnimation = kGMSMarkerAnimationPop;
            marker.map = _mapView;
        }
        
        if (userCreatedMarker != nil && userCreatedMarker.map == nil) {
            userCreatedMarker.map = _mapView;
            
            //Opens the info window directly when the marker is made, no need to tap on it
            _mapView.selectedMarker = userCreatedMarker;
            
            //To recenter the map on the user created marker
            GMSCameraUpdate *cameraUpdate = [GMSCameraUpdate setTarget:userCreatedMarker.position];
            [_mapView animateWithCameraUpdate:cameraUpdate];
        }
    }
    
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
    
}

- (void)mapView:(GMSMapView *)mapView didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate
{
    //to prevent more than one user created marker to be on the map
    if (userCreatedMarker != nil) {
        userCreatedMarker.map = nil;
        userCreatedMarker = nil;
    }
    
    GMSGeocoder *geocoder = [GMSGeocoder geocoder];
    [geocoder reverseGeocodeCoordinate:coordinate completionHandler:^(GMSReverseGeocodeResponse *response, NSError *error){
        GMSMarker *marker = [[GMSMarker alloc]init];
        marker.position = coordinate;
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.map = nil;
        
        //This will give you the street adderss
        marker.title = response.firstResult.thoroughfare;
        //This will give you the name of the city
        marker.snippet = response.firstResult.locality;
        userCreatedMarker = marker;
        [self drawMarker];
        
    }];
    
}


- (void)drawPolyline:(GMSPath *)path
{
    //drawing the polylines and adding them to the mapview
    _polyline = [GMSPolyline polylineWithPath:path];
    _polyline.strokeColor = [UIColor blueColor];
    _polyline.strokeWidth = 10.f;
    _polyline.map = _mapView;
}




@end
