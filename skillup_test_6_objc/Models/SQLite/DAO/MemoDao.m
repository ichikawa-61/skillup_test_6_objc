//
//  MemoDao.m
//  skillup_test_6_objc
//
//  Created by OkuderaYuki on 2017/06/06.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

@import FMDB;
#import "MemoDao.h"
#import "SQLiteHelper.h"

@implementation MemoDao

// MARK: - INSERT

/**
 レコードを新規登録する

 @param memoObject 登録するMemoObject
 @return 成功 or 失敗
 */
+ (BOOL)insert:(Memo *)memoObject {
    
    memoObject.updateDate = [NSDate date];
    
    SQLiteHelper *sqliteHelper = [SQLiteHelper new];
    NSString* sql = @"INSERT INTO MEMO(updateDate, text) VALUES(?, ?)";
    
    BOOL result = NO;
    
    [sqliteHelper dbOpen];
    result = [sqliteHelper.db executeUpdate:sql withArgumentsInArray:@[memoObject.updateDate, memoObject.text]];
    [sqliteHelper dbClose];
    return result;
}

// MARK: - UPDATE

/**
 レコードを更新する

 @param memoObject 更新するMemoObject
 @return 成功 or 失敗
 */
+ (BOOL)update:(Memo *)memoObject {
    
    SQLiteHelper *sqliteHelper = [SQLiteHelper new];
    NSString* sql = @"UPDATE MEMO SET updateDate = :UPDATEDATE, text = :TEXT WHERE memoId = :MEMOID";
    
    NSDictionary<NSString *, id> *params = @{@"UPDATEDATE": memoObject.updateDate,
                                             @"TEXT": memoObject.text,
                                             @"MEMOID": @(memoObject.memoId)};
    
    BOOL result = NO;
    
    [sqliteHelper dbOpen];
    result = [sqliteHelper.db executeUpdate:sql withParameterDictionary:params];
    [sqliteHelper dbClose];
    return result;
}

// MARK: - SELECT

/**
 更新日の降順で全レコードを取得する

 @return Memoの配列
 */
+ (NSArray<Memo *> *)selectAll {
    
    SQLiteHelper *sqliteHelper = [SQLiteHelper new];
    NSString *sql = @"SELECT * FROM MEMO ORDER BY updateDate DESC";

    NSMutableArray<Memo *>* resultArray = [@[] mutableCopy];
    
    [sqliteHelper dbOpen];
    
    FMResultSet *results = [sqliteHelper.db executeQuery:sql];
    while ([results next]) {
        Memo *memoObject = [[Memo alloc] initWithFMResultSet:results];
        [resultArray addObject:memoObject];
    }
    
    [sqliteHelper dbClose];
    return resultArray;
}

/**
 更新日を指定して、1件レコードを取得する

 @param date 取得するレコードの更新日
 @return MemoObject
 */
+ (Memo *)selectByUpdateDate:(NSDate *)date {
    SQLiteHelper *sqliteHelper = [SQLiteHelper new];
    NSString *sql = @"SELECT * FROM MEMO WHERE updateDate = ?";
    
    [sqliteHelper dbOpen];
    
    FMResultSet* results = [sqliteHelper.db executeQuery:sql withArgumentsInArray:@[date]];
    
    Memo *memoObject;
    while ([results next]) {
        memoObject = [[Memo alloc] initWithFMResultSet:results];
    }
    [sqliteHelper dbClose];
    return memoObject;
}

// MARK: - DELETE

/**
 全レコードを削除する

 @return 成功 or 失敗
 */
+ (BOOL)deleteAll {
    SQLiteHelper *sqliteHelper = [SQLiteHelper new];
    NSString *sql = @"DELETE FROM MEMO";
    
    BOOL result = NO;
    
    [sqliteHelper dbOpen];
    result = [sqliteHelper.db executeUpdate:sql];
    [sqliteHelper dbClose];
    return result;
}

/**
 memoIdを指定して、1件レコードを削除する

 @param memoId 削除するレコードのmemoId
 @return 成功 or 失敗
 */
+ (BOOL)deleteId:(NSInteger)memoId {
    SQLiteHelper *sqliteHelper = [SQLiteHelper new];
    NSString *sql = @"DELETE FROM MEMO WHERE memoId = ?";
    
    BOOL result = NO;
    
    [sqliteHelper dbOpen];
    result = [sqliteHelper.db executeUpdate:sql withArgumentsInArray:@[@(memoId)]];
    [sqliteHelper dbClose];
    return result;
}

@end
