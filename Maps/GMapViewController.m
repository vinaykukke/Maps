//
//  GMapViewController.m
//  Maps
//
//  Created by vinay kukke on 02/09/14.
//  Copyright (c) 2014 vinay kukke. All rights reserved.
//

#import "GMapViewController.h"
#import "FirstViewController.h"
@interface GMapViewController ()

@end

@implementation GMapViewController

- (id)initWithGoogleData:(NSDictionary *)googleData
{
    if (self = [super init]) {
        googleResposeData = googleData;
        dataHandler = [[DataHandler alloc]init];
        [dataHandler createMarkerObjectWithJson:googleResposeData];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Setting up the google map
    GMSCameraPosition *theCamera = [GMSCameraPosition cameraWithLatitude:38.909649 longitude:-77.043442 zoom:5 bearing:0 viewingAngle:0];
    dataHandler.mapView = [GMSMapView mapWithFrame:self.view.bounds camera:theCamera];
    dataHandler.mapView.mapType = kGMSTypeNormal;
    dataHandler.mapView.myLocationEnabled = YES;
    dataHandler.mapView.settings.compassButton = YES;
    dataHandler.mapView.settings.myLocationButton = YES;
    [self.view addSubview:dataHandler.mapView];
    
    for (NSString *path in dataHandler.thePathArray) {
        dataHandler.thePath = [GMSPath pathFromEncodedPath:path];
        [dataHandler drawPolyline:dataHandler.thePath];

    }
    
    [dataHandler drawMarker];
    
}


@end
