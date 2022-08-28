//
//  WBINBinaryTreeNode.h
//  iOSCombat
//
//  Created by Binw on 2022/8/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WBINBinaryTreeNode : NSObject

@property (nonatomic, assign) NSInteger value;
@property (nonatomic, strong) WBINBinaryTreeNode *leftNode;
@property (nonatomic, strong) WBINBinaryTreeNode *rightNode;

@end

NS_ASSUME_NONNULL_END
