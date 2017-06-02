//
//  Station.h
//  ABCNPIYDB
//
//  Created by Vijayakumar C on 27/8/14.
//  Copyright (c) 2014 Jabil. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Station : NSObject

@property (nonatomic,strong) NSString *name;
@property (nonatomic, strong) NSString *total;
@property (nonatomic, strong) NSString *data715;
@property (nonatomic, strong) NSString *data815;
@property (nonatomic, strong) NSString *data915;
@property (nonatomic, strong) NSString *data1015;
@property (nonatomic, strong) NSString *data1115;
@property (nonatomic, strong) NSString *data1215;
@property (nonatomic, strong) NSString *data1315;
@property (nonatomic, strong) NSString *data1415;
@property (nonatomic, strong) NSString *data1515;
@property (nonatomic, strong) NSString *data1615;
@property (nonatomic, strong) NSString *data1715;
@property (nonatomic, strong) NSString *data1815;

- (id) initWithName:(NSString*)name total:(NSString*)total data715:(NSString*)data715 data815:(NSString*)data815 data915:(NSString*)data915;

@end