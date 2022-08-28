//
//  WBINTree.h
//  iOSCombat
//
//  Created by Binw on 2022/8/14.
//

#import <Foundation/Foundation.h>
#import "WBINBinaryTreeNode.h"

NS_ASSUME_NONNULL_BEGIN

@interface WBINTree : NSObject

+ (WBINBinaryTreeNode *)createTreeWithValues:(NSArray *)values;
+ (WBINBinaryTreeNode *)addTreeNode:(WBINBinaryTreeNode *)treeNode value:(NSInteger)value;

- (instancetype)initWithPreorder:(NSArray *)perorder AndInorder:(NSArray *)inorder;
- (void)printPostorderTraversalSequence;
@end

NS_ASSUME_NONNULL_END
