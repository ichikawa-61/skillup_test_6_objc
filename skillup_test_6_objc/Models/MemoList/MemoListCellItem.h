//
//  MemoListCellItem.h
//  skillup_test_6_objc
//
//  Created by OkuderaYuki on 2017/06/10.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

@import Foundation;
#import "Memo.h"

@interface MemoListCellItem : NSObject
@property (nonatomic) NSInteger memoId;
@property (nonatomic) NSDate *updateDate;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *text;

- (instancetype)initWithMemo:(Memo *)memo;
@end
