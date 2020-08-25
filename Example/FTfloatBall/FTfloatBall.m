//
//  FTfloatBall.m
//  FTfloatBall
//
//  Created by ymac on 30/07/2020.
//  Copyright © 2020 xxx. All rights reserved.
//

#import "FTfloatBall.h"

#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

static FTfloatBall *_floatBall = nil;

@interface FTfloatBall ()

@property (nonatomic, strong) UIButton *baseButton;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) NSMutableArray *buttonArray;
@property (nonatomic, assign) float buttonWidth;
@property (nonatomic, strong) UIPanGestureRecognizer *pan;

@end

@implementation FTfloatBall

+ (instancetype)getFloatBall
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _floatBall = [[FTfloatBall alloc] init];
    });
    return _floatBall;
}

- (void)setButtonArray:(NSMutableArray *)btnArray {
    _buttonArray = btnArray;
    _contentView.frame = (CGRect) { 0, 0, self.buttonWidth * (btnArray.count + 1), self.buttonWidth };
    for (UIButton *btn in self.buttonArray) {
        btn.alpha = 0;
        [btn addTarget:self action:@selector(btnOnclick:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView addSubview:btn];
    }
}

- (void)btnOnclick:(UIButton *)sender {
    [self ShowHiddenOnclick:_baseButton];
    if (self.clickBolcks) {
        self.clickBolcks(sender.tag);
    }
}

- (void)initWithFrame:(CGRect)frame baseImage:(NSString *)imageName
{
    [self setFrame:frame];
    self.buttonWidth = frame.size.width;
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:(CGRect) { 0, 0, self.buttonWidth, self.buttonWidth }];
        _contentView.alpha = 0;
        _contentView.userInteractionEnabled = YES;
        [self addSubview:_contentView];

        _baseButton =  [UIButton buttonWithType:UIButtonTypeCustom];
        [_baseButton setFrame:(CGRect) { 0, 0, self.buttonWidth, self.buttonWidth }];
        [_baseButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [_baseButton addTarget:self action:@selector(ShowHiddenOnclick:) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:_baseButton];

        _pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(changeLocation:)];
        _pan.delaysTouchesBegan = YES;
        [self addGestureRecognizer:_pan];
    }
}

#pragma mark - gestures response
- (void)changeLocation:(UIPanGestureRecognizer *)p
{
    UIWindow *appWindow = [[UIApplication sharedApplication] windows][0];
    CGPoint panPoint = [p locationInView:appWindow];
    //透明度
    if (p.state == UIGestureRecognizerStateBegan) {
        self.alpha = 1;
    } else if (p.state == UIGestureRecognizerStateEnded) {
        self.alpha = 0.5;
    }

    if (p.state == UIGestureRecognizerStateChanged) {
        self.center = CGPointMake(panPoint.x, panPoint.y);
    } else if (p.state == UIGestureRecognizerStateEnded) {
        CGFloat left = fabs(panPoint.x);
        CGFloat right = fabs(kScreenWidth - left);

        CGFloat minSpace = MIN(left, right);
        CGRect newFrame;

        if (minSpace == left) {
            newFrame = CGRectMake(-self.buttonWidth / 2, panPoint.y - self.frame.size.height / 2, self.frame.size.width, self.frame.size.height);
        } else {
            newFrame = CGRectMake(kScreenWidth - self.buttonWidth / 2, panPoint.y - self.frame.size.height / 2, self.frame.size.width, self.frame.size.height);
        }

        [UIView animateWithDuration:0.25 animations:^{
            self.frame = newFrame;
        }];
    }
}

#pragma mark ------- click baseButton  --------------------
- (void)ShowHiddenOnclick:(UIButton *)btn {
    if (btn.selected == YES) {
        btn.selected = NO;
        [self btnHidden];
    } else {
        btn.selected = YES;
        [self btnShow];
    }
}

- (void)btnHidden {
    self.contentView.alpha = 0;
    int i = 1;
    for (UIButton *btn in self.buttonArray) {
         [btn setCenter:CGPointMake(btn.center.x - self.buttonWidth * i - 2, btn.center.y) ];
        i++;
    }
    [UIView animateWithDuration:0.25 animations:^{
        for (UIButton *btn in self.buttonArray) {
            btn.alpha = 0;
        }
        if (self.center.x <= kScreenWidth / 2) {
            [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.buttonWidth, self.buttonWidth)];
        } else {
            self.baseButton.frame = CGRectMake(0, 0, self.buttonWidth, self.buttonWidth);
            [self setFrame:CGRectMake(kScreenWidth - self.buttonWidth, self.frame.origin.y, self.buttonWidth, self.buttonWidth)];
        }
    } completion:^(BOOL finished) {
    }];

    if (_pan) {
        [self addGestureRecognizer:_pan];
    }
    [self performSelector:@selector(autoMove) withObject:nil afterDelay:3];
}

- (void)btnShow {
    self.alpha = 1;
    if (self.center.x <= kScreenWidth / 2) {
        [self resetContentview];
        [self setFrame:CGRectMake(0, self.frame.origin.y, _baseButton.frame.size.width + self.buttonWidth * self.buttonArray.count, self.buttonWidth)];
    } else {
        [self moveContentview];
        self.baseButton.frame = CGRectMake(self.buttonArray.count * self.buttonWidth, 0, self.buttonWidth, self.buttonWidth);
        [self setFrame:CGRectMake(kScreenWidth - (_baseButton.frame.size.width + self.buttonWidth * self.buttonArray.count), self.frame.origin.y, _baseButton.frame.size.width + self.buttonWidth * self.buttonArray.count, self.buttonWidth)];
    }
    int i = 1;
    for (UIButton *btn in self.buttonArray) {
        [btn setCenter:CGPointMake(self.buttonWidth * i + btn.center.x + 2, self.baseButton.center.y) ];
        i++;
    }

    self.contentView.alpha = 1;
    [UIView animateWithDuration:0.25 animations:^{
        for (UIButton *btn in self.buttonArray) {
            btn.alpha = 1;
        }
    }];

    if (_pan) {
        [self removeGestureRecognizer:_pan];
    }
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(autoMove) object:nil];
}

- (void)autoMove
{
    [UIView animateWithDuration:1.0 animations:^{
        self.alpha = 0.5;
    }];
    [UIView animateWithDuration:0.5 animations:^{
        CGFloat x = self.center.x < kScreenWidth / 2 ? 0 : kScreenWidth;
        CGFloat y = self.center.y;

        self.center = CGPointMake(x, y);
    }];
}

#pragma mark ------- contentview  --------------------
//当按钮在屏幕右边时，将contentview移动到左边
- (void)moveContentview {
    _contentView.frame = (CGRect) { -self.buttonWidth, 0, _contentView.frame.size.width, _contentView.frame.size.height };
}

//恢复到默认位置
- (void)resetContentview {
    _contentView.frame = (CGRect) { 0, 0, _contentView.frame.size.width, _contentView.frame.size.height };
}

- (void)show
{
    self.hidden = NO;
}

- (void)hide
{
    self.hidden = YES;
}

@end
