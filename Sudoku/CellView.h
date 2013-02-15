//
//  CellView.h
//  Sudoku
//
//  Created by Greg Kronmiller on 2/13/13.
//  Copyright (c) 2013 Evan Gaebler, Greg Kronmiller, Linnea Shin, and Michelle Chesley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CellView : UIView
{
    //    UIColor* background;
    UIButton* button;
    
    id target;
    SEL message;
}

@property (readonly) int row;
@property (readonly) int column;

-(id) initWithFrame : (CGRect)frame Row: (int)r Column: (int)c BackgroundColor: (UIColor*)bgColor;

-(void) unhighlight;
-(void) highlight;

-(void) markAsMutable;
-(void) markAsImmutable;

-(void) setValue: (char)value;

-(void) setTarget: (id)sender action: (SEL)action;

@end
