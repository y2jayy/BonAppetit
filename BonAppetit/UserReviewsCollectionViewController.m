//
//  UserReviewsCollectionViewController.m
//  BonAppetit
//
//  Created by Jay Yoon on 1/25/15.
//  Copyright (c) 2015 Jay Yoon. All rights reserved.
//

#import "UserReviewsCollectionViewController.h"
#import "AppDelegate.h"

@interface UserReviewsCollectionViewController ()

@property (nonatomic, strong) NSArray *latestReviews;

@end

@implementation UserReviewsCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    self.user = [[API sharedManager] signedInUser];
    
    [self.collectionView reloadData];
    [self fetchLatestReviews];
}

-(void)fetchLatestReviews
{
    [[API sharedManager] fetchFolloweeReviewsForUserOnly:[[NSUserDefaults standardUserDefaults] valueForKey:@"userId"] callback:
      ^(NSArray *sortedReviews, NSError *error) {
          if (error) {
              NSLog(@"Error fetching latest reviews: %@", error);
          } else {
              self.latestReviews = sortedReviews;
              [self.collectionView reloadData];
          }
      }];
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete method implementation -- Return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete method implementation -- Return the number of items in the section
    return self.latestReviews.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"UserReviewsCell";
    UserReviewsCollectionViewCell *cell = [collectionView
           dequeueReusableCellWithReuseIdentifier:@"UserReviewsCell"
           forIndexPath:indexPath];

    // Configure the cell...

    long row = [indexPath row];

//    cell.reviewerNameLabel.text = _reviewerNames[row];
//    cell.restaurantNameLabel.text = _restaurantNames[row];
//    cell.reviewImageView.image = [UIImage imageNamed:_reviewImages[row]];
//    cell.profileImageView.image = [UIImage imageNamed:_profileImages[row]];
//    
//    cell.ratingView.canEdit = NO;
//    cell.ratingView.maxRating = 5;
//    cell.ratingView.rating = [_ratings[row] doubleValue];
    
    [cell configureWithReview:self.latestReviews[row]];

    return cell;
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
