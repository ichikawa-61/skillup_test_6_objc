//
//  MemoDaoTests.m
//  skillup_test_6_objc
//
//  Created by OkuderaYuki on 2017/06/07.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

@import XCTest;
#import "MemoDao.h"

@interface MemoDaoTests : XCTestCase
@end

@implementation MemoDaoTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

/**
 登録、更新するテスト
 */
- (void)testInsertAndUpdate {
    
    /* INSERT */
    // Setup
    [MemoDao deleteAll];
    XCTAssertEqual([MemoDao selectAll].count, 0);
    
    Memo *memoObject = [Memo new];
    memoObject.updateDate = [NSDate date];
    memoObject.text = @"タイトル\nテキスト1\nテキスト2";
    
    // Exercise
    [MemoDao insert:memoObject];
    
    // Verify
    NSArray<Memo *> *results = [MemoDao selectAll];
    XCTAssertEqual(results.count, 1);
    XCTAssertEqualObjects(results[0].updateDate.description, memoObject.updateDate.description);
    XCTAssertEqualObjects(results[0].text, @"タイトル\nテキスト1\nテキスト2");
    
    /* UPDATE */
    
    // Setup
    Memo *selectedMemo = [MemoDao selectAll].firstObject;
    selectedMemo.updateDate = [[NSDate alloc] initWithTimeIntervalSinceNow:3*60*60*24];
    selectedMemo.text = @"タイトル";
    [MemoDao update:selectedMemo];

    // Exercise
    [MemoDao update:selectedMemo];
    
    // Verify
    NSArray<Memo *> *results2 = [MemoDao selectAll];
    XCTAssertEqual(results2.count, 1);
    XCTAssertEqualObjects(results2[0].updateDate.description, selectedMemo.updateDate.description);
    XCTAssertEqualObjects(results2[0].text, @"タイトル");
}

/**
 updateDateが新しい順に全件取得するテスト
 */
- (void)testSelectAll {
    
    // Setup
    [MemoDao deleteAll];
    XCTAssertEqual([MemoDao selectAll].count, 0);
    
    Memo *memoObject = [Memo new];
    memoObject.memoId = 1;
    memoObject.updateDate = [[NSDate alloc] initWithTimeIntervalSinceNow:-1*60*60*24];
    memoObject.text = @"タイトル";
    [MemoDao insert:memoObject];
    
    Memo *memoObject2 = [Memo new];
    memoObject2.memoId = 2;
    memoObject2.updateDate = [[NSDate date] initWithTimeIntervalSinceNow:-370*60*60*24];
    memoObject2.text = @"タイトル\nテキスト";
    [MemoDao insert:memoObject2];
    
    Memo *memoObject3 = [Memo new];
    memoObject3.memoId = 3;
    memoObject3.updateDate = [NSDate date];
    memoObject3.text = @"\nタイトル";
    [MemoDao insert:memoObject3];
    
    // Exercise
    NSArray<Memo *> *results2 = [MemoDao selectAll];
    
    // Verify
    XCTAssertEqual(results2.count, 3);
    XCTAssertEqualObjects(results2[0].updateDate.description, memoObject3.updateDate.description);
    XCTAssertEqualObjects(results2[0].text, @"\nタイトル");
    XCTAssertEqualObjects(results2[1].updateDate.description, memoObject2.updateDate.description);
    XCTAssertEqualObjects(results2[1].text, @"タイトル\nテキスト");
    XCTAssertEqualObjects(results2[2].updateDate.description, memoObject.updateDate.description);
    XCTAssertEqualObjects(results2[2].text, @"タイトル");
}

/**
 updateDateを指定してレコードを取得するテスト
 */
- (void)testSelectByUpdateDate {
    // Setup
    [MemoDao deleteAll];
    XCTAssertEqual([MemoDao selectAll].count, 0);
    
    Memo *memoObject = [Memo new];
    memoObject.memoId = 1;
    memoObject.updateDate = [NSDate date];
    memoObject.text = @"タイトル";
    [MemoDao insert:memoObject];
    
    // Exercise
    Memo *result = [MemoDao selectByUpdateDate:memoObject.updateDate];
    
    // Verify
    XCTAssertNotNil(result);
    XCTAssertEqualObjects(result.updateDate.description, memoObject.updateDate.description);
    XCTAssertEqualObjects(result.text, @"タイトル");
}

/**
 全件削除するテスト
 */
- (void)testDeleteAll {
    
    // Setup
    [MemoDao deleteAll];
    XCTAssertEqual([MemoDao selectAll].count, 0);
    
    Memo *memoObject = [Memo new];
    memoObject.memoId = 1;
    memoObject.updateDate = [NSDate date];
    memoObject.text = @"タイトル";
    [MemoDao insert:memoObject];
    
    Memo *memoObject2 = [Memo new];
    memoObject2.memoId = 2;
    memoObject2.updateDate = [NSDate date];
    memoObject2.text = @"タイトル\nテキスト";
    [MemoDao insert:memoObject2];
    
    XCTAssertEqual([MemoDao selectAll].count, 2);
    
    // Exercise
    [MemoDao deleteAll];
    
    // Verify
    XCTAssertEqual([MemoDao selectAll].count, 0);
}

/**
 memoIdを指定してレコードを削除するテスト
 */
- (void)testDeleteId {
    
    // Setup
    [MemoDao deleteAll];
    XCTAssertEqual([MemoDao selectAll].count, 0);
    
    Memo *memoObject = [Memo new];
    memoObject.memoId = 1;
    memoObject.updateDate = [NSDate date];
    memoObject.text = @"タイトル";
    [MemoDao insert:memoObject];
    
    Memo *memoObject2 = [Memo new];
    memoObject2.memoId = 2;
    memoObject2.updateDate = [NSDate date];
    memoObject2.text = @"タイトル\nテキスト";
    [MemoDao insert:memoObject2];
    
    XCTAssertEqual([MemoDao selectAll].count, 2);
    
    Memo *deleteMemo = [MemoDao selectByUpdateDate:memoObject.updateDate];
    // Exercise
    [MemoDao deleteId:deleteMemo.memoId];
    
    // Verify
    NSArray<Memo *> *result = [MemoDao selectAll];
    XCTAssertEqual(result.count, 1);
    XCTAssertEqualObjects(result[0].updateDate.description, memoObject2.updateDate.description);
    XCTAssertEqualObjects(result[0].text, @"タイトル\nテキスト");
}

@end
