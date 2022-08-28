//
//  ViewController.m
//  BINHuaRongDao
//
//  Created by Binw on 2022/8/19.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, assign) BOOL isFinishing;
@property (nonatomic, assign) NSInteger baseLength;
@property (nonatomic, strong) NSArray *imageNameArray;
@property (nonatomic, strong) NSArray *imageViewArray;
@property (nonatomic, strong) NSArray *directionArray;

@end

@implementation ViewController

/// 1machao 2caocao 3huangzhong 4zhangfei 5guanyu 6zhaoyun 7zu1 8zu2 9zu3 10zu4
int map[5][4] = {
    1,2,2,3,
    1,2,2,3,
    4,0,0,6,
    4,5,5,6,
    7,8,9,10
};
/// 每一行含义： 起始行数，起始列数， 单位宽度， 单位高度
///  取值范围： 0 - 4            0 - 3             1 - 2            1 - 2
int location[11][4] = {
    0,0,0,0,
    0,0,1,2,
    0,1,2,2,
    0,3,1,2,
    2,0,1,2,
    3,1,2,1,
    2,3,1,2,
    4,0,1,1,
    4,1,1,1,
    4,2,1,1,
    4,3,1,1
};

/// direction 1left 2right 3up 4down
struct BFSMap
{
    int currentTag, direction, father, map[5][4], location[11][4];
};

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.isFinishing = NO;
    self.baseLength = self.zu1ImageView.frame.size.height;
    self.imageNameArray = @[@"blank", @"马超", @"曹操", @"黄忠", @"张飞", @"关羽", @"赵云", @"卒1", @"卒2", @"卒3", @"卒4"];
    self.imageViewArray = @[self.machaoImageView, self.caocaoImageView, self.huangzhongImageView, self.zhangfeiImageView, self.guanyuImageView, self.zhaoyunImageView, self.zu1ImageView, self.zu2ImageView, self.zu3ImageView, self.zu4ImageView];
    self.directionArray = @[@"blank", @"左移", @"右移", @"上移", @"下移"];
    
    // 加载手势
    [self.imageViewArray enumerateObjectsUsingBlock:^(UIImageView *imageView, NSUInteger idx, BOOL *stop){
        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
        UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
        UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
        
        [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
        [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
        [swipeUp setDirection:UISwipeGestureRecognizerDirectionUp];
        [swipeDown setDirection:UISwipeGestureRecognizerDirectionDown];
        
        imageView.userInteractionEnabled = YES;
        [imageView addGestureRecognizer:swipeLeft];
        [imageView addGestureRecognizer:swipeRight];
        [imageView addGestureRecognizer:swipeUp];
        [imageView addGestureRecognizer:swipeDown];
    }];
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)swipe
{
    if (self.isFinishing) {
        [self showMessage:@"游戏正在自动完成中，请勿尝试移动方块！"];
        return ;
    }
    NSInteger currentViewTag = swipe.view.tag;
    CGRect rect = swipe.view.frame;
    BOOL flag = YES;
    switch (swipe.direction) {
        case UISwipeGestureRecognizerDirectionLeft:
        {
            // View是否在最左边
            if (location[currentViewTag][1] == 0) break;
            // 判断高度是否可以满足左移
            flag = [self canMoveLeftWithMap:map Loactaion:location Tag:(int)currentViewTag];
            
            if (flag) {
                // 向左移动，更新View的map和location
                for (int i = 0; i < location[currentViewTag][3]; ++i) {
                    map[location[currentViewTag][0] + i][location[currentViewTag][1] - 1] = (int)currentViewTag;
                    map[location[currentViewTag][0] + i][location[currentViewTag][1] + location[currentViewTag][2] - 1] = 0;
                }
                --location[currentViewTag][1];
                rect.origin.x -= self.baseLength;
                [UIView animateWithDuration:0.3 animations:^{
                    [swipe.view setFrame:rect];
                }];
                NSLog(@"%@向左移动!", self.imageNameArray[currentViewTag]);
            }
            break;
        }
        case UISwipeGestureRecognizerDirectionRight:
        {
            // View是否在最右边
            if(location[currentViewTag][1] + location[currentViewTag][2] == 4) break;
            // 判断高度是否可以满足右移
            flag = [self canMoveRightWithMap:map Loactaion:location Tag:(int)currentViewTag];
            
            if (flag) {
                // 向右移动，更新View的map和location
                for (int i = 0; i < location[currentViewTag][3];++i) {
                    map[location[currentViewTag][0] + i][location[currentViewTag][1] + location[currentViewTag][2]] = (int)currentViewTag;
                    map[location[currentViewTag][0] + i][location[currentViewTag][1]] = 0;
                }
                ++location[currentViewTag][1];
                rect.origin.x += self.baseLength;
                [UIView animateWithDuration:0.3 animations:^{
                    [swipe.view setFrame:rect];
                }];
                NSLog(@"%@向右移动!", self.imageNameArray[currentViewTag]);
            }
            break;
        }
        case UISwipeGestureRecognizerDirectionUp:
        {
            // View是否在最上边
            if(location[currentViewTag][0] == 0) break;
            // 判断宽度是否可以满足上移
            flag = [self canMoveUpWithMap:map Loactaion:location Tag:(int)currentViewTag];
            
            if (flag) {
                // 向上移动，更新View的map和location
                for (int i = 0; i < location[currentViewTag][2]; ++i) {
                    map[location[currentViewTag][0] - 1][location[currentViewTag][1] + i] = (int)currentViewTag;
                    map[location[currentViewTag][0] + location[currentViewTag][3] - 1][location[currentViewTag][1] + i] = 0;
                }
                --location[currentViewTag][0];
                rect.origin.y -= self.baseLength;
                [UIView animateWithDuration:0.3 animations:^{
                    [swipe.view setFrame:rect];
                }];
                NSLog(@"%@向上移动!", self.imageNameArray[currentViewTag]);
            }
            break;
        }
        case UISwipeGestureRecognizerDirectionDown:
        {
            // View是否在最下边
            if(location[currentViewTag][0] + location[currentViewTag][3] == 5) break;
            // 判断宽度是否可以满足下移
            flag = [self canMoveDownWithMap:map Loactaion:location Tag:(int)currentViewTag];
            
            if (flag) {
                // 向下移动，更新View的map和location
                for (int i = 0; i < location[currentViewTag][2]; ++i) {
                    map[location[currentViewTag][0] + location[currentViewTag][3]][location[currentViewTag][1] + i] = (int)currentViewTag;
                    map[location[currentViewTag][0]][location[currentViewTag][1] + i] = 0;
                }
                ++location[currentViewTag][0];
                rect.origin.y += self.baseLength;
                [UIView animateWithDuration:0.3 animations:^{
                    [swipe.view setFrame:rect];
                }];
                NSLog(@"%@向下移动!", self.imageNameArray[currentViewTag]);
            }
            break;
        }
    }

    if(location[2][0] == 3 && location[2][1] == 1) {
        if(self.isFinishing) {
            [self showMessage:@"已经自动完成游戏！"];
            self.isFinishing = false;
        } else {
            [self showMessage: @"恭喜您已经成功完成了游戏!"];
        }
    }
}

- (void)showMessage:(NSString *)Msg {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:Msg preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:true completion:nil];
}

- (BOOL)canMoveLeftWithMap:(int[][4])map Loactaion:(int[][4])location Tag:(int)tag
{
    BOOL flag = YES;
    for (int i = 0; i < location[tag][3] && flag; ++i) {
        if(map[location[tag][0] + i][location[tag][1] - 1]) {
            flag = NO;
        }
    }
    return flag;
}

- (BOOL)canMoveRightWithMap:(int[][4])map Loactaion:(int[][4])location Tag:(int)tag
{
    BOOL flag = YES;
    for (int i = 0; i < location[tag][3] && flag; ++i) {
        if(map[location[tag][0] + i][location[tag][1] + location[tag][2]]) {
            flag = NO;
        }
    }
    return flag;
}

- (BOOL)canMoveUpWithMap:(int[][4])map Loactaion:(int[][4])location Tag:(int)tag
{
    BOOL flag = YES;
    for (int i = 0; i < location[tag][2] && flag; ++i) {
        if(map[location[tag][0] - 1][location[tag][1] + i]) {
            flag = NO;
        }
    }
    return flag;
}

- (BOOL)canMoveDownWithMap:(int[][4])map Loactaion:(int[][4])location Tag:(int)tag
{
    BOOL flag = YES;
    for (int i = 0; i < location[tag][2] && flag; ++i) {
        if(map[location[tag][0] + location[tag][3]][location[tag][1] + i]) {
            flag = NO;
        }
    }
    return flag;
}

// 使用BFS搜索可行解，并存储已探寻路径（剪枝）
- (IBAction)clickFinishButton:(id)sender {
    self.finishButton.enabled = NO;
    self.isFinishing = YES;
    
    struct BFSMap tmp;
    memcpy(tmp.map, map, sizeof(map));
    memcpy(tmp.location, location, sizeof(location));
    
    NSMutableSet *visibleSituation = [NSMutableSet set];
    NSMutableArray *q = [[NSMutableArray alloc] init];
    NSArray *hashArray1 = [self generateHashArrayWithMap:map rows:5 cols:4];
    NSString *hashString = [NSString stringWithString:[hashArray1 componentsJoinedByString:@"."]];
    NSLog(@"%@",hashString);
    [visibleSituation addObject:hashString];
    [q addObject:[NSValue value:&tmp withObjCType:@encode(struct BFSMap)]];
    
    int l = 0, r = 1, ans = 0;
    while (l < r) {
        struct BFSMap currentBFS;
        [[q objectAtIndex:l] getValue:&currentBFS];
        // 判断曹操是否到达通关位置
        if(currentBFS.location[2][0] == 3 && currentBFS.location[2][1] == 1) {
            ans = l;
            break;
        }
        // 打印当前BFS的结果
//        if(l <= 20 || l % 5000 == 0) {
//            NSLog(@"map of %d:",l);
//            [self printMap:currentBFS.map Withrows:5 cols:4];
//        }
        
        for (int tag = 1; tag <= 10; ++tag) {
            BOOL flag = YES;
            // View是否在最左边
            if(currentBFS.location[tag][1] != 0) {
                // 判断高度是否可以满足左移
                flag = [self canMoveLeftWithMap:currentBFS.map Loactaion:currentBFS.location Tag:(int)tag];
                
                if (flag) {
                    struct BFSMap tmp2;
                    memcpy(tmp2.map, currentBFS.map, sizeof(tmp2.map));
                    memcpy(tmp2.location, currentBFS.location, sizeof(tmp2.location));
                    tmp2.currentTag = tag;
                    tmp2.direction = 1;
                    tmp2.father = l;
                    for (int i = 0; i < tmp2.location[tag][3]; ++i) {
                        tmp2.map[tmp2.location[tag][0] + i][tmp2.location[tag][1] - 1] = tag;
                        tmp2.map[tmp2.location[tag][0] + i][tmp2.location[tag][1] + tmp2.location[tag][2] - 1] = 0;
                    }
                    --tmp2.location[tag][1];
                    
                    NSArray *hashArray = [self generateHashArrayWithMap:tmp2.map rows:5 cols:4];
                    NSString *hashString = [NSString stringWithString:[hashArray componentsJoinedByString:@"."]];
                    // 若当前位置从未探寻过，则加入
                    if (![visibleSituation containsObject:hashString]) {
                        [visibleSituation addObject:hashString];
                        [q addObject:[NSValue value:&tmp2 withObjCType:@encode(struct BFSMap)]];
                        ++r;
                        // NSLog(@"%@", hashString);
                    }
                    
                }
            }
            
            flag = YES;
            // View是否在最右边
            if (currentBFS.location[tag][1] + currentBFS.location[tag][2] != 4) {
                // 判断高度是否可以满足右移
                flag = [self canMoveRightWithMap:currentBFS.map Loactaion:currentBFS.location Tag:tag];
                
                if (flag) {
                    struct BFSMap tmp2;
                    memcpy(tmp2.map, currentBFS.map, sizeof(tmp2.map));
                    memcpy(tmp2.location, currentBFS.location, sizeof(tmp2.location));
                    tmp2.currentTag = tag;
                    tmp2.direction = 2;
                    tmp2.father = l;
                    for (int i = 0; i < tmp2.location[tag][3]; ++i) {
                        tmp2.map[tmp2.location[tag][0] + i][tmp2.location[tag][1] + tmp2.location[tag][2]] = tag;
                        tmp2.map[tmp2.location[tag][0] + i][tmp2.location[tag][1]] = 0;
                    }
                    ++tmp2.location[tag][1];
                    
                    NSArray *hashArray = [self generateHashArrayWithMap:tmp2.map rows:5 cols:4];
                    NSString *hashString = [NSString stringWithString:[hashArray componentsJoinedByString:@"."]];
                    if (![visibleSituation containsObject:hashString]) {
                        [visibleSituation addObject:hashString];
                        [q addObject:[NSValue value:&tmp2 withObjCType:@encode(struct BFSMap)]];
                        ++r;
                        // NSLog(@"%@", hashString);
                    }
                    
                }
            }
            
            flag = YES;
            // View是否在最上边
            if (currentBFS.location[tag][0] != 0) {
                // 判断高度是否可以满足上移
                flag = [self canMoveUpWithMap:currentBFS.map Loactaion:currentBFS.location Tag:(int)tag];
                
                if(flag) {
                    struct BFSMap tmp2;
                    memcpy(tmp2.map, currentBFS.map, sizeof(tmp2.map));
                    memcpy(tmp2.location, currentBFS.location, sizeof(tmp2.location));
                    tmp2.currentTag = tag;
                    tmp2.direction = 3;
                    tmp2.father = l;
                    for (int i = 0; i < tmp2.location[tag][2]; ++i) {
                        tmp2.map[tmp2.location[tag][0] - 1][tmp2.location[tag][1] + i] = tag;
                        tmp2.map[tmp2.location[tag][0] + tmp2.location[tag][3] - 1][tmp2.location[tag][1] + i] = 0;
                    }
                    --tmp2.location[tag][0];
                    
                    NSArray *hashArray = [self generateHashArrayWithMap:tmp2.map rows:5 cols:4];
                    NSString *hashString = [NSString stringWithString:[hashArray componentsJoinedByString:@"."]];
                    if (![visibleSituation containsObject:hashString]) {
                        [visibleSituation addObject:hashString];
                        [q addObject:[NSValue value:&tmp2 withObjCType:@encode(struct BFSMap)]];
                        ++r;
                        // NSLog(@"%@", hashString);
                    }
                    
                }
            }
            
            flag = YES;
            // View是否在最下边
            if (currentBFS.location[tag][0] + currentBFS.location[tag][3] != 5) {
                // 判断高度是否可以满足下移
                flag = [self canMoveDownWithMap:currentBFS.map Loactaion:currentBFS.location Tag:(int)tag];
                
                if (flag) {
                    struct BFSMap tmp2;
                    memcpy(tmp2.map, currentBFS.map, sizeof(tmp2.map));
                    memcpy(tmp2.location, currentBFS.location, sizeof(tmp2.location));
                    tmp2.currentTag = tag;
                    tmp2.direction = 4;
                    tmp2.father = l;
                    for (int i = 0; i < tmp2.location[tag][2]; ++i) {
                        tmp2.map[tmp2.location[tag][0] + tmp2.location[tag][3]][tmp2.location[tag][1] + i] = tag;
                        tmp2.map[tmp2.location[tag][0]][tmp2.location[tag][1] + i] = 0;
                    }
                    ++tmp2.location[tag][0];
                    
                    NSArray *hashArray = [self generateHashArrayWithMap:tmp2.map rows:5 cols:4];
                    NSString *hashString = [NSString stringWithString:[hashArray componentsJoinedByString:@"."]];
                    if (![visibleSituation containsObject:hashString]) {
                        [visibleSituation addObject:hashString];
                        [q addObject:[NSValue value:&tmp2 withObjCType:@encode(struct BFSMap)]];
                        ++r;
                        // NSLog(@"%@", hashString);
                    }
                }
            }
        }
        
        ++l;
    }
    
    struct BFSMap tmpBFS;
    [[q objectAtIndex:ans] getValue:&tmpBFS];
    memcpy(location, tmpBFS.location, sizeof(location));
    memcpy(map, tmpBFS.map,sizeof(map));
    
    NSMutableArray *ansArray = [[NSMutableArray alloc] init];
    while (ans > 0) {
        NSNumber *ansNumber = @(ans);
        [ansArray addObject:ansNumber];
        struct BFSMap tmp2;
        [[q objectAtIndex:ans] getValue:&tmp2];
//        NSLog(@"ans %d[%s %s]",ans, [self.imageNameArray[tmp2.currentTag] UTF8String], [self.directionArray[tmp2.direction] UTF8String]);
        ans = tmp2.father;
    }
    
    float delay = 0;
    for (int i = (int)[ansArray count] - 1; i >= 0; --i) {
        int itemValue = [[ansArray objectAtIndex:i] intValue];
        struct BFSMap currentBFS;
        [[q objectAtIndex:itemValue] getValue:&currentBFS];
        NSLog(@"perform: %s %s",[self.imageNameArray[currentBFS.currentTag] UTF8String], [self.directionArray[currentBFS.direction] UTF8String]);
        
        UIImageView *imageView = self.imageViewArray[currentBFS.currentTag - 1];
        CGRect rect = imageView.frame;
        switch(currentBFS.direction)
        {
            case 1:
            {
                rect.origin.x -= self.baseLength;
                break;
            }
            case 2:
            {
                rect.origin.x += self.baseLength;
                break;
            }
            case 3:
            {
                rect.origin.y -= self.baseLength;
                break;
            }
            case 4:
            {
                rect.origin.y += self.baseLength;
                break;
            }
        }
        [UIView animateWithDuration:0.3 delay:delay+=0.3 options:UIViewAnimationOptionAllowUserInteraction animations:^{
            [imageView setFrame:rect];
        } completion:nil];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)),dispatch_get_main_queue(),^{
        [self showMessage:@"已经自动完成游戏！"];
        self.isFinishing = NO;
        self.finishButton.enabled = YES;
    });
}

/// 同类型棋子共享一个hash值
- (NSArray *)generateHashArrayWithMap:(int[][4])map rows:(int)rows cols:(int)cols
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < rows; ++i) {
        for (int j = 0; j < cols; ++j) {
            int typeIndex = 0;
            if (map[i][j] >= 7) {
                typeIndex = 7;
            } else if (map[i][j] == 2) {
                typeIndex = 2;
            } else if (map[i][j] == 5) {
                typeIndex = 5;
            } else if(map[i][j] == 0){
                typeIndex = 0;
            } else {
                typeIndex = 1;
            }
            [array addObject:[[NSNumber alloc] initWithInt:typeIndex]];
        }
    }
    return [array copy];
}

- (void)printMap:(int[][4])map Withrows:(int)rows cols:(int)cols
{
    for (int i = 0; i < rows; ++i) {
        for (int j = 0; j < cols; ++j) {
            printf("%3d",map[i][j]);
        }
        printf("\n");
    }
}

@end
