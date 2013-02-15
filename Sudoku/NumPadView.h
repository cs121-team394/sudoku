//
//  NumPadView.h
//  Sudoku
//
//  Created by Greg Kronmiller on 2/13/13.
//  Copyright (c) 2013 Evan Gaebler, Greg Kronmiller, Linnea Shin, and Michelle Chesley. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NumPadView : UIView
{
    NSMutableArray* buttons;
}

@property (readonly) char selectedDigit;

@end
