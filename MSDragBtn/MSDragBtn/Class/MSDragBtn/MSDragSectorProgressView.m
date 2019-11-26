//
//  MSDragSectorProgressView.m
//  MSDragBtn
//
//  Created by peng zhao on 2019/11/26.
//  Copyright © 2019 Mars. All rights reserved.
//

#import "MSDragSectorProgressView.h"

@implementation MSDragSectorProgressView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
  //    定义扇形中心
      CGPoint origin = CGPointMake(40, 40);
  //    定义扇形半径
      CGFloat radius = 40.0f;
  //    设定扇形起点位置
      CGFloat startAngle = - M_PI_2;
  //    根据进度计算扇形结束位置
      CGFloat endAngle = startAngle + self.progress * M_PI * 2;
      
  //    根据起始点、原点、半径绘制弧线
      UIBezierPath *sectorPath = [UIBezierPath bezierPathWithArcCenter:origin radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
      
  //    从弧线结束为止绘制一条线段到圆心。这样系统会自动闭合图形，绘制一条从圆心到弧线起点的线段。
      [sectorPath addLineToPoint:origin];
      
  //    设置扇形的填充颜色
      [[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3] set];
      
  //    设置扇形的填充模式
      [sectorPath fill];
}
- (void)setProgress:(CGFloat)progress{
    _progress = progress;
 
    
    if (_progress >= 1.0) {
        _progress = 0;
        self.hidden = YES;
    }else{
        self.hidden = NO;
         //    赋值结束之后要刷新UI，不然看不到扇形的变化
         [self setNeedsDisplay];
    }
    
}
@end
