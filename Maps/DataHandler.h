//
//  DataHandler.h
//  Maps
//
//  Created by vinay kukke on 21/10/14.
//  Copyright (c) 2014 vinay kukke. All rights reserved.
//

#import <GoogleMaps/GoogleMaps.h>

@interface DataHandler : NSObject
{
    GMSPath *thePath;
    GMSMarker *userCreatedMarker;
}

@property (nonatomic, strong) GMSPolyline *polyline;
@property (nonatomic,strong) NSSet *markerSet;
@property (strong, nonatomic) GMSMapView *mapView;

- (void)createMarkerObjectWithJson:(NSDictionary *)json;
- (void)drawMarker;
- (void)mapView:(GMSMapView *)mapView didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate;
- (void)drawPolyline:(GMSPath *)path;

@end
