//
//  FTfloatBall.h
//  FTfloatBall
//
//  Created by ymac on 30/07/2020.
//  Copyright © 2020 xxx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FTfloatBall : UIView

@property (nonatomic, copy) void (^ clickBolcks)(NSInteger i);

+ (instancetype)getFloatBall;

//frame:长宽须相等
- (void)initWithFrame:(CGRect)frame baseImage:(NSString *)imageName;

- (void)setButtonArray:(NSMutableArray *)btnArray;

// 显示
- (void)show;

// 隐藏
- (void)hide;

@end

NS_ASSUME_NONNULL_END
