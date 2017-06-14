//
//  MemoViewController.h
//  skillup_test_6_objc
//
//  Created by OkuderaYuki on 2017/06/13.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

@import UIKit;

@interface MemoViewController : UIViewController
@property (nonatomic) NSDate *updateDate;
+ (MemoViewController *)make:(NSDate *)updateDate;
@end
