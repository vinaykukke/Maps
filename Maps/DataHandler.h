//
//  DataHandler.h
//  Maps
//
//  Created by vinay kukke on 21/10/14.
//  Copyright (c) 2014 vinay kukke. All rights reserved.
//

#import <GoogleMaps/GoogleMaps.h>
#import "Turns.h"

@interface DataHandler : NSObject
{
    GMSMarker *userCreatedMarker;
    NSMutableArray* allTurns;
}
@property(nonatomic , retain) NSMutableArray* allTurns;
@property (nonatomic, strong) GMSPolyline *polyline;
@property (nonatomic,strong) NSSet *markerSet;
@property (strong, nonatomic) GMSMapView *mapView;
@property (nonatomic, strong) GMSPath *thePath;
@property (nonatomic, strong) NSMutableArray *thePathArray;
@property (nonatomic, strong) NSString *points;

- (void)createMarkerObjectWithJson:(NSDictionary *)json;
- (void)drawMarker;
- (void)mapView:(GMSMapView *)mapView didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate;
- (void)drawPolyline:(GMSPath *)path;

@end
