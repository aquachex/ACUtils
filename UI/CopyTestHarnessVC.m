//
//  CopyTestHarnessVC.m
//  ACLib
//
//  Created by Dave Lilly on 9/25/13.
//  Copyright (c) 2013 Dave Lilly. All rights reserved.
//

#import "CopyTestHarnessVC.h"
#import "CopySession.h"
#import "NSString+AC.h"
#import "CopyFileInfoVC.h"

@interface CopyTestHarnessVC ()
@property (nonatomic, retain) CopyFileSystemNode* currentFileSystemNode;
@end

@implementation CopyTestHarnessVC

- (void) viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(copySessionAuthenticated) name:kCopySessionAuthenticatedNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [CopySession sharedInstance];
}

- (void) copySessionAuthenticated
{
    [[CopySession sharedInstance] loadUserProfile:self];
    [[CopySession sharedInstance] loadMetadataForPath:@"" delegate:self];
}

#pragma mark- CopyServiceDelegate methods
- (void) userProfileLoaded:(CopyUserProfile *) userProfile
{
    self.profileNameLabel.text = userProfile.profileUserName;
    self.profileEmailLabel.text = userProfile.email;
    self.profileCreationDateLabel.text = userProfile.profileCreationDate;
    self.storageQuotaLabel.text = userProfile.quotaStorage;
    self.storageUsedLabel.text = userProfile.usedStorage;
    self.storageSavedLabel.text = userProfile.savedStorage;
}

- (void) metadataLoaded:(CopyFileSystemNode *) metadata
{
    self.pathLabel.text = metadata._id;
    self.folderNameLabel.text = metadata.name;

    self.currentFileSystemNode = metadata;
    [self.directoryTable reloadData];
}

#pragma mark- UITableViewDataSource methods
- (int) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (int) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.currentFileSystemNode.children.count + 1;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    if (indexPath.row == 0)
    {
        cell.textLabel.text = @"..";
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        BOOL enabled = ![self.currentFileSystemNode.type isEqualToString:@"copy"];
        cell.userInteractionEnabled = enabled;
        cell.textLabel.enabled = enabled;
        cell.detailTextLabel.enabled = enabled;
    }
    else
    {
        CopyFileSystemNode* selectedChild = self.currentFileSystemNode.children[indexPath.row - 1];
        cell.textLabel.text = selectedChild.name;
        cell.accessoryType = [selectedChild.type isEqualToString:@"file"] ? UITableViewCellAccessoryDetailButton : UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

#pragma mark- UITableViewDelegate methods
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0)
    {
        [[CopySession sharedInstance] loadMetadataForPath:[self.currentFileSystemNode.path substringToLastIndexOf:@"/"] delegate:self];
    }
    else
    {
        CopyFileSystemNode* selectedChild = self.currentFileSystemNode.children[indexPath.row - 1];

        if ([selectedChild.type isEqualToString:@"dir"])
        {
            [[CopySession sharedInstance] loadMetadataForPath:selectedChild.path delegate:self];
        }
        else if ([selectedChild.type isEqualToString:@"file"])
        {
            
        }
    }
}

- (void) tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > 0)
    {
        CopyFileSystemNode* selectedChild = self.currentFileSystemNode.children[indexPath.row - 1];
        
        if ([selectedChild.type isEqualToString:@"file"])
        {
            CopyFileInfoVC* fileInfo = [[CopyFileInfoVC alloc] initWithNibName:@"CopyFileInfoVC" bundle:[NSBundle mainBundle]];
            fileInfo.metadata = selectedChild;
            fileInfo.modalInPopover = NO;
            fileInfo.modalPresentationStyle = UIModalPresentationFormSheet;
            [self presentViewController:fileInfo animated:YES completion:nil];
        }
    }
}

- (void)dealloc {
    [_directoryTable release];
    [_pathLabel release];
    [super dealloc];
}
@end
