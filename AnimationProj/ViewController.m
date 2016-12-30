//
//  ViewController.m
//  AnimationProj
//
//  Created by 余钦 on 16/5/26.
//  Copyright © 2016年 yuqin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic, strong)UILabel  *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self SetupLayer];
}


- (void)SetupLayer{
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(150, 20, 100, 30)];
    label.text = @"哈哈哈";
    label.font = [UIFont boldSystemFontOfSize:12];
    label.textColor = [UIColor redColor];
    [self.view addSubview:label];
    _label = label;
    [_label.layer addAnimation:[self SetupGroupAnimation] forKey:@"scale"];
}

/**
 *  心跳
 */
- (CAAnimation *)SetupScaleAnimation
{
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.duration = 3.0;
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    scaleAnimation.toValue = [NSNumber numberWithFloat:3.0];
    scaleAnimation.repeatCount = MAXFLOAT;
    scaleAnimation.autoreverses = YES;
    scaleAnimation.fillMode = kCAFillModeForwards;
    scaleAnimation.removedOnCompletion = NO;
    
    return scaleAnimation;
}

/**
 *  上下移动
 */
- (CAAnimation *)SetupMoveAnimation
{
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.fromValue = [NSValue valueWithCGPoint:_label.layer.position];
    moveAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(_label.layer.position.x, 667-60)];
    moveAnimation.autoreverses = YES;
    moveAnimation.duration = 3.0;
    return moveAnimation;
}

/**
 *  翻转
 */
- (CAAnimation *)SetupRotationAnimation
{
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
    rotationAnimation.duration = 1.5;
    rotationAnimation.autoreverses = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    rotationAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    rotationAnimation.toValue = [NSNumber numberWithFloat:2 * M_PI];
    rotationAnimation.fillMode = kCAFillModeBoth;
    return rotationAnimation;
}

/**
 *  移动放大翻转
 */
- (CAAnimation *)SetupGroupAnimation
{
    CAAnimationGroup *groupAnimation = [CAAnimationGroup animation];
    groupAnimation.duration = 3.0;
    groupAnimation.animations = @[[self SetupScaleAnimation], [self SetupMoveAnimation], [self SetupRotationAnimation]];
    groupAnimation.autoreverses = YES;
    groupAnimation.repeatCount = MAXFLOAT;
    return groupAnimation;
}

/**
 *  闪烁
 */
- (CABasicAnimation *)SetupOpacityAnimation
{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    
    animation.fromValue = [NSNumber numberWithFloat:1.0];
    
    animation.toValue = [NSNumber numberWithFloat:0.0];
    
    animation.autoreverses = YES;
    
    animation.duration = 0.3;
    
    animation.repeatCount = FLT_MAX;
    
    animation.removedOnCompletion = NO;
    
    animation.fillMode = kCAFillModeForwards;
    
    return animation;
}

/**
 *  有闪烁次数的动画
 */
- (CABasicAnimation *)opacityTimes_Animation:(float)repeatTimes durTimes:(float)time
{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    
    animation.fromValue=[NSNumber numberWithFloat:1.0];
    
    animation.toValue=[NSNumber numberWithFloat:0.4];
    
    animation.repeatCount=repeatTimes;
    
    animation.duration=time;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    animation.autoreverses=YES;
    
    return  animation;
    
}

/**
 *  横向移动
 */
- (CABasicAnimation *)moveX:(float)time X:(NSNumber *)x //横向移动
{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    
    animation.toValue=x;
    
    animation.duration=time;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    return animation;
    
}


/**
 *  纵向移动
 */
- (CABasicAnimation *)moveY:(float)time Y:(NSNumber *)y //纵向移动

{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    
    animation.toValue=y;
    
    animation.duration=time;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    return animation;
    
}


/**
 *  缩放
 */
- (CABasicAnimation *)scale:(NSNumber *)Multiple orgin:(NSNumber *)orginMultiple durTimes:(float)time Rep:(float)repeatTimes
{
    
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    animation.fromValue=orginMultiple;
    
    animation.toValue=Multiple;
    
    animation.duration=time;
    
    animation.autoreverses=YES;
    
    animation.repeatCount=repeatTimes;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    return animation;
    
}


/**
 * 组合动画
 */
- (CAAnimationGroup *)groupAnimation:(NSArray *)animationAry durTimes:(float)time Rep:(float)repeatTimes

{
    
    CAAnimationGroup *animation=[CAAnimationGroup animation];
    
    animation.animations=animationAry;
    
    animation.duration=time;
    
    animation.repeatCount=repeatTimes;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    return animation;
    
}


/**
 *  路径动画
 */
- (CAKeyframeAnimation *)keyframeAniamtion:(CGMutablePathRef)path durTimes:(float)time Rep:(float)repeatTimes
{
    
    CAKeyframeAnimation *animation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    animation.path=path;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    
    animation.autoreverses=NO;
    
    animation.duration=time;
    
    animation.repeatCount=repeatTimes;
    
    return animation;
    
}


/**
 *  点移动
 */
- (CABasicAnimation *)movepoint:(CGPoint )point
{
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.translation"];
    
    animation.toValue=[NSValue valueWithCGPoint:point];
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    return animation;
}


/**
 *  旋转
 */
- (CABasicAnimation *)rotation:(float)dur degree:(float)degree direction:(int)direction repeatCount:(int)repeatCount
{
    CATransform3D rotationTransform  = CATransform3DMakeRotation(degree, 0, 0,direction);
    
    CABasicAnimation* animation;
    
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    animation.toValue= [NSValue valueWithCATransform3D:rotationTransform];
    
    animation.duration= dur;
    
    animation.autoreverses= NO;
    
    animation.cumulative= YES;
    
    animation.removedOnCompletion=NO;
    
    animation.fillMode=kCAFillModeForwards;
    
    animation.repeatCount= repeatCount; 
    
    animation.delegate= self;
    
    return animation;
}

@end
