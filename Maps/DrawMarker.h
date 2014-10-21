//
//  DrawMarker.h
//  Maps
//
//  Created by vinay kukke on 21/10/14.
//  Copyright (c) 2014 vinay kukke. All rights reserved.
//

#import "GMapViewController.h"

@interface DrawMarker: NSObject
{
    GMSMarker *userCreatedMarker;
    GMapViewController *gMapVc;
}

- (void)drawMarker;
- (void)mapView:(GMSMapView *)mapView didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate;
- (void)drawPolyline:(GMSPath *)path;


@end
