//
//  TableViewController.h
//  SQLite3DBSample
//
//  Created by Bilal ARSLAN on 06/07/14.
//  Copyright (c) 2014 Bilal ARSLAN. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditInfoViewController.h"

@interface TableViewController : UITableViewController<EditInfoViewControllerDelegate>

- (IBAction)addNewRecord:(id)sender;
@end
