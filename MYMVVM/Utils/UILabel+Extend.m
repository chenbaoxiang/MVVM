//
//  UILabel.m
//  Client
//
//  Created by 马永州 on 2018/11/20.
//  Copyright © 2018年 loveRain. All rights reserved.
//

#import "UILabel+Extend.h"

@implementation UILabel(Extend)

-(NSMutableAttributedString *)mutableAttributedString{
    if (self.attributedText){
        return [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    }else{
        return [NSMutableAttributedString new];
    }
}

-(void)append:(NSString *)text color:(UIColor *)color
{
    if (text && color){
        NSMutableAttributedString *mutableAttrString  = [self mutableAttributedString];
        NSAttributedString * attrString = [[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName:color}];
        [mutableAttrString appendAttributedString:attrString];
        [self setAttributedText:mutableAttrString];
    }
}
-(void)append:(NSString *)text color:(UIColor *)color font:(UIFont *)font
{
    if (text && color && font){
        NSMutableAttributedString *mutableAttrString  = [self mutableAttributedString];
        NSAttributedString * attrString = [[NSAttributedString alloc] initWithString:text attributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:font}];
        [mutableAttrString appendAttributedString:attrString];
        [self setAttributedText:mutableAttrString];
    }
}

-(void)appendImage:(NSString *)image size:(CGSize)size
{
    NSMutableAttributedString *mutableAttrString  = [self mutableAttributedString];
    
    NSTextAttachment *attach = [[NSTextAttachment alloc] init];
    attach.image = [UIImage imageNamed:image];
    attach.bounds = CGRectMake(0, 0, size.width, size.height);
    NSAttributedString *attachString = [NSAttributedString attributedStringWithAttachment:attach];
    [mutableAttrString appendAttributedString:attachString];
    [self setAttributedText:mutableAttrString];
}

-(void)setText:(NSString *)text rangeColor:(UIColor *)color range:(NSRange)range
{
    if(text && color){
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
        [attributedString addAttribute:NSForegroundColorAttributeName value:color range:range];
        [self setAttributedText:attributedString];
    }
}

-(void)setTimestamp:(NSInteger)timestamp withTimerStop:(void (^)(void))handle{
    if (timestamp == 0){
        self.text = @"00:00";
    }
    __block NSInteger timeOut = timestamp;
    dispatch_queue_t queue=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER,0, 0, queue);
    //每秒执行一次
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL,0), 1.0 * NSEC_PER_SEC,0);
    dispatch_source_set_event_handler(_timer, ^{
        //倒计时结束，关闭
        if (timeOut == 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                handle();
            });
        } else {
            NSInteger ms = timeOut;
            NSInteger ss = 1;
            NSInteger mi = ss * 60;
            NSInteger hh = mi * 60;
            NSInteger dd = hh * 24;
            
            NSInteger day = ms / dd;// 天
            NSInteger hour = (ms - day * dd) / hh;// 时
            NSInteger minute = (ms - day * dd - hour * hh) / mi;// 分
            NSInteger second = (ms - day * dd - hour * hh - minute * mi) / ss;// 秒
            dispatch_async(dispatch_get_main_queue(), ^{
                self.text = [NSString stringWithFormat:@"%02ld:%02ld",(long)minute,(long)second];
                
            });
            timeOut--;
            
        }
        
    });
    dispatch_resume(_timer);
}
// 自适应 宽高
-(CGSize)returnLabelSize:(NSString *)content boundingRectWithSize:(CGSize)size fontSize:(CGFloat)fontSize{
    // 宽 CGSizeMake(MAXFLOAT, 30)   高 CGSizeMake(label.frame.size.width, MAXFLOAT)
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    
    CGSize retSize = [content boundingRectWithSize:size
                                           options:
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                        attributes:attribute
                                           context:nil].size;
    
    return retSize;
    
}
// 行间距
-(void)setLabelSpaceText:(NSString *)text color:(UIColor *)color withSpace:(CGFloat)space withFont:(UIFont *)font{
    
    if (text && color && space && font){
        NSMutableAttributedString *mutableAttrString  = [self mutableAttributedString];
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
        paraStyle.alignment = NSTextAlignmentLeft;
        paraStyle.lineSpacing = space; //设置行间距
        paraStyle.hyphenationFactor = 1.0;
        paraStyle.firstLineHeadIndent = 0.0;
        paraStyle.paragraphSpacingBefore = 0.0;
        paraStyle.headIndent = 0;
        paraStyle.tailIndent = 0;
        //设置字间距 NSKernAttributeName:@1.5f
        NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.0f,NSForegroundColorAttributeName:color};
        NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:text attributes:dic];
        [mutableAttrString appendAttributedString:attributeStr];
        self.attributedText = attributeStr;
       }
     
}


@end
