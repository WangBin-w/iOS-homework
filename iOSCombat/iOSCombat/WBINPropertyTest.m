//
//  PropertyTest.m
//  iOSCombat
//
//  Created by Binw on 2022/8/8.
//

#import "WBINPropertyTest.h"

@interface WBINPropertyTest ()
@property (nonatomic, readwrite) NSString *stringReadonly;
@end

@implementation WBINPropertyTest

- (instancetype)init
{
    self = [super init];
    if (self) {
        _name = @"Init name";
        _nameDefaultSetting = @"Init nameDefaultSetting";
        _mutableName = [[NSMutableString alloc] initWithString:@"Mutable name"];
        
        _stringRetain = _name;
        _stringStrong = _name;
        _stringCopy = _name;
        // _strCopy = [_name copy];// 效果一样，因为赋值的对象是不可变对象
        // self.strCopy = _name;
        
        _stringRetainFromMutbaleString = _mutableName;
        _stringStrongFromMutbaleString = _mutableName;
        //_stringCopyFromMutbaleString = _mutableName; // copy属性其实并没有生效，内存地址指向相同
        _stringCopyFromMutbaleString = [_mutableName mutableCopy];// 内存地址指向不同
        
        _newName = @"new Name";
    }
    return self;
}

-(NSString *)description
{
    return @"WBINPropertyTest";
}

@end
