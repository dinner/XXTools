//
//  tv_inScroll.m
//  tf_inScrollView
//
//  Created by zhanglingxiang on 16/4/21.
//  Copyright (c) 2016年 zhanglingxiang. All rights reserved.
//

#import "tv_inScroll.h"

@implementation tv_inScroll

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
        
        [center addObserver:self
                   selector:@selector(handleKeyboardWillShow:)
                       name:UIKeyboardWillShowNotification
                     object:nil];
        [center addObserver:self
                   selector:@selector(handleKeyboardWillHide:)
                       name:UIKeyboardWillHideNotification
                     object:nil];
        
        UIToolbar* toolBar = [tv_inScroll getToolBar];
        self.inputAccessoryView = toolBar;
    }
    return self;
}

+(UIToolbar*)getToolBar{
    UIToolbar * topView = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    [topView setBarStyle:UIBarStyleBlack];
    
    UIBarButtonItem * btnSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(dismissKeyBoard)];
    NSArray * buttonsArray = [NSArray arrayWithObjects:btnSpace,doneButton,nil];
    [topView setItems:buttonsArray];
    return topView;
}

-(void)handleKeyboardWillShow:(NSNotification*)not{
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat height = CGRectGetHeight([UIScreen mainScreen].bounds);
    
    NSDictionary* userDic = not.userInfo;
    CGSize kbSize=[[userDic objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    CGFloat kbHeight = kbSize.height+40;
    
    CGFloat ptOffsetY = _scroll.contentOffset.y;
    CGFloat textFY = CGRectGetMaxY(self.frame);
    CGFloat keyboradY = height -64.f - kbHeight + (ptOffsetY-(-64.f));

    NSLog(@"%f  %f",textFY,keyboradY);
    if (textFY > keyboradY) {
        self.frame = CGRectMake(0, keyboradY-textFY, width, self.frame.size.height);
    }
}
-(void)handleKeyboardWillHide:(NSNotification*)not{
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    self.frame = CGRectMake(0, 0, width, self.frame.size.height);
}

-(void)setScroll:(UIScrollView *)scroll{
    _scroll = scroll;
}

-(void)dismissKeyBoard{
    [self resignFirstResponder];
    [_scroll setFrame:CGRectMake(0, 0, _scroll.bounds.size.width,  _scroll.bounds.size.height)];
}


@end
