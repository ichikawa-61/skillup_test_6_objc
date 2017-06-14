//
//  SQLiteHelper.h
//  skillup_test_6_objc
//
//  Created by OkuderaYuki on 2017/06/06.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

@import Foundation;
@import FMDB;

@interface SQLiteHelper : NSObject
@property (nonatomic) FMDatabase *db;
- (BOOL)dbOpen;
- (BOOL)dbClose;
- (BOOL)createMemoTable;
@end
