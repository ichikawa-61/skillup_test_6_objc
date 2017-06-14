//
//  FileUtil.m
//  skillup_test_6_objc
//
//  Created by OkuderaYuki on 2017/06/06.
//  Copyright © 2017年 YukiOkudera. All rights reserved.
//

#import "FileUtil.h"

@implementation FileUtil

+ (NSString *)documentsDirectory {
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
}

+ (NSString *)dbPath {
    return [self.documentsDirectory stringByAppendingPathComponent:@"database.db"];
}

@end
