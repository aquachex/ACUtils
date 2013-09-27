//
//  CopyFileInfoVC.m
//  ACLib
//
//  Created by Dave Lilly on 9/25/13.
//  Copyright (c) 2013 Dave Lilly. All rights reserved.
//

#import "CopyFileInfoVC.h"

@interface CopyFileInfoVC ()

@end

@implementation CopyFileInfoVC

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.fileNameLabel.text = self.metadata.name;
    self.lastSyncedLabel.text = [self.metadata lastSyncedDate];
    self.sizeLabel.text = self.metadata.size;
    self.pathLabel.text = self.metadata.path;
    self.mimeTypeLabel.text = self.metadata.mimeType;
}

- (IBAction)doneButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dealloc {
    [_mimeTypeLabel release];
    [super dealloc];
}
@end
