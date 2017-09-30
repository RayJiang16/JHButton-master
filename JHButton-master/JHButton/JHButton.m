//
//  JHButton.m
//  BTButton
//
//  Created by RayJiang on 2017/9/27.
//  Copyright © 2017年 hzchengshan. All rights reserved.
//

#import "JHButton.h"
#import "UIView+JHExtension.h"
#import "MMMaterialDesignSpinner.h"

@interface JHButton ()
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) MMMaterialDesignSpinner *spinnerView;

@end

@implementation JHButton

/** 停止动画后 x(1.2)秒 改成Normal状态 */
const NSTimeInterval duration = 1.2f;

#pragma mark - Init

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initControl];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initControl];
    }
    return self;
}

- (void)initControl {
    _normalColor = [UIColor colorWithRed:51/255.0 green:175/255.0 blue:1 alpha:1];
    _errorColor  = [UIColor redColor];
    _enableWhenAnimating = NO;
    
    _bgView = [[UIView alloc] initWithFrame:self.bounds];
    _bgView.backgroundColor = _normalColor;
    _bgView.layer.cornerRadius = self.height * 0.5;
    _bgView.layer.bounds = self.bounds;
    _bgView.userInteractionEnabled = NO;
    [self addSubview:_bgView];
    
    _spinnerView = [[MMMaterialDesignSpinner alloc] initWithFrame:CGRectZero];
    _spinnerView.bounds = CGRectMake(0, 0, self.height * 0.8, self.height * 0.8);
    _spinnerView.lineWidth = 2;
    _spinnerView.tintColor = [UIColor whiteColor];
    _spinnerView.center = CGPointMake(CGRectGetMidX(self.layer.bounds), CGRectGetMidY(self.layer.bounds));
    _spinnerView.userInteractionEnabled = NO;
    [self addSubview:_spinnerView];
    
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:15];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (!_isAnimating) {
        _bgView.frame = self.bounds;
        _bgView.layer.cornerRadius = self.height * 0.5;
        _bgView.userInteractionEnabled = NO;
        _spinnerView.frame = CGRectMake(0, 0, self.height * 0.8, self.height * 0.8);
        _spinnerView.center = CGPointMake(CGRectGetMidX(self.layer.bounds), CGRectGetMidY(self.layer.bounds));
        _spinnerView.userInteractionEnabled = NO;
    }
}

#pragma mark - Public function

- (void)startAnimation {
    if (_isAnimating) {
        return;
    }
    if (!self.normalText) {
        self.normalText = self.titleLabel.text;
    }
    
    _isAnimating = YES;
    self.spinnerView.hidden = NO;
    self.userInteractionEnabled = _enableWhenAnimating;
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.bgView.layer.bounds = CGRectMake(0, 0, self.height, self.height);
        [self setTitle:@"" forState:UIControlStateNormal];
    } completion:^(BOOL finished) {
        [self.spinnerView startAnimating];
    }];
}

- (void)stopAnimation {
    [self p_stopAnimationWithtext:nil error:NO];
}

- (void)stopAnimationWithText:(NSString *)text {
    [self p_stopAnimationWithtext:text error:NO];
}

- (void)stopAnimationWithErrorText:(NSString *)text {
    [self p_stopAnimationWithtext:text error:YES];
}

#pragma mark - Setter

- (void)setNormalText:(NSString *)normalText {
    _normalText = normalText;
    [self setTitle:normalText forState:UIControlStateNormal];
}

- (void)setNormalColor:(UIColor *)normalColor {
    _normalColor = normalColor;
    self.bgView.backgroundColor = normalColor;
}

- (void)setErrorColor:(UIColor *)errorColor {
    _errorColor = errorColor;
}

#pragma mark - Private function

- (void)p_stopAnimationWithtext:(NSString *)text error:(BOOL)error {
    if (!_isAnimating) {
        return;
    }
    
    if (text) {
        [self setTitle:text forState:UIControlStateNormal];
    }
    if (error) {
        self.bgView.backgroundColor = self.errorColor;
        [self shake];
    }
    
    [self.spinnerView stopAnimating];
    self.spinnerView.hidden = YES;
    self.userInteractionEnabled = YES;
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.bgView.layer.bounds = CGRectMake(0, 0, self.width, self.height);
        [self setTitle:(text ? text : self.normalText) forState:UIControlStateNormal];
    } completion:^(BOOL finished) {
        
        if (text || error) {
            [UIView animateWithDuration:0.8 delay:duration options:UIViewAnimationOptionCurveLinear animations:^{
                self.bgView.backgroundColor = self.normalColor;
                self.bgView.alpha = self.bgView.alpha == 1 ? 0.99f : 1;
            } completion:^(BOOL finished) {
                [self setTitle:self.normalText forState:UIControlStateNormal];
                _isAnimating = NO;
            }];
        } else {
            _isAnimating = NO;
        }
    }];
}

- (void)shake {
    CAKeyframeAnimation *kfa = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    CGFloat s = 16;
    kfa.values = @[@(-s),@(0),@(s),@(0),@(-s),@(0),@(s),@(0)];
    kfa.duration = 0.1f;
    kfa.repeatCount = 2;
    kfa.removedOnCompletion = YES;
    [self.layer addAnimation:kfa forKey:@"shake"];
}

@end
