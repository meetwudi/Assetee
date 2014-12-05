//
//  ASFloatLabeledTextField.m
//  Assetee
//
//  Created by Wu Di on 12/5/14.
//  Copyright (c) 2014 吴迪（子回）. All rights reserved.
//

#import "ASFloatLabeledTextField.h"

@implementation ASFloatLabeledTextField

-(void)awakeFromNib {
    [self setupButtomBorder];
}

-(void)setupButtomBorder {
    CGRect frame = CGRectMake(0,
                             self.bounds.origin.y +
                             self.bounds.size.height + 5.0f,
                             self.bounds.size.width,
                              1.0f);
    UIView *bottomBorder = [[UIView alloc]
                            initWithFrame: frame];
    bottomBorder.backgroundColor = [UIColor colorWithRed:200.0/255.0 green:200.0/255.0 blue:200.0/255.0 alpha:1];
    [self addSubview:bottomBorder];
    [self setClipsToBounds:NO];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
