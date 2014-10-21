//
//  DrawMarker.m
//  Maps
//
//  Created by vinay kukke on 21/10/14.
//  Copyright (c) 2014 vinay kukke. All rights reserved.
//

#import "DrawMarker.h"

@interface DrawMarker ()

@end

@implementation DrawMarker


//Making sure the markers are drawn only once and not many times to save memory
- (void)drawMarker
{
    gMapVc = [[GMapViewController init] alloc];
    for (GMSMarker *marker in gMapVc.markerSet) {
        if (marker.map == nil) {
            marker.appearAnimation = kGMSMarkerAnimationPop;
            marker.map = gMapVc.mapView;
        }
        
        if (userCreatedMarker != nil && userCreatedMarker.map == nil) {
            userCreatedMarker.map = gMapVc.mapView;
            
            //Opens the info window directly when the marker is made, no need to tap on it
            gMapVc.mapView.selectedMarker = userCreatedMarker;
            
            //To recenter the map on the user created marker
            GMSCameraUpdate *cameraUpdate = [GMSCameraUpdate setTarget:userCreatedMarker.position];
            [gMapVc.mapView animateWithCameraUpdate:cameraUpdate];
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
    DataHandler *dataForPolyline = [[DataHandler init] alloc];
    dataForPolyline.polyline = [GMSPolyline polylineWithPath:path];
    dataForPolyline.polyline.strokeColor = [UIColor blueColor];
    dataForPolyline.polyline.strokeWidth = 10.f;
    
    dataForPolyline.polyline.map = gMapVc.mapView;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
