//
//  MSDMasterViewController.m
//  hnpush
//
//  Created by Matthew Dobson on 10/12/13.
//  Copyright (c) 2013 Matthew Dobson. All rights reserved.
//

#import "MSDMasterViewController.h"

#import "MSDDetailViewController.h"
#import <ApigeeiOSSDK/ApigeeClient.h>
#import <ApigeeiOSSDK/ApigeeDataClient.h>
#import <ApigeeiOSSDK/ApigeeQuery.h>
#import <ApigeeiOSSDK/ApigeeClientResponse.h>

@interface MSDMasterViewController () {
    NSMutableArray *_objects;
}
@end

@implementation MSDMasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.client = [[ApigeeClient alloc] initWithOrganizationId:@"mdobson" applicationId:@"pushtome-dev"];
    
    ApigeeQuery *query = [[ApigeeQuery alloc] init];
    [query addRequirement:@"order by created desc"];
    [[self.client dataClient] getEntities:@"stories"
                                    query:query
                        completionHandler:^(ApigeeClientResponse *response){
                            if (response.error) {
                                NSLog(@"Error");
                            } else {
                                self.stories = response.response[@"entities"];
                                [self.tableView reloadData];
                            }
                        }];
    
	
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.stories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSString *title = self.stories[indexPath.row][@"title"];
    cell.textLabel.text = title;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDictionary *object = self.stories[indexPath.row];
        [[segue destinationViewController] setDetailItem:object];
    }
}

@end
