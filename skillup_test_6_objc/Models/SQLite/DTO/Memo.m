//
//  Memo.m
//  skillup_test_6_objc
//
//  Created by OkuderaYuki on 2017/06/06.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

#import "Memo.h"

@implementation Memo

- (instancetype)initWithFMResultSet:(FMResultSet *)results {
    self = [super init];
    if (self) {
        self.memoId = [results intForColumn:@"memoId"];
        self.updateDate = [results dateForColumn:@"updateDate"];
        self.text = [results stringForColumn:@"text"];
    }
    return self;
}

@end
