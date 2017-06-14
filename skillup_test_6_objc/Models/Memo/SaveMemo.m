//
//  SaveMemo.m
//  skillup_test_6_objc
//
//  Created by OkuderaYuki on 2017/06/13.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

#import "MemoDao.h"
#import "SaveMemo.h"

@implementation SaveMemo

+ (void)executeWithMemo:(Memo *)memo {
    
    if ([self isNewMemo:memo]) {
        
        if (![self isEmptyMemo:memo]) {
            // 新規メモで、テキストが空文字でなければINSERT
            [MemoDao insert:memo];
        }
        return;
    }
    
    // UPDATEするmemoIdをセット
    memo.memoId = [MemoDao selectByUpdateDate:memo.updateDate].memoId;
    
    // テキストが空文字の場合はDELETE、空文字でなければUPDATE
    [self isEmptyMemo:memo] ? [MemoDao deleteId:memo.memoId] : [MemoDao update:memo];
}

/// 新規メモ判定
+ (BOOL)isNewMemo:(Memo *)memo {
    if (memo.updateDate) {
        return NO;
    }
    return YES;
}

/// テキスト空文字判定
+ (BOOL)isEmptyMemo:(Memo *)memo {
    return (memo.text.length == 0);
}
@end
