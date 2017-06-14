//
//  MemoListCellTests.m
//  skillup_test_6_objc
//
//  Created by OkuderaYuki on 2017/06/14.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

@import XCTest;
#import "UIViewController+Storyboard.h"
#import "MemoListCell.h"
#import "MemoListViewController.h"

@interface MemoListViewController (MemoListCellTestsPrivate)
@property (nonatomic) IBOutlet UITableView *tableView;
@end

@interface MemoListCell (MemoListCellTestsPrivate)
@property (nonatomic) IBOutlet UILabel *memoTitleLabel;
@property (nonatomic) IBOutlet UILabel *memoTextLabel;
@property (nonatomic) IBOutlet UILabel *memoDateLabel;
@end

@interface MemoListCellTests : XCTestCase
@property (nonatomic) IBOutlet UITableView *fakeTableView;
@property (nonatomic) MemoListViewController *memoListVC;
@property (nonatomic) MemoListCell *cell;
@property (nonatomic) UIView *view;
@end

@implementation MemoListCellTests

- (void)setUp {
    [super setUp];
    UINavigationController *navigationController = (UINavigationController *)[MemoListViewController initialViewControllerWithStoryboardName:@"MemoListViewController"];
    self.memoListVC = (MemoListViewController *)navigationController.topViewController;
    [self.memoListVC performSelectorOnMainThread:@selector(loadView) withObject:nil waitUntilDone:YES];
    
    [self setUpTableView];
}

- (void)setUpTableView {
    self.view = self.memoListVC.view;
    self.fakeTableView = self.memoListVC.tableView;
    
    UINib *nib = [UINib nibWithNibName:[MemoListCell nibName] bundle:nil];
    [self.fakeTableView registerNib:nib forCellReuseIdentifier:[MemoListCell identifier]];
    self.cell = (MemoListCell *)[self.fakeTableView dequeueReusableCellWithIdentifier:[MemoListCell identifier]];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testViewLoads {
    XCTAssertNotNil(self.memoListVC.view);
    XCTAssertNotNil(self.memoListVC.tableView);
}

/**
 CellのIdentifierを確認するテスト
 */
- (void)testIdentifier {
    // Verify
    XCTAssertEqualObjects([MemoListCell identifier], @"MemoListCell");
}

/**
 CellのNibNameを確認するテスト
 */
- (void)testNibName {
    // Verify
    XCTAssertEqualObjects([MemoListCell nibName], @"MemoListCell");
}

/**
 日付を確認するテスト (今日)
 */
- (void)testDateLabelForToday {
    
    // Setup
    
    // 今日
    MemoListCellItem *item = [self makeMemoListCellItemForDateLabelTest:[self stringToDate:@"2017/06/15 01:02:03"]];
    
    // Exercise
    [self.cell setItem:item];
    
    // Verify
    XCTAssertEqualObjects(self.cell.memoDateLabel.text, @"01:02");
}

/**
 日付を確認するテスト (今年)
 */
- (void)testDateLabelForThisYear {
    
    // Setup
    
    // 今年 (今日以外)
    MemoListCellItem *item = [self makeMemoListCellItemForDateLabelTest:[self stringToDate:@"2017/06/01 01:02:03"]];
    
    // Exercise
    [self.cell setItem:item];
    
    // Verify
    XCTAssertEqualObjects(self.cell.memoDateLabel.text, @"06/01");
}

/**
 日付を確認するテスト (今年以外)
 */
- (void)testDateLabelForOtherYears {
    
    // Setup
    
    // 今年以外
    MemoListCellItem *item = [self makeMemoListCellItemForDateLabelTest:[self stringToDate:@"2020/01/01 01:02:03"]];
    
    // Exercise
    [self.cell setItem:item];
    
    // Verify
    XCTAssertEqualObjects(self.cell.memoDateLabel.text, @"2020/01/01");
}

/**
 タイトルを確認するテスト
 */
- (void)testTitleLabel {
    
    // Setup
    MemoListCellItem *item = [self makeMemoListCellItemForTitleLabelAndTextLabelTest:@"タイトル\n本文"];
    
    // Exercise
    [self.cell setItem:item];
    
    // Verify
    XCTAssertEqualObjects(self.cell.memoTitleLabel.text, @"タイトル");
}

/**
 本文を確認するテスト
 */
- (void)testTextLabel {
    
    // Setup
    MemoListCellItem *item = [self makeMemoListCellItemForTitleLabelAndTextLabelTest:@"タイトル\n本文"];
    
    // Exercise
    [self.cell setItem:item];
    
    // Verify
    XCTAssertEqualObjects(self.cell.memoTextLabel.text, @"本文");
}

// MARK: - private

- (MemoListCellItem *)makeMemoListCellItemForDateLabelTest:(NSDate *)date {
    return [self makeMemoListCellItemForTestWithDate:date text:@"タイトル\n本文"];
}

- (MemoListCellItem *)makeMemoListCellItemForTitleLabelAndTextLabelTest:(NSString *)text {
    return [self makeMemoListCellItemForTestWithDate:[NSDate date] text:text];
}

- (MemoListCellItem *)makeMemoListCellItemForTestWithDate:(NSDate *)date text:(NSString *)text {
    Memo *testMemo = [Memo new];
    testMemo.memoId = 0;
    testMemo.updateDate = date;
    testMemo.text = text;
    
    return [[MemoListCellItem alloc] initWithMemo:testMemo];
}

- (NSDate *)stringToDate:(NSString *)dateString {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"];
    formatter.dateFormat = @"yyyy/MM/dd HH:mm:ss";
    
    return [formatter dateFromString:dateString];
}

@end
