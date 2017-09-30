//
//  JHButton.h
//  BTButton
//
//  Created by RayJiang on 2017/9/27.
//  Copyright © 2017年 hzchengshan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHButton : UIButton

/** 是否在执行动画 */
@property (nonatomic, assign, readonly) BOOL isAnimating;
/** normal状态下的文本 */
@property (nonatomic, strong) NSString *normalText;
/** normal状态下的背景颜色 */
@property (nonatomic, strong) UIColor *normalColor;
/** error状态下的背景颜色 */
@property (nonatomic, strong) UIColor *errorColor;
/** 在动画状态下，允许按钮被点击  默认:false 不建议开启 */
@property (nonatomic, assign) BOOL enableWhenAnimating;

/**
 * 开始动画
 */
- (void)startAnimation;

/**
 * 停止动画
 */
- (void)stopAnimation;

/**
 * 停止动画
 *
 * @param text 停止动画后展示的文本  1.2秒后变回normalText
 */
- (void)stopAnimationWithText:(NSString *)text;

/**
 * 停止动画 - 展示Error状态
 *
 * @param text 停止动画后展示的文本  1.2秒后变回normalText
 */
- (void)stopAnimationWithErrorText:(NSString *)text;

@end
