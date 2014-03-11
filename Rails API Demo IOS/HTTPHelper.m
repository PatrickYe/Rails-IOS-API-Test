#import "HTTPHelper.h"

@implementation HTTPHelper

+ (NSString *) getResponse:(NSString *)input{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:input]];
    
    NSError *error = [[NSError alloc] init];
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %i", input, [responseCode statusCode]);
        return nil;
    }
    
    NSString* tResponse = [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
    NSString *trimmedResponse = [tResponse stringByTrimmingCharactersInSet:
                                 [NSCharacterSet newlineCharacterSet]];
    return trimmedResponse;
}

@end