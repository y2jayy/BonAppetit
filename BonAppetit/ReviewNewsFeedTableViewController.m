//
//  ReviewNewsFeedTableViewController.m
//  BonAppetit
//
//  Created by Jay Yoon on 1/9/15.
//  Copyright (c) 2015 Jay Yoon. All rights reserved.
//

#import "ReviewNewsFeedTableViewController.h"
#import "ReviewNewsFeedTableViewCell.h"

@interface ReviewNewsFeedTableViewController ()

@end

@implementation ReviewNewsFeedTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
     _profileImages = @[@"person1.jpg",
                  @"person2.jpg",
                  @"person3.jpg",
                  @"person4.jpg",
                  @"person5.jpg"];

    _reviewImages = @[@"food1.jpg",
                   @"food2.jpg",
                   @"food3.jpg",
                   @"food4.jpg",
                   @"food5.jpg"];

    _reviewerNames = @[@"Allie Flores",
                   @"Brady Yoon",
                   @"Dallas Caley",
                   @"Emily Hsu",
                   @"Jay Yoon"];
    
    _restaurantNames = @[@"Reunion Kitchen and Drink",
                   @"True Shabu",
                   @"In-N-Out Burger",
                   @"California Fish Grill",
                   @"Medii Kitchen"];

    _ratings = @[@"5",
                   @"3",
                   @"2",
                   @"4",
                   @"1"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return _reviewImages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"reviewCell";
    ReviewNewsFeedTableViewCell *cell = [tableView
          dequeueReusableCellWithIdentifier:CellIdentifier 
          forIndexPath:indexPath];

    // Configure the cell...

    long row = [indexPath row];

    cell.reviewerNameLabel.text = _reviewerNames[row];
    cell.restaurantNameLabel.text = _restaurantNames[row];
    cell.reviewImageView.image = [UIImage imageNamed:_reviewImages[row]];
    cell.profileImageView.image = [UIImage imageNamed:_profileImages[row]];

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
