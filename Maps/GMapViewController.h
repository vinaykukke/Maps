//
//  GMapViewController.h
//  Maps
//
//  Created by vinay kukke on 02/09/14.
//  Copyright (c) 2014 vinay kukke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "DataHandler.h"

@interface GMapViewController : UIViewController <GMSMapViewDelegate>
{
    DataHandler *dataHandler;
    GMSMarker *userCreatedMarker;
}

@property (nonatomic, strong) NSString *fromAddressString;
@property (nonatomic, strong) NSString *toAddressString;


@end
