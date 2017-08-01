//
//  topSelectView.m
//  WonderfulTime
//
//  Created by 朱鹏 on 2017/7/4.
//  Copyright © 2017年 朱鹏. All rights reserved.
//

#import "topSelectView.h"

@interface topSelectView ()<UIScrollViewDelegate>

@property (nonatomic,strong)NSMutableArray *dataArr;
@property (nonatomic,assign)BOOL isOpen;
@property (nonatomic,assign)NSInteger currentWeek;
@property (nonatomic,strong)UIView *ringView;
@property (nonatomic,strong)UIBezierPath *bezier;
@property (nonatomic,strong)CAShapeLayer *bgLayer;

@end

@implementation topSelectView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.scrollView];
        //移动按钮
    
          [self addSubview:self.moveBtn];
    }
    return self;
}

//按钮的点击效果
-(void)selectBtnAction:(UIButton *)sender{
    
    CGFloat one_with = self.frame.size.width/5.0f;
    NSInteger number = sender.tag - 153400;
    [self.scrollView setContentOffset:CGPointMake(one_with*number, 0) animated:YES];
    
}

-(void)setViewWithWeek:(NSInteger)week{
    
    if (self.currentWeek !=week) {
        CGFloat one_with = _scrollView.frame.size.width/5.0f;
        
        CGFloat offset_x = one_with*(week-1);
        [_scrollView setContentOffset:CGPointMake(offset_x, 0) animated:YES];

    }
 }

-(void)moveBtnAction:(UIButton *)sender{
    
    for (int i = 0; i<40; i++) {
        
        UIButton *selectBtn = [self viewWithTag:153400+i];
        if (_isOpen) {
            
            [selectBtn setBackgroundImage:[UIImage imageNamed:@"椭圆-大"] forState:(UIControlStateNormal)];
         }else{
             
            [selectBtn setBackgroundImage:[UIImage imageNamed:@"椭圆-虚"] forState:(UIControlStateNormal)];
       }
}
       _isOpen = !_isOpen;

}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
//    NSLog(@"%f",scrollView.contentOffset.x);
     CGFloat one_with = scrollView.frame.size.width/5.0f;//每一个小球所占的大小
     CGFloat offSet_x = scrollView.contentOffset.x;//滚动视图现在的偏移量
     NSInteger Number = offSet_x/one_with;//第几个区域
     CGFloat  surplus_x = offSet_x-Number*one_with;//在某个小球区间里的偏移量
  //    NSLog(@"第几个区域%ld",Number);
  //    算出每一像素 小球的变化值 (小球的frame的变化量)
     CGFloat sub_x = aScaleH(16.5)/one_with*surplus_x;
     CGFloat sub_y = aScaleH(6)/one_with*surplus_x;
     CGFloat sub_w = aScaleH(33)/one_with*surplus_x;
     CGFloat sub_h = aScaleH(33)/one_with*surplus_x;
//    selectBtn.frame =kRect(Label_W*2+20+i*Label_W, 6, 35, 35);

    //在左边
     UIButton *rightBtn = (UIButton *)[self viewWithTag:153400+Number+1];
    rightBtn.frame = CGRectMake(one_with*2+aScaleW(20)+one_with*(Number+1)-sub_x, aScaleH(6)-sub_y, aScaleW(35)+sub_w, aScaleH(35)+sub_h);
 
    //在右边
    UIButton *leftBtn = (UIButton *)[self viewWithTag:153400+Number];
    leftBtn.frame = CGRectMake(one_with*2+aScaleW(20)+one_with*(Number)-(aScaleH(16.5)-sub_x), aScaleH(6)-(aScaleH(6)-sub_y), aScaleW(35)+( aScaleH(33)-sub_w), aScaleH(35)+(aScaleH(33)-sub_h));
   
    //其他小球回复原大小（防止快速滑动的时候回复不过来）（完美！）
    UIButton *atherRightBtn = (UIButton *)[self viewWithTag:153400+Number+2];
    atherRightBtn.frame =CGRectMake(one_with*2+aScaleW(20)+one_with*(Number+2), aScaleH(6), aScaleW(35), aScaleW(35));
    UIButton *atherleftBtn = (UIButton *)[self viewWithTag:153400+Number-1];
    atherleftBtn.frame =CGRectMake(one_with*2+aScaleW(20)+one_with*(Number-1), aScaleH(6), aScaleW(35), aScaleW(35));
    //滚动的时候拖拽按钮在滚动的时候影藏
    self.moveBtn.hidden = YES;
    [self.moveBtn setTitle:@"" forState:(UIControlStateNormal)];
    
}



//视图停止拖拽
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    CGFloat one_with = scrollView.frame.size.width/5.0f;
    
    CGFloat half_with = one_with/2;
    
    CGFloat offSet_x = scrollView.contentOffset.x;
    //    NSLog(@"停止拖拽-offset_x--%f",offSet_x);
    
//    NSInteger surplus_x = (NSInteger)offSet_x%(NSInteger)one_with;
    
    NSInteger bigNumber = offSet_x/one_with;
    CGFloat  surplus_x = offSet_x-bigNumber*one_with;
//        NSLog(@"剩余---%ld",surplus_x);
    //    判断距离哪个周更近一点
    CGFloat contentOffset_x  = 0 ;
    
    if (decelerate == NO) {//如果没有减速运动
        if (surplus_x >half_with) {
            
            contentOffset_x = offSet_x+(one_with-surplus_x);
            [scrollView setContentOffset:CGPointMake(contentOffset_x, 0) animated:YES];
            
        }else{
            
            contentOffset_x = offSet_x-surplus_x;
            [scrollView setContentOffset:CGPointMake(contentOffset_x, 0) animated:YES];
            
        }
        
    }
    
}
//视图结束减速
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //    NSLog(@"视图停止减速");
    CGFloat one_with = scrollView.frame.size.width/5.0f;
    
    CGFloat half_with = one_with/2;
    
    CGFloat offSet_x = scrollView.contentOffset.x;
    //    NSLog(@"停止拖拽-offset_x--%f",offSet_x);
    
    NSInteger bigNumber = offSet_x/one_with;
    
    CGFloat  surplus_x = offSet_x-bigNumber*one_with;
//        NSLog(@"剩余---%ld",surplus_x);

    //    判断距离哪个周更近一点
    CGFloat contentOffset_x  = 0 ;
    if (offSet_x ==0 || offSet_x >=3229) {
        
        [self changeMoveBtnViewWithWeek:bigNumber+1];

  
    }else if (surplus_x >half_with) {
        
        contentOffset_x = offSet_x+(one_with-surplus_x);
        [scrollView setContentOffset:CGPointMake(contentOffset_x, 0) animated:YES];
        
    }else{
        
        contentOffset_x = offSet_x-surplus_x;
        [scrollView setContentOffset:CGPointMake(contentOffset_x, 0) animated:YES];
        
    }
    
}
//视图结束滚动动画
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
//    [self changeViewAndUpDataWith:scrollView];
    
    CGFloat one_with = scrollView.frame.size.width/5.0f;
    CGFloat offSet_x = scrollView.contentOffset.x+one_with/2.0f;
    NSInteger week = offSet_x/one_with;//第几个区域
    NSLog(@"第%ld个区域",week);
    week = week+1;
    [self changeMoveBtnViewWithWeek:week];
}




-(void)changeMoveBtnViewWithWeek:(NSInteger)week{
    self.currentWeek = week;

    self.moveBtn.hidden = NO;
    if (week<10) {
        [self.moveBtn setTitle:[NSString stringWithFormat:@"0%ld",week] forState:(UIControlStateNormal)];
    }else{
        [self.moveBtn setTitle:[NSString stringWithFormat:@"%ld",week] forState:(UIControlStateNormal)];
    }
    
   //传值
    if ([self.delegate respondsToSelector:@selector(topSelectViewDidSelectWithWeek:)]) {
        [self.delegate topSelectViewDidSelectWithWeek:week];
   
    }
    
    [self drawRingViewInMoveBtnWithWeek:week];
}

-(void)drawRingViewInMoveBtnWithWeek:(NSInteger)week{
    [self.bezier removeAllPoints];
    [self.bgLayer removeFromSuperlayer];
    //第一步，通过UIBezierPath设置圆形的矢量路径
    self.bezier = [UIBezierPath bezierPathWithOvalInRect:kRect(1,1 ,66, 66)];
    CGFloat oneWeek = 1/40.0f;
    //第二步，用CAShapeLayer沿着第一步的路径画一个完整的环（颜色灰色，起始点0，终结点1）
    self.bgLayer = [CAShapeLayer layer];
    _bgLayer.frame = kRect(0, 0, 66, 66);//设置Frame
    _bgLayer.fillColor = [UIColor clearColor].CGColor;//填充颜色=透明色
    _bgLayer.lineWidth = aScaleW(4);//线条大小
    _bgLayer.strokeColor = kMainGreenColor.CGColor;//线条颜色
    _bgLayer.strokeStart =0;//路径开始位置
    _bgLayer.strokeEnd =  oneWeek*week;//路径结束位置
    _bgLayer.path = self.bezier.CGPath;//设置bgLayer的绘制路径为circle的路径
    [self.ringView.layer addSublayer:_bgLayer];//添加到屏幕上
    
}

#pragma mark - 属性的懒加载



-(UIButton *)moveBtn{
    
    if (!_moveBtn) {
        
        _moveBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _moveBtn.frame = kRect(153.5, 0, 68, 68);
        [_moveBtn addTarget:self action:@selector(moveBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [_moveBtn setBackgroundImage:[UIImage imageNamed:@"椭圆-小"] forState:(UIControlStateNormal)];
        [_moveBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        _moveBtn.titleLabel.font = [UIFont boldSystemFontOfSize:aScaleH(19)];
        [_moveBtn setTitle:@"01" forState:(UIControlStateNormal)];
    }
    
    return _moveBtn;
}

-(NSMutableArray *)dataArr{
    
    if (!_dataArr) {
        _dataArr = [[NSMutableArray alloc]init];
        
        for (int i = 1; i<41; i++) {
            NSString *weekStr = @"";
            if (i<10) {
                
                weekStr = [NSString stringWithFormat:@"0%d",i];
                
            }else{
                
                weekStr = [NSString stringWithFormat:@"%d",i];
            }
            
            [_dataArr addObject:weekStr];
            
        }
    }
    
    return _dataArr;
    
}

-(UIScrollView *)scrollView{
    
    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        CGFloat Label_W = 375/5.0f;
        _scrollView.contentSize=CGSizeMake(aScaleW(Label_W)*44, 0);
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        _scrollView.delaysContentTouches = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        for (int i = 0; i<40; i++) {
            UIButton *selectBtn = [UIButton buttonWithType:(UIButtonTypeSystem)];
            selectBtn.frame =kRect(Label_W*2+20+i*Label_W, 6, 35, 35);
            [selectBtn setBackgroundImage:[UIImage imageNamed:@"椭圆-小"] forState:(UIControlStateNormal)];
            [selectBtn addTarget:self action:@selector(selectBtnAction:) forControlEvents:(UIControlEventTouchUpInside)];
            selectBtn.tag = 153400+i;
            [selectBtn setTitle:self.dataArr[i] forState:(UIControlStateNormal)];
            selectBtn.titleLabel.font = [UIFont systemFontOfSize:aScaleH(18)];
            [selectBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
            
            [_scrollView addSubview:selectBtn];
        }
    }
    return _scrollView;
}

-(UILabel *)daylabel{
    
    if (!_daylabel) {
        _daylabel = [[UILabel alloc]initWithFrame:kRect(0, 36, 68, 20)];
        _daylabel.font = [UIFont boldSystemFontOfSize:aScaleH(17)];
        _daylabel.textAlignment = NSTextAlignmentCenter;
        _daylabel.userInteractionEnabled = NO;
        [_moveBtn addSubview:_daylabel];
    }
    
    return _daylabel;
}

-(UIView *)ringView{
    
    if (!_ringView) {
        _ringView = [[UIView alloc]initWithFrame:kRect(0, 0, 68,68)];
        _ringView.userInteractionEnabled = NO;
        CGAffineTransform transform = CGAffineTransformIdentity;
        _ringView.transform = CGAffineTransformRotate(transform, -M_PI / 2);
        [self.moveBtn addSubview:_ringView];
    }
    return _ringView;
}


@end
