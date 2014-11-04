//
//  GoogleResponseClass.h
//  Maps
//
//  Created by vinay kukke on 23/10/14.
//  Copyright (c) 2014 vinay kukke. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol GoogleResponseClassCallBacks
    
-(void)didGetResponse:(NSDictionary *)_response;

@end

@interface GoogleResponseClass : NSObject{
    __unsafe_unretained id delegate;
}
@property (nonatomic , assign)id delegate;
@property (nonatomic, strong) NSString *fromAddressString;
@property (nonatomic, strong) NSString *toAddressString;

//Creating a singleton (below)
+ (GoogleResponseClass *)sharedInstance;
- (void)requestResponseForFromAddress:(NSString *)_fromAdd andToAddress:(NSString *)_toAdd;

@end
