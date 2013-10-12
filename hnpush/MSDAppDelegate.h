//
//  MSDAppDelegate.h
//  hnpush
//
//  Created by Matthew Dobson on 10/12/13.
//  Copyright (c) 2013 Matthew Dobson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ApigeeiOSSDK/ApigeeClient.h>

@interface MSDAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ApigeeClient *client;

@end
