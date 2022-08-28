//
//  main.m
//  iOSCombat
//
//  Created by Binw on 2022/8/8.
//

#import <Foundation/Foundation.h>
#import "WBINPropertyTest.h"
#import "WBINSortingAlgorithm.h"
#import "WBINTree.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        WBINPropertyTest *proTest = [[WBINPropertyTest alloc] init];
        NSLog(@"----默认设置----");
        NSLog(@"name: %@, nameDefaultSetting: %@", proTest.name, proTest.nameDefaultSetting);
        
        // 不可变对象：引用对象值发生变化时，其他引用该对象的属性值保持原有的值
        NSLog(@"----修改之前----");
        NSLog(@"strRetain: %@, strStrong: %@, strCopy: %@", proTest.stringRetain, proTest.stringStrong, proTest.stringCopy);
        NSLog(@"strRetain: %p, strStrong: %p, strCopy: %p", proTest.stringRetain, proTest.stringStrong, proTest.stringCopy);
        
        proTest.name = @"New name";
        NSLog(@"----修改之后----");
        NSLog(@"strRetain: %@, strStrong: %@, strCopy: %@", proTest.stringRetain, proTest.stringStrong, proTest.stringCopy);
        NSLog(@"strRetain: %p, strStrong: %p, strCopy: %p", proTest.stringRetain, proTest.stringStrong, proTest.stringCopy);
        
        // 可变对象：引用对象值发生变化时，retain和strong内存地址与引用对象相同，因此值会同样变化；copy是深拷贝，内存地址指向不同
        NSLog(@"----修改之前----");
        NSLog(@"strRetainFromMutbaleString: %@, strStrongFromMutbaleString: %@, strCopyFromMutbaleString: %@", proTest.stringRetainFromMutbaleString, proTest.stringStrongFromMutbaleString, proTest.stringCopyFromMutbaleString);
        NSLog(@"strRetainFromMutbaleString: %p, strStrongFromMutbaleString: %p, strCopyFromMutbaleString: %p", proTest.stringRetainFromMutbaleString, proTest.stringStrongFromMutbaleString, proTest.stringCopyFromMutbaleString);
        
        [proTest.mutableName appendString:@"@NewString"];
        NSLog(@"----修改之后----");
        NSLog(@"strRetainFromMutbaleString: %@, strStrongFromMutbaleString: %@, strCopyFromMutbaleString: %@", proTest.stringRetainFromMutbaleString, proTest.stringStrongFromMutbaleString, proTest.stringCopyFromMutbaleString);
        NSLog(@"strRetainFromMutbaleString: %p, strStrongFromMutbaleString: %p, strCopyFromMutbaleString: %p", proTest.stringRetainFromMutbaleString, proTest.stringStrongFromMutbaleString, proTest.stringCopyFromMutbaleString);
        
        NSLog(@"----测试getter和setter----");
        NSLog(@"newName: %@", proTest.newName);
        [proTest setNewName:@"new Name2"];
        NSLog(@"newName: %@", [proTest theNewName]);// 因为重新设置了getter方法
        
        NSLog(@"%@", proTest);
    }
    
    @autoreleasepool {
        NSArray *array = @[@(1), @(9), @(2), @(3), @(5), @(8), @(7), @(6)];
        WBINSortingAlgorithm *sorting = [[WBINSortingAlgorithm alloc] initWithArray:array];
        [sorting selectionSort];
        [sorting randomArray];
        
        [sorting quickSort];
        [sorting randomArray];
        
        [sorting heapSort];
        NSLog(@"%@", [sorting description]);
    }
    
    @autoreleasepool {
        NSArray *perorderArray = @[@(1), @(2), @(4), @(5), @(7), @(8), @(3), @(6)];
        NSArray *inorderArray = @[@(4), @(2), @(7), @(5), @(8), @(1), @(3), @(6)];
        WBINTree *tree = [[WBINTree alloc]initWithPreorder:perorderArray AndInorder:inorderArray];
        [tree printPostorderTraversalSequence];
    }
    
    return 0;
}
