//
//  CopyFileInfoVC.h
//  ACLib
//
//  Created by Dave Lilly on 9/25/13.
//  Copyright (c) 2013 Dave Lilly. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CopyFileSystemNode.h"

@interface CopyFileInfoVC : UIViewController
@property (retain, nonatomic) IBOutlet UILabel *fileNameLabel;
@property (retain, nonatomic) IBOutlet UILabel *lastSyncedLabel;
@property (retain, nonatomic) IBOutlet UILabel *sizeLabel;
@property (retain, nonatomic) IBOutlet UILabel *pathLabel;
@property (retain, nonatomic) IBOutlet UILabel *mimeTypeLabel;
@property (retain, nonatomic) CopyFileSystemNode* metadata;

- (IBAction)doneButtonPressed:(id)sender;
@end
