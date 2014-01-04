//
//  ViewController.m
//  Expretion
//
//  Created by dingql on 14-1-4.
//  Copyright (c) 2014年 dingql. All rights reserved.
//

#import "ViewController.h"

#define kEmotionWidth   50.0f
#define kEmotionHeight  kEmotionWidth
#define kInterval       5.0f

@interface ViewController ()
@property(nonatomic, assign) NSInteger emotionNum;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UISegmentedControl * segment = [[UISegmentedControl alloc] init];
    segment.frame = CGRectMake(35, 30, 250, 40);
    [segment insertSegmentWithTitle:@"2列" atIndex:0 animated:YES];
    [segment insertSegmentWithTitle:@"3列" atIndex:1 animated:YES];
    [segment insertSegmentWithTitle:@"4列" atIndex:2 animated:YES];
    [segment insertSegmentWithTitle:@"5列" atIndex:3 animated:YES];
    [segment addTarget:self action:@selector(EmotionPosChange:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segment];
    
    [self ShowEmotionWithColumn:2];
}

- (void) EmotionPosChange:(id) sender
{
    if ([sender isMemberOfClass:[UISegmentedControl class]]) {
        UISegmentedControl * segment = (UISegmentedControl *) sender;
        
        [self ShowEmotionWithColumn:(segment.selectedSegmentIndex + 2)];
    }
    
}

- (void) ShowEmotionWithColumn:(NSInteger) column
{
    CGFloat X = (self.view.frame.size.width - column * kEmotionWidth) / (column + 1);
    UISegmentedControl * segment = self.view.subviews[0];
    CGFloat Y = segment.frame.origin.y + segment.frame.size.height + 10;
    
    if (self.view.subviews.count == 1){
        int i = 0;
        for (; i < 9; i ++) {
            UIImageView * imageview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"01%d", i]]];
            imageview.frame = CGRectMake(X + (i % column)*(kEmotionWidth + X), Y + (i / column )*(kEmotionHeight + kInterval), kEmotionWidth, kEmotionHeight);
            [self.view addSubview:imageview];
        }
        UIButton * button = [UIButton buttonWithType:UIButtonTypeContactAdd];
        button.frame = CGRectMake(X + (i % column)*(kEmotionWidth + X), Y + (i / column )*(kEmotionHeight + kInterval), kEmotionWidth, kEmotionHeight);
        [button addTarget:self action:@selector(AddEmotionRadom:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
    }else{
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.3];
        for (int i = 0; i < self.view.subviews.count - 1; i ++) {
            UIView * view = self.view.subviews[i + 1];
            view.frame = CGRectMake(X + (i % column)*(kEmotionWidth + X), Y + (i / column )*(kEmotionHeight + kInterval), kEmotionWidth, kEmotionHeight);
        }
        [UIView commitAnimations];
    }
}

- (void) AddEmotionRadom: (id) sender
{
    // 将增加的表情插到最后一个按钮下面
    UIImageView * imageView = [[UIImageView alloc] init];
    UIButton * button = (UIButton *)sender;
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"01%ld", random() % 9]];
    [self.view insertSubview:imageView belowSubview:button];
    
    // 取得按钮原来位置的frame
    CGRect tmpPos = button.frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    // 增加新表情到按钮原来的位置
    imageView.frame = tmpPos;
    
    // 按钮的计数 + 1，然后根据当前所需要显示的列数，计算出按钮的frame
    int index = self.view.subviews.count - 1;
    UISegmentedControl * segment = self.view.subviews[0];
    int column = segment.selectedSegmentIndex + 2;
    CGFloat X = (self.view.frame.size.width - column * kEmotionWidth) / (column+ 1);
    CGFloat Y = segment.frame.origin.y + segment.frame.size.height + 10;
    
    button.frame = CGRectMake( X + ((index - 1) % column)*(kEmotionWidth + X), Y + ((index - 1) / column)*(kEmotionHeight + kInterval), tmpPos.size.width, tmpPos.size.height);
    
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
