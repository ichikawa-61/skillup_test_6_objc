//
//  MemoListProvider.h
//  skillup_test_6_objc
//
//  Created by OkuderaYuki on 2017/06/10.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

@import Foundation;
#import "MemoListCellItem.h"

@protocol DeleteMemoDelegate <NSObject>
- (void)didFinishDeleteMemo;
@end

@interface MemoListProvider : NSObject <UITableViewDataSource>
@property (nonatomic) NSArray<MemoListCellItem *> *items;
@property (weak, nonatomic) id<DeleteMemoDelegate> delegate;
@end
