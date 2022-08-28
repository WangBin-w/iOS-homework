//
//  WBPropertyTest.h
//  iOSCombat
//
//  Created by Binw on 2022/8/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WBINPropertyTest : NSObject

// 默认实现
@property () NSString *nameDefaultSetting;
@property (atomic, strong, readwrite) NSString *name;

// retain, strong, copy的区别与比较
@property (nonatomic, strong, readwrite) NSMutableString *mutableName;
@property (nonatomic, retain) NSString *stringRetain;
@property (nonatomic, strong) NSString *stringStrong;
@property (nonatomic, copy) NSString *stringCopy;
@property (nonatomic, retain) NSString *stringRetainFromMutbaleString;
@property (nonatomic, strong) NSString *stringStrongFromMutbaleString;
@property (nonatomic, copy) NSString *stringCopyFromMutbaleString;

// 当使用setter方法时，会报错
@property (nonatomic, readonly) NSString *stringReadonly;

// 这种写法是错误的，在赋值时会调用copy方法，当对象执行修改操作时，会报错
@property (nonatomic, copy) NSMutableString *stringMutableCopy;

// getter和setter重命名, 存取方法原本是不能以new开头的
@property (nonatomic, strong, readwrite, getter=theNewName, setter=setNewName:) NSString *newName;

// Nullability: null_unspecified/nullable/nonnull/null_resettable
@property (nonatomic, copy, readwrite) NSString *__nonnull stringNonnull;

// 最最长的写法
@property (nonatomic, readwrite, copy, getter=theNewTitle, setter=setTheNewTitle:, nullable) NSString *newTitle;

@end

NS_ASSUME_NONNULL_END
