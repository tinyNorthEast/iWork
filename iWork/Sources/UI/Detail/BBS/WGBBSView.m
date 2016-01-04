//
//  WGBBSView.m
//  iWork
//
//  Created by Adele on 12/24/15.
//  Copyright © 2015 impetusconsulting. All rights reserved.
//

#import "WGBBSView.h"

#import <XXNibBridge.h>
#import "UIViewAdditions.h"

#import "WGCommentModel.h"
#import "WGBBSCell.h"
#import "WGGlobal.h"

@interface WGBBSView()<XXNibBridge,UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@property (nonatomic, copy) NSArray *commentsArray;

@end

@implementation WGBBSView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView registerNib:[WGBBSCell xx_nib] forCellReuseIdentifier:[WGBBSCell xx_nibID]];
    self.tableView.rowHeight = 70;
}

- (CGFloat)viewHeightbyCommentsArray:(NSArray *)comments{
    self.commentsArray = comments;
    [self.tableView reloadData];
    if (comments.count==0) {
        return 40+70;
    }else if (comments.count == 1){
        return 40+50+70;
    }else if (comments.count ==2){
        return 40+50+70*2;
    }
    return 0;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;{
    return self.commentsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WGBBSCell *cell = [tableView dequeueReusableCellWithIdentifier:[WGBBSCell xx_nibID] forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}- (void)configureCell:(WGBBSCell *)cell forIndexPath:(NSIndexPath *)indexPath{
    WGCommentModel *aComment = [[WGCommentModel alloc] initWithDictionary:self.commentsArray[indexPath.row] error:nil];
    cell.comment = aComment;
}

#pragma mark - IBAcion
- (BOOL)isSignIn{
    return ([[WGGlobal sharedInstance] userToken].length>0?YES:NO);
}
- (IBAction)checkAllComments:(id)sender {
    if ([self isSignIn]) {
        
    }else{
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Sign" bundle:nil];
        UIViewController *vc = [sb instantiateInitialViewController];
        [[self viewController] presentViewController:vc animated:YES completion:^{
            
        }];
    }
}

@end
