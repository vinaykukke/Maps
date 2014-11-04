//
//  GoogleResponseClass.m
//  Maps
//
//  Created by vinay kukke on 23/10/14.
//  Copyright (c) 2014 vinay kukke. All rights reserved.
//

#import "GoogleResponseClass.h"

static GoogleResponseClass *instance = Nil;

@implementation GoogleResponseClass
@synthesize delegate;

//The created singleton
+ (GoogleResponseClass *)sharedInstance
{
    if(instance ==  Nil){
        instance = [[GoogleResponseClass alloc] init];
    }
    return instance;
}

-(void)requestResponseForFromAddress:(NSString *)_fromAdd andToAddress:(NSString *)_toAdd
{
    //This will take the two locations that need to be searched
    NSString *baseURL = [NSString stringWithFormat:@"http://maps.googleapis.com/maps/api/directions/json?origin=%@&destination=%@&sensor=true", _fromAdd, _toAdd];
    NSURL *url = [NSURL URLWithString:baseURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    //This variable will aslo be copied when the block is eecuted so we can access the variable
    __block NSDictionary *retDictionary;
    
    //Making sure that the call to google maps SDK is made on the main thread
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(connectionError){
            NSLog(@"The error is ****** %@", connectionError);
        }
        else{
            retDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            
            [self.delegate didGetResponse:retDictionary];

        }
        
    }];
    
    
}


@end
