//
//  ABCCollectionViewFlowLayout.m
//  ABCNPIYDB
//
//  Created by Vijayakumar C on 18/8/14.
//  Copyright (c) 2014 Jabil. All rights reserved.
//

#import "ABCCollectionViewFlowLayout.h"

@implementation ABCCollectionViewFlowLayout

- (id) init{
    
    if (!(self = [super init])) return nil;
    self.itemSize = CGSizeMake(150, 227);
    self.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    self.minimumInteritemSpacing = 5.0f;
    self.minimumLineSpacing = 5.0f;
    return self;
}

@end