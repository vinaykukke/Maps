//
//  GMapViewController.m
//  Maps
//
//  Created by vinay kukke on 02/09/14.
//  Copyright (c) 2014 vinay kukke. All rights reserved.
//

#import "GMapViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "FirstViewController.h"
@interface GMapViewController () <GMSMapViewDelegate>
{
    GMSMarker *marker1;
    GMSMarker *marker2;
    GMSMarker *marker3;
    GMSMarker *marker4;
    NSSet *markerSet;
    NSURLSession *markerSession;
    NSURL *url;
    GMSMarker *userCreatedMarker;
    NSString *baseURL;
    GMSPolyline *polyline;
    GMSPath *thePath;
    
    
}

@property (strong, nonatomic) GMSMapView *mapView;


@end

@implementation GMapViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    //Setting up a URL session
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    markerSession = [NSURLSession sessionWithConfiguration:config];
    
    //Setting up the google map
    GMSCameraPosition *theCamera = [GMSCameraPosition cameraWithLatitude:38.909649 longitude:-77.043442 zoom:5 bearing:0 viewingAngle:0];
    self.mapView = [GMSMapView mapWithFrame:self.view.bounds camera:theCamera];
    self.mapView.mapType = kGMSTypeNormal;
    self.mapView.myLocationEnabled = YES;
    self.mapView.settings.compassButton = YES;
    self.mapView.settings.myLocationButton = YES;
    [self.view addSubview:self.mapView];
    

    
    //Making markers
    markerSet = [ NSSet setWithObjects:marker1, marker2, marker3, marker4, nil];
    
    //This will take the two locations that need to be searched
    baseURL = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%@&destination=%@&sensor=true", _fromAddressString, _toAddressString];
    url = [NSURL URLWithString:baseURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        // NSURLSessionDataTask *task = [markerSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        //Making sure that the call to google maps SDK is made on the main thread
        [self createMarkerObjectWithJson:json];
    }];
    
}



- (void)createMarkerObjectWithJson:(NSDictionary *)json
{
        NSMutableSet *mutableSet = [[NSMutableSet alloc] initWithSet:markerSet];
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
                polyline.map = nil;
                //I got the html instructions here in this step
                for (int i = 0; i < steps.count; i++) {
                    NSDictionary *instructions = [steps objectAtIndex:i];
                    NSDictionary *routeOverviewPolyline = [instructions objectForKey:@"polyline"];
                    NSString *points = [routeOverviewPolyline objectForKey:@"points"];
                    thePath = [GMSPath pathFromEncodedPath:points];
                    [self drawPolyline:thePath];
            
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
    markerSet = [mutableSet copy];
    [self drawMarker];
}

//Making sure the markers are drawn only once and not many times to save memory
- (void)drawMarker
{
    for (GMSMarker *marker in markerSet) {
        if (marker.map == nil) {
            marker.appearAnimation = kGMSMarkerAnimationPop;
            marker.map = self.mapView;
        }
        
        if (userCreatedMarker != nil && userCreatedMarker.map == nil) {
            userCreatedMarker.map = self.mapView;
            
            //Opens the info window directly when the marker is made, no need to tap on it
            self.mapView.selectedMarker = userCreatedMarker;
            
            //To recenter the map on the user created marker
            GMSCameraUpdate *cameraUpdate = [GMSCameraUpdate setTarget:userCreatedMarker.position];
            [self.mapView animateWithCameraUpdate:cameraUpdate];
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
    polyline = [GMSPolyline polylineWithPath:path];
    polyline.strokeColor = [UIColor blueColor];
    polyline.strokeWidth = 10.f;
    
    polyline.map = self.mapView;
}

@end
