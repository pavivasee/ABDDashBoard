//
//  Station.m
//  ABCNPIYDB
//
//  Created by Vijayakumar C on 27/8/14.
//  Copyright (c) 2014 Jabil. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Station.h"

@implementation Station

- (id) initWithName:(NSString*)name total:(NSString*)total data715:(NSString*)data715 data815:(NSString*)data815 data915:(NSString*)data915
{
    self = [super init];
    if (self) {
        self.name = name;
        self.data715 = data715;
        self.data815 = data815;
        self.data915 = data915;
        self.total = total;
    }
    return self;
}


@end