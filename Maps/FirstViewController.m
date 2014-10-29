//
//  FirstViewController.m
//  Maps
//
//  Created by vinay kukke on 05/09/14.
//  Copyright (c) 2014 vinay kukke. All rights reserved.
//

#import "FirstViewController.h"
#import "GMapViewController.h"


@interface FirstViewController ()
{
    UIButton *goButton;
    GMapViewController *gMapVC;
    GoogleResponseClass *gRespones;
}

@end

@implementation FirstViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    gRespones = [GoogleResponseClass sharedInstance];
    
    //Making sure this is the class that has to follow the delegate
    gRespones.delegate = self;
    self.view.backgroundColor = [UIColor blackColor];
    
    //From Address textfield
    _fromAddress = [[UITextField alloc] initWithFrame:CGRectMake(30, 80, 200, 40)];
    _fromAddress.backgroundColor = [UIColor whiteColor];
    [_fromAddress setBorderStyle:UITextBorderStyleRoundedRect];
    [_fromAddress setPlaceholder:@"From"];
    
    //To address text field
    _toAddress = [[UITextField alloc] initWithFrame:CGRectMake(30, 130, 200, 40)];
    _toAddress.backgroundColor = [UIColor whiteColor];
    [_toAddress setBorderStyle:UITextBorderStyleRoundedRect];
    [_toAddress setPlaceholder:@"To"];
    
    //Go Button
    goButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    goButton.frame = CGRectMake(250, 100, 40, 40);
    [goButton setTitle:@"GO" forState:UIControlStateNormal];
    goButton.backgroundColor = [UIColor blueColor];
    
    
    [self.view addSubview:_fromAddress];
    [self.view addSubview:_toAddress];
    [self.view addSubview:goButton];
    
    //Adding action to UIButton
    [goButton addTarget:self action:@selector(goToGoogleMaps) forControlEvents:UIControlEventTouchDown];
    
}

- (void)didGetResponse:(NSDictionary *)_response
{
    gMapVC = [[GMapViewController alloc] initWithGoogleData:_response];
    [self.navigationController pushViewController:gMapVC animated:YES];
    
}

- (void)goToGoogleMaps
{
    [gRespones requestResponseForFromAddress:_fromAddress.text andToAddress:_toAddress.text];
   
}

@end
