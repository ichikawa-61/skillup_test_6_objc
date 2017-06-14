//
//  UIViewController+Storyboard.m
//  skillup_test_6_objc
//
//  Created by OkuderaYuki on 2017/06/13.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

#import "UIViewController+Storyboard.h"

@implementation UIViewController (Storyboard)

+ (UIViewController *)initialViewControllerWithStoryboardName:(NSString *)storyboardName {
    return [[UIStoryboard storyboardWithName:storyboardName bundle:nil] instantiateInitialViewController];
}

@end
