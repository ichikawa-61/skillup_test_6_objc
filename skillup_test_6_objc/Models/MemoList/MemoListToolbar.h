//
//  MemoListToolbar.h
//  skillup_test_6_objc
//
//  Created by OkuderaYuki on 2017/06/13.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

@import Foundation;

@interface MemoListToolbar : NSObject
+ (NSString *)rightToolbarButtonTitle:(NSInteger)count;
+ (NSString *)leftToolbarButtonTitle:(BOOL)isEditing;
@end
