//
//  CellView.m
//  Sudoku
//
//  Created by Greg Kronmiller on 2/13/13.
//  Copyright (c) 2013 Evan Gaebler, Greg Kronmiller, Linnea Shin, and Michelle Chesley. All rights reserved.
//

#import "CellView.h"
#import <QuartzCore/QuartzCore.h>

@implementation CellView

-(id) initWithFrame : (CGRect)frame Row: (int)r Column: (int)c BackgroundColor: (UIColor*)bgColor
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // Initialization code
        _row = r;
        _column = c;
        self.backgroundColor = bgColor;
        target = nil;
        message = nil;
        
        CGRect subframe = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        
        button = [[UIButton alloc] initWithFrame: subframe];
        
        // set the appearance of the button
        [self unhighlight];
        
        [[button layer] setBackgroundColor: [UIColor whiteColor].CGColor];
        //        [[button layer] setCornerRadius: 8];
        [self markAsImmutable];
        int fontSize = MIN(frame.size.width, frame.size.height) * 0.9;
        button.titleLabel.font = [UIFont fontWithName: @"Helvetica" size: fontSize];
        
        [self addSubview: button];
        [button addTarget: self action: @selector(buttonPressed:) forControlEvents: UIControlEventTouchUpInside];
    }
    return self;
}

-(void) unhighlight
{
    [[button layer] setBorderWidth: 1];
    [[button layer] setBorderColor: self.backgroundColor.CGColor];
}
-(void) highlight
{
    [[button layer] setBorderWidth: 6];
    [[button layer] setBorderColor: [UIColor cyanColor].CGColor];
}

-(void) markAsMutable
{
    [button setTitleColor: [UIColor blueColor] forState: UIControlStateNormal];
}

-(void) markAsImmutable
{
    [button setTitleColor: [UIColor blackColor] forState: UIControlStateNormal];
}

-(void) setValue: (char)value
{
    [button setTitle: [[NSString alloc] initWithFormat: @"%c", value] forState: UIControlStateNormal];
}

-(void) setTarget: (id)sender action: (SEL)action
{
    target = sender;
    message = action;
}

-(void) buttonPressed: (id)sender
{
    if (target != nil && message != nil) {
        [target performSelector: message withObject: self];
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
