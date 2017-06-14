//
//  MemoViewController.m
//  skillup_test_6_objc
//
//  Created by OkuderaYuki on 2017/06/13.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

#import "UIViewController+Storyboard.h"
#import "MemoDao.h"
#import "MemoViewController.h"
#import "SaveMemo.h"

@interface MemoViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end

NSString *const storyboardName = @"MemoViewController";

@implementation MemoViewController

// MARK: - factory

/**
 MemoViewControllerのインスタンスを生成する

 @param updateDate 編集の場合はDBに登録されている更新日時、新規の場合はnil
 @return MemoViewControllerのインスタンス
 */
+ (MemoViewController *)make:(NSDate *)updateDate {
    MemoViewController *memoVC = (MemoViewController *)[MemoViewController initialViewControllerWithStoryboardName:storyboardName];
    memoVC.updateDate = updateDate;
    return memoVC;
}

// MARK: - view life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.textView resignFirstResponder];
}

// MARK: - action

- (IBAction)didTapDoneButton:(id)sender {
    
    Memo *memo = [Memo new];
    memo.text = self.textView.text;
    memo.updateDate = self.updateDate;
    [SaveMemo executeWithMemo:memo];
    
    [self.navigationController popViewControllerAnimated:true];
}

// MARK: - private

/**
 初期処理
 */
- (void)setup {
    if (self.updateDate) {
        self.textView.text = [MemoDao selectByUpdateDate:self.updateDate].text;
    }
    [self.textView becomeFirstResponder];
}
@end
