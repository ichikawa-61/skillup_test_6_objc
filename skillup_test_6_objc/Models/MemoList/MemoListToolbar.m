//
//  MemoListToolbar.m
//  skillup_test_6_objc
//
//  Created by OkuderaYuki on 2017/06/13.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

#import "MemoListToolbar.h"

@implementation MemoListToolbar
+ (NSString *)rightToolbarButtonTitle:(NSInteger)count {
    return (count == 0) ? NSLocalizedString(@"noMemos", @"メモなし") : [NSString stringWithFormat:NSLocalizedString(@"memosCount", @"%d件のメモ"), count];
}

+ (NSString *)leftToolbarButtonTitle:(BOOL)isEditing {
    return isEditing ? NSLocalizedString(@"deleteAll", @"すべて削除") : NSLocalizedString(@"addMemo", @"メモ追加");
}
@end
