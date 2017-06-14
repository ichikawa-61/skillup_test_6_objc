//
//  Memo.h
//  skillup_test_6_objc
//
//  Created by OkuderaYuki on 2017/06/06.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

@import Foundation;
@import FMDB;

@interface Memo : NSObject
@property (nonatomic) NSInteger memoId;
@property (nonatomic) NSDate *updateDate;
@property (nonatomic) NSString *text;

- (instancetype)initWithFMResultSet:(FMResultSet *)results;
@end
