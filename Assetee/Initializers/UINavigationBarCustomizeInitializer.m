//
//  UINavigationBarCustomizeInitializer.m
//  Assetee
//
//  Created by Wu Di on 12/5/14.
//  Copyright (c) 2014 吴迪（子回）. All rights reserved.
//

#import "UINavigationBarCustomizeInitializer.h"
#import <UIKit/UIKit.h>

@implementation UINavigationBarCustomizeInitializer

+(void)execute {
    UINavigationBar *uiNavigationBarAppearance = [UINavigationBar appearance];
    [uiNavigationBarAppearance setBarTintColor:[UIColor colorWithRed:0/255 green:122/255 blue:255/255 alpha:1.0]];
    [uiNavigationBarAppearance setTintColor:[UIColor whiteColor]];
    [uiNavigationBarAppearance setTitleTextAttributes:@ {
        NSForegroundColorAttributeName: [UIColor whiteColor]
    }];
    // Make time, battery and carrier color white.
    [uiNavigationBarAppearance setBarStyle:UIBarStyleBlack];
}

@end
