//
//  GMapViewController.m
//  Maps
//
//  Created by vinay kukke on 02/09/14.
//  Copyright (c) 2014 vinay kukke. All rights reserved.
//

#import "GMapViewController.h"
#import "FirstViewController.h"
@interface GMapViewController () {
    GMSMarker *marker1;
    GMSMarker *marker2;
    GMSMarker *marker3;
    GMSMarker *marker4;
    NSURLSession *markerSession;
    NSURL *url;
    NSString *baseURL;
    
}

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
    self.markerSet = [ NSSet setWithObjects:marker1, marker2, marker3, marker4, nil];
    
    //This will take the two locations that need to be searched
    baseURL = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%@&destination=%@&sensor=true", _fromAddressString, _toAddressString];
    url = [NSURL URLWithString:baseURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        // NSURLSessionDataTask *task = [markerSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        //Making sure that the call to google maps SDK is made on the main thread
        DataHandler *dataHandler = [[DataHandler init] alloc];
        [dataHandler createMarkerObjectWithJson:json];
    }];
    
}





@end
