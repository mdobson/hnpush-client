//
//  MSDDetailViewController.h
//  hnpush
//
//  Created by Matthew Dobson on 10/12/13.
//  Copyright (c) 2013 Matthew Dobson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSDDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UIWebView *story;
@end
