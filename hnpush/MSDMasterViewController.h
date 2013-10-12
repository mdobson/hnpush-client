//
//  MSDMasterViewController.h
//  hnpush
//
//  Created by Matthew Dobson on 10/12/13.
//  Copyright (c) 2013 Matthew Dobson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ApigeeiOSSDK/ApigeeCollection.h>
#import <ApigeeiOSSDK/ApigeeClient.h>

@interface MSDMasterViewController : UITableViewController

@property (nonatomic, retain) NSArray *stories;
@property (nonatomic, retain) ApigeeClient *client;


@end
