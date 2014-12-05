//
//  ASDateFormatter.m
//  Assetee
//
//  Created by Wu Di on 12/5/14.
//  Copyright (c) 2014 吴迪（子回）. All rights reserved.
//

#import "ASDateFormatter.h"

@implementation ASDateFormatter

+(NSDateFormatter *)zhDateFormatter {
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!dateFormatter) {
            dateFormatter = [[NSDateFormatter alloc] init];
            dateFormatter.timeStyle = NSDateFormatterNoStyle;
            dateFormatter.dateStyle = NSDateFormatterMediumStyle;
            NSLocale *zhLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh"];
            [dateFormatter setLocale:zhLocale];
        }
    });
    return dateFormatter;
}

@end
