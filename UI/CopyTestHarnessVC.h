//
//  CopyTestHarnessVC.h
//  ACLib
//
//  Created by Dave Lilly on 9/25/13.
//  Copyright (c) 2013 Dave Lilly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CopyServiceDelegate.h"

@interface CopyTestHarnessVC : UIViewController <CopyServiceDelegate, UITableViewDataSource, UITableViewDelegate>
@property (retain, nonatomic) IBOutlet UILabel *profileNameLabel;
@property (retain, nonatomic) IBOutlet UILabel *profileEmailLabel;
@property (retain, nonatomic) IBOutlet UILabel *profileCreationDateLabel;
@property (retain, nonatomic) IBOutlet UILabel *storageQuotaLabel;
@property (retain, nonatomic) IBOutlet UILabel *storageUsedLabel;
@property (retain, nonatomic) IBOutlet UILabel *storageSavedLabel;
@property (retain, nonatomic) IBOutlet UILabel *pathLabel;
@property (retain, nonatomic) IBOutlet UILabel *folderNameLabel;
@property (retain, nonatomic) IBOutlet UITableView *directoryTable;

@end
