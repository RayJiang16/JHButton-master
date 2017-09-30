//
//  UIView+JHExtension.h
//  JHTool
//
//  Created by RayJiang on 2017/9/5.
//  Copyright © 2017年 ray. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (JHExtension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign, readonly) CGFloat right;
@property (nonatomic, assign, readonly) CGFloat bottom;

@property (nonatomic, assign) CGSize  size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign, readonly) CGPoint centerPoint;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@end
