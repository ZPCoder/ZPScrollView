//
//  topSelectView.h
//  WonderfulTime
//
//  Created by 朱鹏 on 2017/7/4.
//  Copyright © 2017年 朱鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol topSelectViewDelegate <NSObject>

-(void)topSelectViewDidSelectWithWeek:(NSInteger)week;

@end

@interface topSelectView : UIView

@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UIButton *moveBtn;
@property (nonatomic,assign)id<topSelectViewDelegate>delegate;
@property (nonatomic,strong)UILabel *daylabel;

-(void)setViewWithWeek:(NSInteger)week;

@end
