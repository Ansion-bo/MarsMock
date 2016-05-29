//
//  NSString+fitToURL.m
//  Mars
//
//  Created by Wayde C. on 1/1/16.
//  Copyright © 2016 Wayde C. All rights reserved.
//

#import "NSString+fitToURL.h"

@implementation NSString (fitToURL)

- (NSString *)cutToFitAURL {

    NSRange range =  [self rangeOfString:@"?"];
    NSString *fitString = [self substringWithRange: NSMakeRange(0, range.location)];
    return fitString;
}

- (NSString *)fitToHeaderPicURL {

    NSRange range = [self rangeOfString:@"{mode}/w/{width}/h/{height}"];
    NSString *replaceString = @"2/w/640/h/300";
    NSString *fitString = [self stringByReplacingCharactersInRange:range withString:replaceString];
    return fitString;
}

- (NSString *)fitToSubPicURL {

    NSRange range = [self rangeOfString:@"{mode}/w/{width}/h/{height}"];
    NSString *replaceString = @"1/w/187/h/187";
    NSString *fitString = [self stringByReplacingCharactersInRange:range withString:replaceString];
    return fitString;
}

@end
