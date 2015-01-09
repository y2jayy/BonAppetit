//
//  CameraViewController.m
//  BonAppetit
//
//  Created by Jay Yoon on 12/27/14.
//  Copyright (c) 2014 Jay Yoon. All rights reserved.
//

#import "CameraViewController.h"
#import "ASStarRatingView.h"
#import <AudioToolbox/AudioToolbox.h>

@interface CameraViewController ()

@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
    
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"Device has no camera"
                                                        delegate:nil
                                                        cancelButtonTitle:@"OK"
                                                        otherButtonTitles: nil];
        
        [myAlertView show];
        
    }
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

- (IBAction)takePhoto:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)selectPhoto:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    //testing
    ASStarRatingView *staticStarRatingView = [[ASStarRatingView alloc] init];
    staticStarRatingView.canEdit = YES;
    staticStarRatingView.maxRating = 5;
    staticStarRatingView.rating = 3;
    staticStarRatingView.frame = CGRectMake(32, 100, 256, 128);
    [self.view addSubview:staticStarRatingView];
    //testing
    
    //testing
    UIButton *confirmRatingButton = [[UIButton alloc] initWithFrame:CGRectMake(120, 200, 80, 40)];
    [confirmRatingButton setTitle:@"Rate!" forState:UIControlStateNormal];
    [confirmRatingButton setBackgroundColor:[UIColor greenColor]];
    [confirmRatingButton addTarget:self action:@selector(saveRating) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:confirmRatingButton];
    //testing
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)saveRating {
    AudioServicesPlaySystemSound(1001);
}

@end
