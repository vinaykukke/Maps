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
}

@end

@implementation FirstViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    gMapVC = [[GMapViewController alloc] init];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    _fromAddress = [[UITextField alloc] initWithFrame:CGRectMake(30, 80, 200, 40)];
    _fromAddress.backgroundColor = [UIColor whiteColor];
    _toAddress = [[UITextField alloc] initWithFrame:CGRectMake(30, 130, 200, 40)];
    _toAddress.backgroundColor = [UIColor whiteColor];
    goButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [_fromAddress setBorderStyle:UITextBorderStyleRoundedRect];
    [_toAddress setBorderStyle:UITextBorderStyleRoundedRect];
    goButton.frame = CGRectMake(250, 100, 40, 40);
    [goButton setTitle:@"GO" forState:UIControlStateNormal];
    goButton.backgroundColor = [UIColor blueColor];
    [_fromAddress setPlaceholder:@"From"];
    [_toAddress setPlaceholder:@"To"];
    
    [self.view addSubview:_fromAddress];
    [self.view addSubview:_toAddress];
    [self.view addSubview:goButton];
    
    [goButton addTarget:self action:@selector(goToGoogleMaps) forControlEvents:UIControlEventTouchDown];
    
}


- (void)goToGoogleMaps
{
    gMapVC.fromAddressString = _fromAddress.text;
    gMapVC.toAddressString = _toAddress.text;
    
    [self.navigationController pushViewController:gMapVC animated:YES];
    
}

@end
