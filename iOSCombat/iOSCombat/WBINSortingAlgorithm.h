//
//  WBINSortingAlgorithm.h
//  iOSCombat
//
//  Created by Binw on 2022/8/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WBINSortingAlgorithm : NSObject

- (instancetype)initWithArray:(NSArray *)array;
- (NSArray *)array;
- (void)setArray:(NSArray *)array;

- (void)randomArray;
- (NSArray *)selectionSort;
- (NSArray *)quickSort;
- (NSArray *)heapSort;

@end

NS_ASSUME_NONNULL_END
