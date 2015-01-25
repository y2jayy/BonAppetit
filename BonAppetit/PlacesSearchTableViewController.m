//
//  PlacesSearchTableViewController.m
//  BonAppetit
//
//  Created by Jay Yoon on 1/18/15.
//  Copyright (c) 2015 Jay Yoon. All rights reserved.
//

#import "PlacesSearchTableViewController.h"
#import "PlacesSearchTableViewCell.h"
#import "BAPlace.h"
#import "AppDelegate.h"
#import "SharePhotoViewController.h"

@interface PlacesSearchTableViewController ()

@property (nonatomic, strong) NSMutableArray *searchResults;
@property (nonatomic, strong) NSMutableArray *places;
//@property (nonatomic, strong) BAUser *user;

@end

@implementation PlacesSearchTableViewController

static NSString * const reuseIdentifier = @"placeCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    _placeNames = @[@"Reunion Kitchen and Drink",
                   @"True Shabu",
                   @"In-N-Out Burger",
                   @"California Fish Grill",
                   @"Medii Kitchen"];
    
    _placeAddresses = @[@"701 S Palomino Ln",
                   @"1003 Silver Star Way",
                   @"7882 Hampshire Road",
                   @"340 Eaton Circle",
                   @"512 Veteran Aven"];
    [self fetchPlaces];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fetchPlaces
{
//    [[API sharedManager] fetchPlacesContainingKeyword:@"" nearLocation:CLLocationCoordinate2DMake(-33.8, 117.3)
//        callback:
//      ^(NSArray *sortedPlaces, NSError *error) {
//NSLog(@"%@", sortedPlaces);
//          if (error) {
//              NSLog(@"Error fetching places: %@", error);
//          } else {
//              self.searchResults = sortedPlaces;
//              [self.tableView reloadData];
//          }
//      }];
    //testing
    // Create the request.
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=%f,%f&radius=100&rankBy=distance&types=restaurant&key=AIzaSyAJzXxRP2bnEyV_SiI1g2B8yDUYchjdrkE", self.latitude, self.longitude]]
                cachePolicy:NSURLRequestUseProtocolCachePolicy
            timeoutInterval:60.0];

    // Create the NSMutableData to hold the received data.
    _receivedData = [NSMutableData dataWithCapacity: 0];

    // create the connection with the request and start loading the data
    _placeSearchConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if (!_placeSearchConnection) {
        // Release the receivedData object.
        _receivedData = nil;
    }
    //testing
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
    // Return the number of rows in the section.
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return self.searchResults.count;
    } else {
        return self.places.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlacesSearchTableViewCell *cell = (PlacesSearchTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[PlacesSearchTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    
    // Configure the cell...
    long row = [indexPath row];
    
//    cell.placeNameLabel.text = _placeNames[row];
//    cell.placeAddressLabel.text = _placeAddresses[row];
 
    // Display recipe in the table cell
    BAPlace *place = nil;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        place = [self.searchResults objectAtIndex:indexPath.row];
    } else {
        place = [self.places objectAtIndex:indexPath.row];
    }
    
    cell.placeNameLabel.text = place.name;
    cell.placeAddressLabel.text = place.address;
    
    
//    cell.restaurantNameLabel.text = _restaurantNames[row];
//    cell.reviewImageView.image = [UIImage imageNamed:_reviewImages[row]];
//    cell.profileImageView.image = [UIImage imageNamed:_profileImages[row]];
//    
//    cell.ratingView.canEdit = NO;
//    cell.ratingView.maxRating = 5;
//    cell.ratingView.rating = [_ratings[row] doubleValue];
    
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"selectedPlaceSegue"]) {
        SharePhotoViewController *controller = (SharePhotoViewController *)segue.destinationViewController;
        controller.placeName = [sender placeNameLabel].text;
        
        controller.rating = self.rating;
        controller.latitude = self.latitude;
        controller.longitude = self.longitude;
        controller.photoTaken = self.photoTaken;
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [_receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the new data to receivedData.
    // receivedData is an instance variable declared elsewhere.
    [_receivedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    if (connection == _placeSearchConnection)
    {
        // Parse the JSON that came in
        NSError *error;
        NSArray *placeData = [NSJSONSerialization JSONObjectWithData:_receivedData options:NSJSONReadingAllowFragments error:&error][@"results"];
NSLog(@"%@", placeData);

        if (placeData.count > 0)
        {
            self.places = [[NSMutableArray alloc] init];
        
            for (int i = 0; i < placeData.count; i++)
            {
                // Initialize the "places found by Google places API call" array
                BAPlace *place = [BAPlace new];
                place.name = placeData[i][@"name"];
                place.address = placeData[i][@"vicinity"];
                [self.places addObject:place];
            }
        }
        
        [self.tableView reloadData];
    }
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate predicateWithFormat:@"name contains[c] %@", searchText];
    self.searchResults = [self.places filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterContentForSearchText:searchString
            scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                objectAtIndex:[self.searchDisplayController.searchBar
                selectedScopeButtonIndex]]];
    
    return YES;
}


@end
