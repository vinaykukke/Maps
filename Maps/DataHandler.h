//
//  DataHandler.h
//  Maps
//
//  Created by vinay kukke on 21/10/14.
//  Copyright (c) 2014 vinay kukke. All rights reserved.
//

#import <GoogleMaps/GoogleMaps.h>
#import "DrawMarker.h"

@interface DataHandler : NSObject
{
    GMSPath *thePath;
}

@property (nonatomic, strong) GMSPolyline *polyline;
@property (nonatomic,strong) NSSet *markerSet;

- (void)createMarkerObjectWithJson:(NSDictionary *)json;

@end
