//
//  tf_inScroll.m
//  tf_inScrollView
//
//  Created by zhanglingxiang on 16/4/21.
//  Copyright (c) 2016年 zhanglingxiang. All rights reserved.
//

#import "tf_inScroll.h"
#define KEYBORAD_HEIGHT 216
#define NAV_HEIGHT      64

@implementation tf_inScroll

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
        self.delegate = self;
    }
    return self;
}

-(void)setScrollView:(UIScrollView *)scrollView{
    _scrollView = scrollView;
    [_scrollView setUserInteractionEnabled:YES];
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollClicked)];
    [_scrollView addGestureRecognizer:tap];
}

-(void)scrollClicked{
    [self resignFirstResponder];
    [_scrollView setContentOffset:CGPointMake(0, 0)];
}

#pragma mark uitextfieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat height = CGRectGetHeight([UIScreen mainScreen].bounds);
    self.scrollView.contentSize = CGSizeMake(width,height + KEYBORAD_HEIGHT);//原始滑动距离增加键盘高度
    CGPoint pt = [textField convertPoint:CGPointMake(0, 0) toView:_scrollView];//把当前的textField的坐标映射到scrollview上
    if(_scrollView.contentOffset.y-pt.y + NAV_HEIGHT <= 0)//判断最上面不要去滚动
        [_scrollView setContentOffset:CGPointMake(0, pt.y - NAV_HEIGHT) animated:YES];
    return YES;
}


@end
