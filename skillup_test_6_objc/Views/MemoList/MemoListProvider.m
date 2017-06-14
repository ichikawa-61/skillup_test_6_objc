//
//  MemoListProvider.m
//  skillup_test_6_objc
//
//  Created by OkuderaYuki on 2017/06/10.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

@import UIKit;
#import "MemoDao.h"
#import "MemoListCell.h"
#import "MemoListProvider.h"

@interface MemoListProvider ()
@end

@implementation MemoListProvider

- (NSInteger)memoId:(NSIndexPath *)indexPath {
    return self.items[indexPath.row].memoId;
}

// MARK: - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MemoListCell *cell = [tableView dequeueReusableCellWithIdentifier:[MemoListCell identifier]
                                                         forIndexPath:indexPath];
    
    [cell setItem:self.items[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSInteger memoId = [self memoId:indexPath];
        [MemoDao deleteId:memoId];
        
        NSArray<Memo *> *allMemo = [MemoDao selectAll];
        NSMutableArray<MemoListCellItem *> *items = [@[] mutableCopy];
        for (Memo *memo in allMemo) {
            MemoListCellItem *item = [[MemoListCellItem alloc] initWithMemo:memo];
            [items addObject:item];
        }
        self.items = items;
        
        [tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:0]]
                         withRowAnimation:UITableViewRowAnimationFade];
        
        if ([self.delegate respondsToSelector:@selector(didFinishDeleteMemo)]) {
            [self.delegate didFinishDeleteMemo];
        }
    }
}
@end
