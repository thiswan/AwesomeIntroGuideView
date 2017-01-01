//
//  AwesomeIntroGuideLayout.m
//  AwesomeIntroGuideView
//
//  Created by Senmiao on 2017/1/1.
//  Copyright © 2017年 Senmiao. All rights reserved.
//

#import "AwesomeIntroGuideLayout.h"

NS_ASSUME_NONNULL_BEGIN

@interface AwesomeIntroGuideLayout ()

@property (nonatomic, strong, readwrite) NSMutableArray *array;

@property (nonatomic, strong, readwrite) NSDictionary <NSNumber *,NSDictionary<NSNumber *,NSValue *> *> *attributeDic;

@property (nonatomic, assign, readwrite) NSInteger gallaryCount;

@property (nonatomic, assign, readwrite) NSInteger eachCount;

@property (nonatomic, assign, readwrite) NSInteger finalCount;

@end

CG_INLINE CGRect CGRectTranslation(CGRect frame,CGFloat dx,CGFloat dy) {
    CGPoint point = frame.origin;
    CGRect temp = frame;
    point = CGPointMake(point.x + dx, point.y + dy);
    temp.origin = point;
    return temp;
}

@implementation AwesomeIntroGuideLayout

#define AwesomeWidth  self.collectionView.frame.size.width
#define AwesomeHeight  self.collectionView.frame.size.height

- (void)prepareLayout {
    [super prepareLayout];
    self.array = [NSMutableArray array];
    
    NSInteger num = [self.collectionView numberOfItemsInSection:0];
    
    self.eachCount = num > 9 ?9:num;
    self.finalCount = num > 9 ?num % 9:0;
    self.gallaryCount = floor(num/9.f) ;
    NSUInteger index = 0;
    do {
        [self.attributeDic[@(self.eachCount)] enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, NSValue * _Nonnull obj, BOOL * _Nonnull stop) {
            UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForRow:key.integerValue + 9 * index inSection:0]];
            
            CGRect frame = CGRectTranslation(obj.CGRectValue, 0, AwesomeHeight * index);
            
            attribute.frame = frame;
            
            [self.array addObject:attribute];
        }];
    } while (++index < self.gallaryCount);
    
    if (self.finalCount) {
        [self.attributeDic[@(self.finalCount)] enumerateKeysAndObjectsUsingBlock:^(NSNumber * _Nonnull key, NSValue * _Nonnull obj, BOOL * _Nonnull stop) {
            UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForRow:key.integerValue + 9 * self.gallaryCount inSection:0]];
            
            CGRect frame = CGRectTranslation(obj.CGRectValue, 0, AwesomeHeight * self.gallaryCount);
            
            attribute.frame = frame;
            
            [self.array addObject:attribute];
        }];
    }
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(AwesomeWidth, AwesomeHeight * (self.gallaryCount + 1));
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.array[indexPath.row];
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.array ;
}

#pragma mark -Accessor

-(NSDictionary <NSNumber *,NSDictionary<NSNumber *,NSValue *> *> *) attributeDic {
    if (!_attributeDic) {
        _attributeDic = @{
                          @1:@{
                                  @0:[NSValue valueWithCGRect:(CGRect){0,0,AwesomeWidth,AwesomeHeight}]
                                  },
                          @2:@{
                                  @0:[NSValue valueWithCGRect:(CGRect){0,0,AwesomeWidth,AwesomeHeight/2}],
                                  @1:[NSValue valueWithCGRect:(CGRect){0,AwesomeHeight/2,AwesomeWidth,AwesomeHeight/2}]
                                  },
                          @3:@{
                                  @0:[NSValue valueWithCGRect:(CGRect){0,0,AwesomeWidth,AwesomeWidth*0.73968254}],
                                  @1:[NSValue valueWithCGRect:(CGRect){0,AwesomeWidth*0.74,AwesomeWidth/2 -2,AwesomeHeight - AwesomeWidth*0.74}],
                                  @2:[NSValue valueWithCGRect:(CGRect){AwesomeWidth/2,AwesomeWidth*0.74,AwesomeWidth/2,AwesomeHeight - AwesomeWidth*0.74}]
                                  },
                          @4:@{
                                  @0:[NSValue valueWithCGRect:(CGRect){0,0,AwesomeWidth,AwesomeHeight - AwesomeWidth/3}],
                                  @1:[NSValue valueWithCGRect:(CGRect){0,AwesomeHeight - AwesomeWidth/3,AwesomeWidth/3-2,AwesomeWidth/3-2}],
                                  @2:[NSValue valueWithCGRect:(CGRect){AwesomeWidth/3,AwesomeHeight - AwesomeWidth/3,AwesomeWidth/3-2,AwesomeWidth/3 -2}],
                                  @3:[NSValue valueWithCGRect:(CGRect){AwesomeWidth/3 * 2,AwesomeHeight - AwesomeWidth/3,AwesomeWidth/3 -2,AwesomeWidth/3 -2}]
                                  },
                          @5:@{
                                  @0:[NSValue valueWithCGRect:(CGRect){0,0,.65625 * AwesomeWidth,.65625 * AwesomeWidth}],
                                  @1:[NSValue valueWithCGRect:(CGRect){0,.65625*AwesomeWidth,.5 * AwesomeWidth,.5 * AwesomeWidth}],
                                  @2:[NSValue valueWithCGRect:(CGRect){.5 * AwesomeWidth,.65625*AwesomeWidth,.5 * AwesomeWidth,.5 * AwesomeWidth}],
                                  @3:[NSValue valueWithCGRect:(CGRect){.65625 * AwesomeWidth,0,(1-.65625) * AwesomeWidth,.65625 * AwesomeWidth/2}],
                                  @4:[NSValue valueWithCGRect:(CGRect){.65625 * AwesomeWidth,.65625 * AwesomeWidth/2,(1-.65625) * AwesomeWidth,.65625 * AwesomeWidth/2}]
                                  },
                          @6:@{
                                  @0:[NSValue valueWithCGRect:(CGRect){0,0,AwesomeWidth - AwesomeWidth/3 -2,AwesomeHeight - AwesomeWidth/3 - 2}],
                                  @1:[NSValue valueWithCGRect:(CGRect){AwesomeWidth/3 * 2,0,AwesomeWidth/3,(AwesomeHeight - AwesomeWidth/3)/2 -2}],
                                  @2:[NSValue valueWithCGRect:(CGRect){AwesomeWidth/3 * 2,(AwesomeHeight - AwesomeWidth/3)/2,AwesomeWidth/3,(AwesomeHeight - AwesomeWidth/3)/2 -2}],
                                  @3:[NSValue valueWithCGRect:(CGRect){AwesomeWidth/3 * 2,AwesomeHeight - AwesomeWidth/3,AwesomeWidth/3,AwesomeWidth/3}],
                                  @4:[NSValue valueWithCGRect:(CGRect){AwesomeWidth/3,AwesomeHeight - AwesomeWidth/3,AwesomeWidth/3 -2,AwesomeWidth/3}],
                                  @5:[NSValue valueWithCGRect:(CGRect){0,AwesomeHeight - AwesomeWidth/3,AwesomeWidth/3 -2,AwesomeWidth/3}]
                                  },
                          @7:@{
                                  @0:[NSValue valueWithCGRect:(CGRect){0,0,AwesomeWidth,AwesomeHeight - AwesomeWidth/3 * 2 - 2}],
                                  @1:[NSValue valueWithCGRect:(CGRect){0,AwesomeHeight - AwesomeWidth/3,AwesomeWidth/3 -2,AwesomeWidth/3 -2}],
                                  @2:[NSValue valueWithCGRect:(CGRect){AwesomeWidth/3,AwesomeHeight - AwesomeWidth/3,AwesomeWidth/3 -2,AwesomeWidth/3 -2}],
                                  @3:[NSValue valueWithCGRect:(CGRect){AwesomeWidth/3 *2,AwesomeHeight - AwesomeWidth/3,AwesomeWidth/3 -2,AwesomeWidth/3 -2}],
                                  @4:[NSValue valueWithCGRect:(CGRect){0,AwesomeHeight - AwesomeWidth/3 * 2,AwesomeWidth/3 -2,AwesomeWidth/3 -2}],
                                  @5:[NSValue valueWithCGRect:(CGRect){AwesomeWidth/3,AwesomeHeight - AwesomeWidth/3 * 2,AwesomeWidth/3 -2,AwesomeWidth/3 -2}],
                                  @6:[NSValue valueWithCGRect:(CGRect){AwesomeWidth/3 *2,AwesomeHeight - AwesomeWidth/3 * 2,AwesomeWidth/3 -2,AwesomeWidth/3 -2}],
                                  },
                          @8:@{
                                  @0:[NSValue valueWithCGRect:(CGRect){0,0,AwesomeWidth/2-3,AwesomeHeight - 2 * AwesomeWidth/3}],
                                  @1:[NSValue valueWithCGRect:(CGRect){AwesomeWidth/2,0,AwesomeWidth/2,AwesomeHeight - 2 * AwesomeWidth/3}],
                                  @2:[NSValue valueWithCGRect:(CGRect){0,AwesomeHeight - 2 * AwesomeWidth/3,AwesomeWidth/3 -2,AwesomeWidth/3 -2}],
                                  @3:[NSValue valueWithCGRect:(CGRect){AwesomeWidth/3,AwesomeHeight - 2 * AwesomeWidth/3,AwesomeWidth/3 -2,AwesomeWidth/3 -2}],
                                  @4:[NSValue valueWithCGRect:(CGRect){AwesomeWidth/3 * 2,AwesomeHeight - 2 * AwesomeWidth/3,AwesomeWidth/3 -2,AwesomeWidth/3 -2}],
                                  @5:[NSValue valueWithCGRect:(CGRect){0,AwesomeHeight - 2 * AwesomeWidth/3 + AwesomeWidth/3,AwesomeWidth/3 -2,AwesomeWidth/3 -2}],
                                  @6:[NSValue valueWithCGRect:(CGRect){AwesomeWidth/3,AwesomeHeight - 2 * AwesomeWidth/3 + AwesomeWidth/3,AwesomeWidth/3 -2,AwesomeWidth/3 -2}],
                                  @7:[NSValue valueWithCGRect:(CGRect){AwesomeWidth/3 * 2,AwesomeHeight - 2 * AwesomeWidth/3 + AwesomeWidth/3,AwesomeWidth/3 -2,AwesomeWidth/3 -2}],
                                  },
                          @9:@{
                                  @0:[NSValue valueWithCGRect:(CGRect){0,0,AwesomeWidth/3-3,AwesomeWidth/3-3}],
                                  @1:[NSValue valueWithCGRect:(CGRect){AwesomeWidth/3,0,AwesomeWidth/3-3,AwesomeWidth/3-3}],
                                  @2:[NSValue valueWithCGRect:(CGRect){2 * AwesomeWidth/3,0,AwesomeWidth/3 -2,AwesomeWidth/3 -2}],
                                  @3:[NSValue valueWithCGRect:(CGRect){0,AwesomeWidth/3,AwesomeWidth/3-3,AwesomeWidth/3-3}],
                                  @4:[NSValue valueWithCGRect:(CGRect){AwesomeWidth/3,AwesomeWidth/3,AwesomeWidth/3-3,AwesomeWidth/3-3}],
                                  @5:[NSValue valueWithCGRect:(CGRect){2 * AwesomeWidth/3,AwesomeWidth/3,AwesomeWidth/3 -2,AwesomeWidth/3 -2}],
                                  @6:[NSValue valueWithCGRect:(CGRect){0,AwesomeWidth/3 * 2,AwesomeWidth/3-3,AwesomeWidth/3-3}],
                                  @7:[NSValue valueWithCGRect:(CGRect){AwesomeWidth/3,AwesomeWidth/3 * 2,AwesomeWidth/3-3,AwesomeWidth/3-3}],
                                  @8:[NSValue valueWithCGRect:(CGRect){2 * AwesomeWidth/3,AwesomeWidth/3 * 2,AwesomeWidth/3 -2,AwesomeWidth/3 -2}],
                                  }
                          } ;
    }
    return _attributeDic;
}

@end
NS_ASSUME_NONNULL_END
