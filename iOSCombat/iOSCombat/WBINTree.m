//
//  WBINTree.m
//  iOSCombat
//
//  Created by Binw on 2022/8/14.
//

#import "WBINTree.h"

@interface WBINTree()

@property (nonatomic, strong) WBINBinaryTreeNode *root;
@property (nonatomic, strong) NSArray *preorderArray;
@property (nonatomic, strong) NSArray *inorderArray;
@end

@implementation WBINTree

+ (WBINBinaryTreeNode *)createTreeWithValues:(NSArray *)values {
    
    WBINBinaryTreeNode *root = nil;
    for (NSInteger i = 0; i < values.count; i++) {
        NSInteger value = [(NSNumber *)values[i] integerValue];
        root = [WBINTree addTreeNode:root value:value];
    }
    return root;
}

+ (WBINBinaryTreeNode *)addTreeNode:(WBINBinaryTreeNode *)treeNode value:(NSInteger)value {
    //根节点不存在，创建节点
    if (!treeNode) {
        treeNode = [[WBINBinaryTreeNode alloc] init];
        treeNode.value = value;
        NSLog(@"node:%@", @(value));
    }
    
    return treeNode;
}

- (instancetype)initWithPreorder:(NSArray *)perorder AndInorder:(NSArray *)inorder
{
    if (self = [super init]) {
        
        _preorderArray = perorder;
        _inorderArray = inorder;
        
        NSUInteger arrayCount = _preorderArray.count;
        _root = [self p_createTreeWithPerorderIndex:0 rightIndex:arrayCount - 1 inorderIndex:0 rightIndex:arrayCount - 1];
    }
    
    return self;
}

- (void)printPostorderTraversalSequence
{
    [self p_printPostorderTraversalSequence:_root];
}

#pragma mark - Private
- (WBINBinaryTreeNode *)p_createTreeWithPerorderIndex:(NSInteger)pLeft rightIndex:(NSInteger)pRight inorderIndex:(NSInteger)iLeft rightIndex:(NSInteger)iRight
{
    if (pLeft > pRight)
        return nil;
    NSInteger value = [(NSNumber *)_preorderArray[pLeft] integerValue];
    NSUInteger index = [_inorderArray indexOfObject:@(value)];
    WBINBinaryTreeNode *root = [WBINTree addTreeNode:_root value:value];
    
    root.leftNode = [self p_createTreeWithPerorderIndex:pLeft + 1  rightIndex:pLeft + (index - iLeft) inorderIndex:iLeft rightIndex:index - 1];
    root.rightNode = [self p_createTreeWithPerorderIndex:pLeft + (index - iLeft) + 1  rightIndex:pRight inorderIndex:index + 1 rightIndex:iRight];
    
    return root;
}

- (void)p_printPostorderTraversalSequence:(WBINBinaryTreeNode *)root
{
    if (!root)
        return;
    if (root.leftNode) {
        [self p_printPostorderTraversalSequence:root.leftNode];
    }
        
    
    if (root.rightNode) {
        [self p_printPostorderTraversalSequence:root.rightNode];
    }
    NSLog(@"%ld", (long)root.value);
}

@end
