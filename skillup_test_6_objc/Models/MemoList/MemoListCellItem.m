//
//  MemoListCellItem.m
//  skillup_test_6_objc
//
//  Created by OkuderaYuki on 2017/06/10.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

#import "MemoListCellItem.h"

@implementation MemoListCellItem

- (instancetype)initWithMemo:(Memo *)memo {
    
    self = [super init];
    if (self) {
        self.memoId = memo.memoId;
        self.updateDate = memo.updateDate;
        
        NSMutableArray<NSString *> *lines = [[memo.text componentsSeparatedByString:@"\n"] mutableCopy];
        [lines removeObject:@""];
        self.title = (lines.count > 0) ? lines.firstObject : @"";
        self.text = (lines.count > 1) ? lines[1] : @"";
    }
    return self;
}
@end
