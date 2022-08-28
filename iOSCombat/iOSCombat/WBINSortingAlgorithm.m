//
//  WBINSortingAlgorithm.m
//  iOSCombat
//
//  Created by Binw on 2022/8/14.
//

#import "WBINSortingAlgorithm.h"

@interface WBINSortingAlgorithm()

@property (nonatomic, strong) NSMutableArray *mubtableArray;

@end

@implementation WBINSortingAlgorithm

- (instancetype)initWithArray:(NSArray *)array
{
    if(self = [super init]) {
        _mubtableArray = [array mutableCopy];
    }
    
    return self;
}

- (NSArray *)array
{
    return [_mubtableArray copy];
}

- (void)setArray:(NSArray *)array
{
    _mubtableArray = [array mutableCopy];
}

- (void)randomArray
{
    NSArray *newArray = [[_mubtableArray copy] sortedArrayUsingComparator:^NSComparisonResult(NSNumber *n1, NSNumber *n2) {
        int seed = arc4random_uniform(2);
        if (seed) {
            return 1;
        } else {
            return -1;
        }
    }];
    _mubtableArray = [newArray mutableCopy];
}

- (NSArray *)selectionSort
{
    NSInteger arrayCount = [_mubtableArray count];
    for (NSInteger i = 1; i < arrayCount; i++) {
        NSInteger index = i;
        for (NSInteger j = i - 1; j >= 0; j--) {
            if([_mubtableArray[j] doubleValue] > [_mubtableArray[index] doubleValue]) {
                [_mubtableArray exchangeObjectAtIndex:j withObjectAtIndex:index];
                index--;
            }
            else {
                break;
            }
        }
    }
    
    return [_mubtableArray copy];
}

- (NSArray *)quickSort
{
    [self p_quickSort:_mubtableArray leftIndex:0 rightIndex:[_mubtableArray count] - 1];
    
    return [_mubtableArray copy];
}

- (NSArray *)heapSort
{
    NSInteger arrayCount = [_mubtableArray count];
    // 大顶堆实现升序排列
    // 建立大顶堆
    for (NSInteger i = arrayCount / 2 - 1; i >= 0; i--) {
        NSInteger sonIndex = i * 2 + 1;
        NSInteger j = i;
        while (sonIndex < arrayCount) {
            if (sonIndex + 1 < arrayCount && [_mubtableArray[sonIndex] doubleValue] < [_mubtableArray[sonIndex + 1] doubleValue]) {
                // 有右孩子且右孩子比左孩子值大
                sonIndex += 1;
            }
            if ([_mubtableArray[j] doubleValue] < [_mubtableArray[sonIndex] doubleValue]) {
                [_mubtableArray exchangeObjectAtIndex:j withObjectAtIndex:sonIndex];
            }
            
            j = sonIndex;
            sonIndex = sonIndex * 2 + 1;
        }
    }
    
    // 排序
    for (NSInteger i = arrayCount - 1; i >= 0; i--) {
        [_mubtableArray exchangeObjectAtIndex:i withObjectAtIndex:0];
        NSInteger j = 0;
        NSInteger sonIndex = j * 2 + 1;
        
        while (sonIndex < arrayCount) {
            // 有右孩子且右孩子比左孩子值大
            if (sonIndex + 1 < arrayCount && [_mubtableArray[sonIndex] doubleValue] < [_mubtableArray[sonIndex + 1] doubleValue]) {// 有右孩子且左孩子值小于右孩子值
                sonIndex += 1;
            }
            // i之后的都是排序好的
            if (sonIndex < i && [_mubtableArray[j] doubleValue] < [_mubtableArray[sonIndex] doubleValue]) {
                [_mubtableArray exchangeObjectAtIndex:j withObjectAtIndex:sonIndex];
            }
            j = sonIndex;
            sonIndex = sonIndex * 2 + 1;
        }
    }
    
    return [_mubtableArray copy];
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@", _mubtableArray];
}

#pragma mark - Private

- (void)p_quickSort:(NSMutableArray *)mutableArray leftIndex:(NSInteger)left rightIndex:(NSInteger)right
{
    if (left >= right) {//如果数组长度为0或1时返回
        return ;
    }
    
    NSInteger leftIndex = left;
    NSInteger rightIndex = right;
    
    NSInteger middle = left + (right - left) / 2;
    if ([mutableArray[left] doubleValue] > [mutableArray[middle] doubleValue]) {
        [mutableArray exchangeObjectAtIndex:left withObjectAtIndex:middle];
    }
    if ([mutableArray[left] doubleValue] > [mutableArray[right] doubleValue]) {
        [mutableArray exchangeObjectAtIndex:left withObjectAtIndex:right];
    }
    if ([mutableArray[right] doubleValue] < [mutableArray[middle] doubleValue]) {
        [mutableArray exchangeObjectAtIndex:right withObjectAtIndex:left];
    } else {
        [mutableArray exchangeObjectAtIndex:middle withObjectAtIndex:left];
    }
    
    NSInteger k = left;
    NSNumber *kObj = mutableArray[k];
    while(leftIndex < rightIndex){
        while(leftIndex < rightIndex && [mutableArray[rightIndex] doubleValue] > [kObj doubleValue])
            rightIndex--;
        mutableArray[leftIndex] = mutableArray[rightIndex];
        
        while(leftIndex < rightIndex && [mutableArray[leftIndex] doubleValue] < [kObj doubleValue])
            leftIndex++;
        mutableArray[rightIndex] = mutableArray[leftIndex];
    }
    mutableArray[leftIndex] = kObj;
    
    [self p_quickSort:mutableArray leftIndex:left rightIndex:leftIndex - 1];
    [self p_quickSort:mutableArray leftIndex:leftIndex + 1 rightIndex:right];
}


@end
