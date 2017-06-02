//
//  HttpTestService.h
//  JAT
//
//  Created by Vijayakumar on 6/12/14.
//  Copyright (c) 2014 Jabil. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol HttpDashBoardDownloadServiceDelegate;


@interface HttpDashBoardDownloadService : NSObject<NSURLConnectionDataDelegate>{
    NSMutableData *_receivedData;
}

@property (assign) id<HttpDashBoardDownloadServiceDelegate> delegate;

-(void) postDataToDashBoard:(NSString*)url username:(NSString*)username password:(NSString*)password delegate:(id)deleg;

@end

@protocol HttpDashBoardDownloadServiceDelegate<NSObject>
-(void) httpDashBoardData:(HttpDashBoardDownloadService*)service result:(NSData*)result;
@end

