//
//  TrunsTableView.h
//  Maps
//
//  Created by vinay kukke on 04/11/14.
//  Copyright (c) 2014 vinay kukke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Turns.h"

@interface TrunsTableView : UITableView <UITableViewDataSource, UITableViewDelegate>
{
    CGRect screenBounds;    
}

@property (nonatomic) Turns *theDirections;
@property (nonatomic) NSArray *theArray;

-(id)initTheTableView;

@end
