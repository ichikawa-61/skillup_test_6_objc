//
//  SQLiteHelper.m
//  skillup_test_6_objc
//
//  Created by OkuderaYuki on 2017/06/06.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

#import "FileUtil.h"
#import "SQLiteHelper.h"

@implementation SQLiteHelper

// MARK: - initializer

- (instancetype)init {
    self = [super init];
    if (self) {
        DLOG(@"dbPath: %@", [FileUtil dbPath]);
        self.db = [[FMDatabase alloc] initWithPath:[FileUtil dbPath]];
#if DEBUG
        // デバッグ時のみSQLiteの実行をトレースする
        self.db.traceExecution = YES;
#endif
        [self createMemoTable];
    }
    return self;
}

// MARK: - helper

- (BOOL)dbOpen {
    return [self.db open];
}
- (BOOL)dbClose {
    return [self.db close];
}

// MARK: - CREATE TABLE

/**
 MEMOテーブルが存在しなければ作成する
 
 @return 成功 or 失敗
 */
- (BOOL)createMemoTable {
    
    NSString *sql = @"CREATE TABLE IF NOT EXISTS MEMO (memoId INTEGER PRIMARY KEY AUTOINCREMENT, updateDate DATE, text TEXT)";
    
    BOOL result = NO;
    
    [self dbOpen];
    result = [self.db executeUpdate:sql];
    [self dbClose];
    return result;
}
@end
