//
//  MemoListToolbarTests.m
//  skillup_test_6_objc
//
//  Created by OkuderaYuki on 2017/06/13.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

@import XCTest;
#import "MemoListToolbar.h"

@interface MemoListToolbarTests : XCTestCase
@end

@implementation MemoListToolbarTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
}

/**
 rightToolbarButtonのタイトルを確認するテスト
 */
- (void)testRightToolbarButtonTitle {
    // Verify
    XCTAssertEqualObjects([MemoListToolbar rightToolbarButtonTitle:0], @"メモなし");
    XCTAssertEqualObjects([MemoListToolbar rightToolbarButtonTitle:10], @"10件のメモ");
}

/**
 leftToolbarButtonのタイトルを確認するテスト
 */
- (void)testLeftToolbarButtonTitle {
    // Verify
    XCTAssertEqualObjects([MemoListToolbar leftToolbarButtonTitle:YES], @"すべて削除");
    XCTAssertEqualObjects([MemoListToolbar leftToolbarButtonTitle:NO], @"メモ追加");
}

@end
