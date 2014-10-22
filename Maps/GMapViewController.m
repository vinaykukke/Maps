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
    dataHandler = [[DataHandler alloc] init];
    
    //Setting up a URL session
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    markerSession = [NSURLSession sessionWithConfiguration:config];
    
    //Setting up the google map
    
    GMSCameraPosition *theCamera = [GMSCameraPosition cameraWithLatitude:38.909649 longitude:-77.043442 zoom:5 bearing:0 viewingAngle:0];
    dataHandler.mapView = [GMSMapView mapWithFrame:self.view.bounds camera:theCamera];
    dataHandler.mapView.mapType = kGMSTypeNormal;
    dataHandler.mapView.myLocationEnabled = YES;
    dataHandler.mapView.settings.compassButton = YES;
    dataHandler.mapView.settings.myLocationButton = YES;
    [self.view addSubview:dataHandler.mapView];
    
    
    //This will take the two locations that need to be searched
    baseURL = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%@&destination=%@&sensor=true", _fromAddressString, _toAddressString];
    url = [NSURL URLWithString:baseURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //Making sure that the call to google maps SDK is made on the main thread
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        [dataHandler createMarkerObjectWithJson:json];
        
    }];
    
}


@end
