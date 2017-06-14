//
//  MemoListViewController.m
//  skillup_test_6_objc
//
//  Created by OkuderaYuki on 2017/06/06.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

#import "Memo.h"
#import "MemoDao.h"
#import "MemoListCell.h"
#import "MemoListProvider.h"
#import "MemoListToolbar.h"
#import "MemoListViewController.h"
#import "MemoViewController.h"

@interface MemoListViewController () <UITableViewDelegate, DeleteMemoDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftToolbarButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightToolbarButton;

@property (nonatomic) MemoListProvider *provider;
@property (nonatomic, getter=isEditing) BOOL editing;
@end

@implementation MemoListViewController

// MARK: - view life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self reloadToolbar];
    [self reloadTableView];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    self.editing = !self.editing;
    [self reloadToolbar];
    self.tableView.editing = !self.tableView.isEditing;
}

// MARK: - private

/**
 初期処理
 */
- (void)setup {
    self.navigationItem.title = NSLocalizedString(@"memo", @"メモ");
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self setupTableView];
}

/**
 TableViewの初期処理
 */
- (void)setupTableView {
    
    UINib *nib = [UINib nibWithNibName:[MemoListCell nibName] bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:[MemoListCell identifier]];
    
    self.provider = [MemoListProvider new];
    self.provider.delegate = self;
    self.provider.items = [self allItems];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self.provider;
}

/**
 Toolbarを更新する
 */
- (void)reloadToolbar {
    NSInteger memoCount = [MemoDao selectAll].count;
    self.rightToolbarButton.title = [MemoListToolbar rightToolbarButtonTitle:memoCount];
    self.leftToolbarButton.title = [MemoListToolbar leftToolbarButtonTitle:self.isEditing];
}


/**
 TableViewを更新する
 */
- (void)reloadTableView {
    self.provider.items = [self allItems];
    [self.tableView reloadData];
}

/**
 DBから全件取得して、MemoListCellItemの配列を生成
 
 @return MemoListCellItemの配列
 */
- (NSMutableArray<MemoListCellItem *> *)allItems {
    
    NSArray<Memo *> *allMemo = [MemoDao selectAll];
    NSMutableArray<MemoListCellItem *> *items = [@[] mutableCopy];
    for (Memo *memo in allMemo) {
        MemoListCellItem *item = [[MemoListCellItem alloc] initWithMemo:memo];
        [items addObject:item];
    }
    return items;
}

/**
 アクションシートを表示する
 */
- (void)showActionSheet {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];
    
    __weak typeof(self) weakSelf = self;
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"deleteAll", @"すべて削除")
                                                           style:UIAlertActionStyleDestructive
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             [MemoDao deleteAll];
                                                             [weakSelf reloadTableView];
                                                             [weakSelf reloadToolbar];
                                                             
                                                         }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"cancel", @"キャンセル")
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alertController addAction:deleteAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:true completion:nil];
}

// MARK: - action

- (IBAction)didTapLeftToolbarButton:(id)sender {
    
    if (self.isEditing) {
        [self showActionSheet];
    } else {
        MemoViewController *memoVC = [MemoViewController make:nil];
        [self.navigationController pushViewController:memoVC animated:true];
    }
}

// MARK: - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MemoListCellItem *item = self.provider.items[indexPath.row];
    MemoViewController *memoVC = [MemoViewController make:item.updateDate];
    [self.navigationController pushViewController:memoVC animated:true];
}

// MARK: - DeleteMemoDelegate

- (void)didFinishDeleteMemo {
    [self reloadToolbar];
}

@end
