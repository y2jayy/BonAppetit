//
//  SharePhotoViewController.m
//  BonAppetit
//
//  Created by Jay Yoon on 1/18/15.
//  Copyright (c) 2015 Jay Yoon. All rights reserved.
//

#import "SharePhotoViewController.h"

@interface SharePhotoViewController ()

@property (strong, nonatomic) IBOutlet UITextField *selectedPlaceNameLabel;
@end

@implementation SharePhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.selectedPlaceNameLabel.text = self.placeName;
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
