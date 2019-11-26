//
//  MSDragButton.m
//  MSDragBtn
//
//  Created by peng zhao on 2019/11/26.
//  Copyright © 2019 Mars. All rights reserved.
//

#import "MSDragButton.h"


@implementation MSDragButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
        
        _progressView = [[MSDragSectorProgressView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];

        [self addSubview:_progressView];
        
        //滑动手势
           UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
           [self addGestureRecognizer:pan];
        
        [self performSelector:@selector(pudataProgress) withObject:nil afterDelay:1];
        
    }
    return self;
}

/// 刷新进度条
- (void)pudataProgress{
    _progressView.progress += 0.01;
     [self performSelector:@selector(pudataProgress) withObject:nil afterDelay:0.1];
}
/// 平移 手势回调
- (void)handlePan:(UIPanGestureRecognizer*)sender {
    if(sender.state == UIGestureRecognizerStateChanged){
         {
          CGPoint translation = [sender translationInView:[self superview]];

          CGFloat newXOrigin = CGRectGetMinX(self.frame) + translation.x;
          CGFloat newYOrigin = CGRectGetMinY(self.frame) + translation.y;

          CGRect cagingArea = self.cagingArea;

          CGFloat cagingAreaOriginX = CGRectGetMinX(cagingArea);
          CGFloat cagingAreaOriginY = CGRectGetMinY(cagingArea);

          CGFloat cagingAreaRightSide = cagingAreaOriginX + CGRectGetWidth(cagingArea);
          CGFloat cagingAreaBottomSide = cagingAreaOriginY + CGRectGetHeight(cagingArea);

          if (!CGRectEqualToRect(cagingArea, CGRectZero)) {
              if (newXOrigin <= cagingAreaOriginX ||
                  newXOrigin + CGRectGetWidth(self.frame) >= cagingAreaRightSide) {
                  newXOrigin = CGRectGetMinX(self.frame);
              }
              if(newYOrigin <= cagingAreaOriginY ||
                 newYOrigin + CGRectGetHeight(self.frame) >= cagingAreaBottomSide) {
                  newYOrigin = CGRectGetMinY(self.frame);
              }
          }
             self.frame = CGRectMake(newXOrigin,
                                        newYOrigin,
                                        CGRectGetWidth(self.frame),
                                        CGRectGetHeight(self.frame));

                [sender setTranslation:(CGPoint){0, 0} inView:[self superview]];
                  
         }
    
    }else if (sender.state == UIGestureRecognizerStateEnded){
        
        CGSize dragBtnSize = self.frame.size;
        CGFloat dragBtn_Y = CGRectGetMinY(self.frame);
        CGFloat dragBtn_X = 0;
        CGFloat  duration = 0.7;//默认时间
        //计算出按钮距离边界的差 用作动画时间的计算
        CGFloat difference = 1.0;
        switch (_remainStyle) {
            case MSDragButtonRemainStyleNone:
                return;
            case MSDragButtonRemainStyleAutomaticMargin:
            {
                if (self.center.x >= self.cagingArea.size.width / 2.0) {
                   //右
                    dragBtn_X = self.cagingArea.size.width - dragBtnSize.width;
                    difference =   (self.cagingArea.size.width - CGRectGetMaxX(self.frame)) /  self.cagingArea.size.width;
                }else{
                    //左
                    dragBtn_X = 0;
                    difference =   CGRectGetMidX(self.frame) /  self.cagingArea.size.width;
                }
            }
                break;
            case MSDragButtonRemainStyleAutomaticMarginLeft:
                dragBtn_X = 0;
                difference =   CGRectGetMidX(self.frame) /  self.cagingArea.size.width;
                break;
            case MSDragButtonRemainStyleAutomaticMarginRight:
                
               dragBtn_X = self.cagingArea.size.width - dragBtnSize.width;
                difference =   (self.cagingArea.size.width - CGRectGetMaxX(self.frame)) /  self.cagingArea.size.width;
                break;
            default:
                break;
        }
        //距离越近。动画时间就越短
        duration  = duration * difference;
        [UIView animateWithDuration:duration animations:^{
            self.frame = CGRectMake(dragBtn_X, dragBtn_Y, dragBtnSize.width, dragBtnSize.height);
        }];
    }
}


@end
