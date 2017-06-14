//
//  MemoListCellItemTests.m
//  skillup_test_6_objc
//
//  Created by OkuderaYuki on 2017/06/13.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

@import XCTest;
#import "MemoListCellItem.h"

@interface MemoListCellItemTests : XCTestCase
@end

@implementation MemoListCellItemTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

/**
 MemoListCellItemのイニシャライザが正しいことを確認するテスト
 */
- (void)testInitWithMemo {
    
    // Setup
    Memo *memoObject1 = [self makeMemoForTestWithText:@"title\ntext1\ntext2"];
    Memo *memoObject2 = [self makeMemoForTestWithText:@"\n\ntitle\ntext"];
    Memo *memoObject3 = [self makeMemoForTestWithText:@"title\n\ntext"];
    Memo *memoObject4 = [self makeMemoForTestWithText:@"title"];
    Memo *memoObject5 = [self makeMemoForTestWithText:@""];
    
    // Exercise
    MemoListCellItem *cellItem1 = [[MemoListCellItem alloc] initWithMemo:memoObject1];
    MemoListCellItem *cellItem2 = [[MemoListCellItem alloc] initWithMemo:memoObject2];
    MemoListCellItem *cellItem3 = [[MemoListCellItem alloc] initWithMemo:memoObject3];
    MemoListCellItem *cellItem4 = [[MemoListCellItem alloc] initWithMemo:memoObject4];
    MemoListCellItem *cellItem5 = [[MemoListCellItem alloc] initWithMemo:memoObject5];
    
    // Verify
    XCTAssertEqualObjects(cellItem1.title, @"title");
    XCTAssertEqualObjects(cellItem1.text, @"text1");
    
    XCTAssertEqualObjects(cellItem2.title, @"title");
    XCTAssertEqualObjects(cellItem2.text, @"text");
    
    XCTAssertEqualObjects(cellItem3.title, @"title");
    XCTAssertEqualObjects(cellItem3.text, @"text");
    
    XCTAssertEqualObjects(cellItem4.title, @"title");
    XCTAssertEqualObjects(cellItem4.text, @"");
    
    XCTAssertEqualObjects(cellItem5.title, @"");
    XCTAssertEqualObjects(cellItem5.text, @"");
}

// MARK: - private

- (Memo *)makeMemoForTestWithText:(NSString *)text {
    Memo *memoObject = [Memo new];
    memoObject.memoId = 1;
    memoObject.updateDate = [NSDate date];
    memoObject.text = text;
    return memoObject;
}

@end
