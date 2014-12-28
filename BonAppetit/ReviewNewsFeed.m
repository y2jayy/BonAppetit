//
//  ReviewNewsFeed.m
//  BonAppetit
//
//  Created by Jay Yoon on 12/27/14.
//  Copyright (c) 2014 Jay Yoon. All rights reserved.
//

#import "ReviewNewsFeed.h"
#import "StrechyParallaxScrollView.h"

@interface ReviewNewsFeed ()

@end

@implementation ReviewNewsFeed

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //create the top view
    UIView *topView = [UIView new]; 

    //create scroll view with top view just created
    StrechyParallaxScrollView *strechy = [[StrechyParallaxScrollView alloc] initWithFrame:self.view.frame andTopView:topView]; 

    //add it to your controllers view
    [self.view addSubview:strechy];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
