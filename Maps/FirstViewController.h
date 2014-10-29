//
//  FirstViewController.h
//  Maps
//
//  Created by vinay kukke on 05/09/14.
//  Copyright (c) 2014 vinay kukke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoogleResponseClass.h"

@interface FirstViewController : UIViewController<GoogleResponseClassCallBacks>

@property (nonatomic, strong) UITextField *fromAddress;
@property (nonatomic, strong) UITextField *toAddress;


- (void)goToGoogleMaps;

@end
