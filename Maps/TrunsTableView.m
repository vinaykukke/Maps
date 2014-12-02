//
//  TrunsTableView.m
//  Maps
//
//  Created by vinay kukke on 04/11/14.
//  Copyright (c) 2014 vinay kukke. All rights reserved.
//

#import "TrunsTableView.h"

@implementation TrunsTableView
@synthesize theDirections;
@synthesize theArray;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initTheTableView
{
    if (self = [super init]) {
        screenBounds = [[UIScreen mainScreen]bounds];
        self.frame = CGRectMake(0, 0, screenBounds.size.width, screenBounds.size.height);
    
        theArray = [NSArray arrayWithArray:theDirections.htmlInstructionsArray];
}
    
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [theDirections arrayCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [theDirections.htmlInstructionsArray objectAtIndex:indexPath.row];
    return cell;
}


@end
