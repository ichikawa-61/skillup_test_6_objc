//
//  MemoDao.h
//  skillup_test_6_objc
//
//  Created by OkuderaYuki on 2017/06/06.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

@import Foundation;
#import "Memo.h"

@interface MemoDao : NSObject
+ (BOOL)insert:(Memo *)memoObject;
+ (BOOL)update:(Memo *)memoObject;
+ (NSArray<Memo *> *)selectAll;
+ (Memo *)selectByUpdateDate:(NSDate *)date;
+ (BOOL)deleteAll;
+ (BOOL)deleteId:(NSInteger)memoId;
@end
