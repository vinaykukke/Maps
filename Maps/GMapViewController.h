//
//  GMapViewController.h
//  Maps
//
//  Created by vinay kukke on 02/09/14.
//  Copyright (c) 2014 vinay kukke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "CityTableView.h"
#import "GoogleResponseClass.h"
#import "DataHandler.h"
#import "TrunsTableView.h"


/*typedef struct{
    
    int toto;
    float bobo;
    
    
}ThisStruct;*/


@interface GMapViewController : UIViewController <GMSMapViewDelegate, GoogleResponseClassCallBacks>
{
    GMSMarker *userCreatedMarker;
    NSDictionary *googleResposeData;
    //ThisStruct myStruct;
    CGRect screenBounds;
    CityTableView *myTableView;
    DataHandler *dataHandler;
    GoogleResponseClass *googleResponse;
    TrunsTableView *turnsTableView;
    
}

@property (nonatomic, strong) UISearchBar *searchBarOne;
@property (nonatomic, strong) UISearchBar *searchBarTwo;


@end
