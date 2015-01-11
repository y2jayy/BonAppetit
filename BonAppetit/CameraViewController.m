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
#import <AFHTTPRequestOperation.h>
#import <AFHTTPRequestOperationManager.h>

@interface CameraViewController ()

@property (nonatomic, strong) ASStarRatingView *editableStarRatingView;
@property (nonatomic, strong) UIButton *confirmRatingButton;

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
    [self.editableStarRatingView removeFromSuperview];
    self.editableStarRatingView = [[ASStarRatingView alloc] init];
    self.editableStarRatingView.canEdit = YES;
    self.editableStarRatingView.maxRating = 5;
    self.editableStarRatingView.rating = 3;
    self.editableStarRatingView.frame = CGRectMake(32, 100, 256, 128);
    [self.view addSubview:self.editableStarRatingView];
    //testing
    
    //testing
    [self.confirmRatingButton removeFromSuperview];
    self.confirmRatingButton = [[UIButton alloc] initWithFrame:CGRectMake(120, 200, 80, 40)];
    [self.confirmRatingButton setTitle:@"Rate!" forState:UIControlStateNormal];
    [self.confirmRatingButton setBackgroundColor:[UIColor greenColor]];
    [self.confirmRatingButton addTarget:self action:@selector(saveRating) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.confirmRatingButton];
    //testing
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)saveRating {
    AudioServicesPlaySystemSound(1001);
    double rating = self.editableStarRatingView.rating;

    //testing
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://www.networksocal.com/"]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSData *imageData = UIImageJPEGRepresentation(self.imageView.image, 0.5);
    NSDictionary *parameters = @{@"message": @"saved!"};
    AFHTTPRequestOperation *op = [manager POST:@"?c=review&m=createReview" parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //do not put image inside parameters dictionary as I did, but append it!
        [formData appendPartWithFileData:imageData name:@"file" fileName:@"upload.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@ ***** %@", operation.responseString, error);
   }];
    [op start];


//        [self dismissViewControllerAnimated:YES completion:nil];
    //testing
    
    [self.editableStarRatingView removeFromSuperview];
    [self.confirmRatingButton removeFromSuperview];
    self.imageView.image = nil;
}

@end
