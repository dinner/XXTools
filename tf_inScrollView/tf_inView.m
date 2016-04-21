//
//  tf_inView.m
//  tf_inScrollView
//
//  Created by zhanglingxiang on 16/4/21.
//  Copyright (c) 2016年 zhanglingxiang. All rights reserved.
//

#import "tf_inView.h"
#define KEYBORAD_HEIGHT     216

@implementation tf_inView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    self.delegate = self;
    return self;
}

-(void)setView:(UIView *)view{
    _view = view;
    [view setUserInteractionEnabled:YES];
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(btCli)];
    [view addGestureRecognizer:tap];
}

-(void)btCli{
    [_view setFrame:CGRectMake(0, 0, _view.bounds.size.width, _view.bounds.size.height)];
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat height = CGRectGetHeight([UIScreen mainScreen].bounds);
    
    if (textField.frame.origin.y+textField.frame.size.height > (height - KEYBORAD_HEIGHT)) {
        [self.view setFrame:CGRectMake(0,-(textField.frame.origin.y+textField.frame.size.height-height+KEYBORAD_HEIGHT),CGRectGetWidth(self.view.bounds) , CGRectGetHeight(self.view.bounds))];
    }
    
    return YES;
}


@end
