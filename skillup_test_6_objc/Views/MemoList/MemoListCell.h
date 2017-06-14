//
//  MemoListCell.h
//  skillup_test_6_objc
//
//  Created by OkuderaYuki on 2017/06/10.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

@import UIKit;
#import "MemoListCellItem.h"

@interface MemoListCell : UITableViewCell
+ (NSString *)identifier;
+ (NSString *)nibName;
- (void)setItem:(MemoListCellItem *)item;
@end
