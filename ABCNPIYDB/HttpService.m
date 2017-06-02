//
//  HttpTestService.m
//  JAT
//
//  Created by Vijayakumar on 6/12/14.
//  Copyright (c) 2014 Jabil. All rights reserved.
//

#import "HttpService.h"

@interface HttpDashBoardDownloadService()
{
    NSString *_username;
    NSString *_password;
}
@end

@implementation HttpDashBoardDownloadService

@synthesize delegate;



-(void) postDataToDashBoard:(NSString*)url username:(NSString*)username password:(NSString*)password delegate:(id)deleg
{
    [self setDelegate:deleg];
    // reset the credentials cache...
    NSDictionary *credentialsDict = [[NSURLCredentialStorage sharedCredentialStorage] allCredentials];
    
    if ([credentialsDict count] > 0) {
        // the credentialsDict has NSURLProtectionSpace objs as keys and dicts of userName => NSURLCredential
        NSEnumerator *protectionSpaceEnumerator = [credentialsDict keyEnumerator];
        id urlProtectionSpace;
        
        // iterate over all NSURLProtectionSpaces
        while (urlProtectionSpace = [protectionSpaceEnumerator nextObject]) {
            NSEnumerator *userNameEnumerator = [[credentialsDict objectForKey:urlProtectionSpace] keyEnumerator];
            id userName;
            
            // iterate over all usernames for this protectionspace, which are the keys for the actual NSURLCredentials
            while (userName = [userNameEnumerator nextObject]) {
                NSURLCredential *cred = [[credentialsDict objectForKey:urlProtectionSpace] objectForKey:userName];
                NSLog(@"cred to be removed: %@", cred);
                [[NSURLCredentialStorage sharedCredentialStorage] removeCredential:cred forProtectionSpace:urlProtectionSpace];
            }
        }
    }

    
    NSString *data = [NSString stringWithFormat:@"txtdate=%@&hidConfig=%@",@"09/23/2014 12:00 AM", @"062314"];
    
    NSString *encoded_data = [data stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
    
    NSLog(@"%@", encoded_data);
    
    NSData *postData = [encoded_data dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSString *postLength=[NSString stringWithFormat:@"%d",(int)[postData length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]init];
    [request setURL:[NSURL URLWithString:url]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:postData];
    
    NSURLConnection *con = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    if(con){
        _receivedData =[[NSMutableData alloc] init];
        _username = [NSString stringWithFormat:@"%@", username];
        _password = [NSString stringWithFormat:@"%@", password];
    }else{
       // [self.delegate httpTestResult:self result:@"FAIL" ];
    }
}

-(void)connection:(NSURLConnection*)connection didReceiveResponse:(NSURLResponse *)response{
    NSLog(@"didReceiveResponse");
    [_receivedData setLength:0];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    NSLog(@"didReceiveData");
    [_receivedData appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    
   // NSString *data = [[NSString alloc] initWithBytes:[_receivedData mutableBytes] length:[_receivedData length] encoding:NSASCIIStringEncoding];
  //  NSLog(@"connectionDidFinishLoading:\n%@", data);

    [self.delegate httpDashBoardData:self result:_receivedData ];
  
}

-(void)connection:(NSURLConnection*)connection didFailWithError:(NSError *)error{
    NSLog(@"didFailWithError");

    //[self.delegate httpTestResult:self result:@"FAIL" ];
}

- (void) connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
    NSLog(@"auth");
    if ([challenge previousFailureCount] == 0) {
        [[challenge sender]  useCredential:[NSURLCredential credentialWithUser:_username password:_password persistence:NSURLCredentialPersistenceForSession] forAuthenticationChallenge:challenge];
    } else {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
    }

    /*NSURLCredential *newCredential = [NSURLCredential credentialWithUser:@"CV" password:@"c_vijay12345" persistence:NSURLCredentialPersistenceForSession];
    [[challenge sender] useCredential:newCredential forAuthenticationChallenge:challenge ];*/
    
}

@end

