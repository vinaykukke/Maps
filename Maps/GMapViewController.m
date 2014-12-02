//
//  GMapViewController.m
//  Maps
//
//  Created by vinay kukke on 02/09/14.
//  Copyright (c) 2014 vinay kukke. All rights reserved.
//

#import "GMapViewController.h"



@interface GMapViewController () <UISearchBarDelegate>

@end

@implementation GMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Initializing the GoogleResponseClass and assigining the delegate
    googleResponse = [GoogleResponseClass sharedInstance];
    googleResponse.delegate = self;
    
    //Making the search bar.
    screenBounds = [[UIScreen mainScreen] bounds];
    _searchBarOne = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, screenBounds.size.width, 40)];
    _searchBarOne.delegate = self;
    _searchBarOne.placeholder = @"To Address";
    
    //Initialize Datahandler class to get access to the mapview property.
    dataHandler = [[DataHandler alloc]init];
    
    //Setting up the google map
    GMSCameraPosition *theCamera = [GMSCameraPosition cameraWithLatitude:38.909649 longitude:-77.043442 zoom:5 bearing:0 viewingAngle:0];
    dataHandler.mapView = [GMSMapView mapWithFrame:self.view.bounds camera:theCamera];
    dataHandler.mapView.mapType = kGMSTypeNormal;
    dataHandler.mapView.myLocationEnabled = YES;
    dataHandler.mapView.settings.compassButton = YES;
    dataHandler.mapView.settings.myLocationButton = YES;
    
    //adding button to mapview
    
    
    [self.view addSubview:dataHandler.mapView];
    [self.view addSubview:_searchBarOne];
    
}

- (void) searchBarTextDidBeginEditing:(UISearchBar *)searchBar

{
    //If searchBarTwo has not been created, then create it
    if(!_searchBarTwo){
        _searchBarTwo = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 105, screenBounds.size.width, 40)];
        _searchBarTwo.delegate = self;
        _searchBarTwo.placeholder =@"From Address";

    }
    
    //If tableview has not been created, then create it
    if(!myTableView){
        myTableView = [[CityTableView alloc] initWithFrame:CGRectMake(0, 145, screenBounds.size.width, screenBounds.size.height)  style:UITableViewStylePlain];

    }
    
    //Removing mapview from subview and adding the tableview
    [dataHandler.mapView removeFromSuperview];
    
    [self.view addSubview:_searchBarTwo];
    [self.view addSubview:myTableView];
    
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //Removing all the unwanted elements from the view
    [_searchBarOne removeFromSuperview];
    [_searchBarTwo removeFromSuperview];
    [myTableView removeFromSuperview];
    
    //Sending the user input places to the googleresponse class on click of return button
    [googleResponse requestResponseForFromAddress:_searchBarOne.text andToAddress:_searchBarTwo.text];
    
}

- (void)didGetResponse:(NSDictionary *)_response
{
    googleResposeData = _response;
    
    //Adding the mapView as subview
    [self.view addSubview:dataHandler.mapView];
    
    //creating the marker objects to be displayed on the map
    [dataHandler createMarkerObjectWithJson:googleResposeData];
    
    //going through the path array to get all the encoded string paths provided by google and usign that to draw polyline on the map.
    for (NSString *path in dataHandler.thePathArray) {
     dataHandler.thePath = [GMSPath pathFromEncodedPath:path];
     [dataHandler drawPolyline:dataHandler.thePath];
     
     }
     //drawing the markers/adding the marker objects to the mapView.
     [dataHandler drawMarker];
    
    UIBarButtonItem *turnsButton = [[UIBarButtonItem alloc] initWithTitle:@"Start" style:UIBarButtonItemStylePlain target:self action:@selector(loadTurnsTableView)];
    self.navigationItem.rightBarButtonItem = turnsButton;
}

-(void)loadTurnsTableView
{
    //if the tabeView has not been created then create it and remove the mapview from subview and add the tableview to subview.
    if (!turnsTableView) {
        turnsTableView = [[TrunsTableView alloc]initTheTableView];
        [dataHandler.mapView removeFromSuperview];
        [self.view addSubview:turnsTableView];
        turnsTableView.delegate = turnsTableView;
        turnsTableView.dataSource = turnsTableView.theArray;

    }
}

@end
