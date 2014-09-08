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
    GMSCameraPosition *theCamera = [GMSCameraPosition cameraWithLatitude:38.909649 longitude:-77.043442 zoom:17 bearing:0 viewingAngle:0];
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
        GMSMarker *newMarker = [[GMSMarker alloc]init];

        NSArray *routes = [json objectForKey:@"routes"];
        
            //Using this loop to get rid of some error that i was facing
            for (NSDictionary *theRoutes in routes) {
                NSDictionary *legs = theRoutes [@"legs"];
                NSArray *toFindLatAndLng = [NSArray arrayWithObject:legs];
                NSLog(@"Legs : %@", legs);
        
                NSDictionary *end_location = [toFindLatAndLng objectAtIndex:0];
                double latitude = [end_location[@"lat"] doubleValue];
                double longitude = [end_location[@"lng"] doubleValue];
            
                CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude, longitude);

                //Passing double values here bacause the json is returning a string and the position property here is expections a double value
                newMarker.position = coordinate;
        
                newMarker.title = [legs objectForKey:@"end_address"];
                newMarker.snippet = @"snippet";
                newMarker.map = nil;
                [mutableSet addObject:newMarker];
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


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
