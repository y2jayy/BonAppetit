//
//  LoginViewController.m
//  BonAppetit
//
//  Created by Jay Yoon on 12/27/14.
//  Copyright (c) 2014 Jay Yoon. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet FBProfilePictureView *profilePictureView;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.loginView.readPermissions = @[@"public_profile", @"email", @"user_friends"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Facebook Login

// This method will be called when the user information has been fetched
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
  self.profilePictureView.profileID = user.id;
  self.nameLabel.text = user.name;
  
      // Set user defaults
    [[NSUserDefaults standardUserDefaults] setObject:user.first_name forKey:@"first_name"];
    [[NSUserDefaults standardUserDefaults] setObject:user.last_name forKey:@"last_name"];
    
    // Web API authentication for user data persistence
    NSUserDefaults *storeData=[NSUserDefaults standardUserDefaults];
    [storeData setObject:user.id forKey:@"fbUserId"];
    [self authenticate:user];
}

// Logged-in user experience
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    [self performSegueWithIdentifier:@"showTabBarController" sender:self];
  self.statusLabel.text = @"You're logged in as";
}

// Logged-out user experience
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
  self.profilePictureView.profileID = nil;
  self.nameLabel.text = @"";
  self.statusLabel.text= @"You're not logged in!";
}

// Handle possible errors that can occur during login
- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
  NSString *alertMessage, *alertTitle;

  // If the user should perform an action outside of you app to recover,
  // the SDK will provide a message for the user, you just need to surface it.
  // This conveniently handles cases like Facebook password change or unverified Facebook accounts.
  if ([FBErrorUtility shouldNotifyUserForError:error]) {
    alertTitle = @"Facebook error";
    alertMessage = [FBErrorUtility userMessageForError:error];

  // This code will handle session closures that happen outside of the app
  // You can take a look at our error handling guide to know more about it
  // https://developers.facebook.com/docs/ios/errors
  } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
    alertTitle = @"Session Error";
    alertMessage = @"Your current session is no longer valid. Please log in again.";

    // If the user has cancelled a login, we will do nothing.
    // You can also choose to show the user a message if cancelling login will result in
    // the user not being able to complete a task they had initiated in your app
    // (like accessing FB-stored information or posting to Facebook)
  } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
    NSLog(@"user cancelled login");

    // For simplicity, this sample handles other errors with a generic message
    // You can checkout our error handling guide for more detailed information
    // https://developers.facebook.com/docs/ios/errors
  } else {
    alertTitle  = @"Something went wrong";
    alertMessage = @"Please try again later.";
    NSLog(@"Unexpected error:%@", error);
  }

  if (alertMessage) {
    [[[UIAlertView alloc] initWithTitle:alertTitle
                                message:alertMessage
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
  }
}

// Web API Methods for Authentication and Signing up - User Data Persistence
// Facebook's Authentication API is insufficient because we cannot get a list of all logged in users of a given user
// if those users are not friends in the Facebook API

- (void)authenticate:(id<FBGraphUser>)FBUserData
{
//    NSString *deviceId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    // Create the request.
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.networksocal.com/welcome/authenticate/%@", FBUserData.id]]
                cachePolicy:NSURLRequestUseProtocolCachePolicy
            timeoutInterval:60.0];

    // Create the NSMutableData to hold the received data.
    _receivedData = [NSMutableData dataWithCapacity: 0];

    // create the connection with the request and start loading the data
    _authenticateConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if (!_authenticateConnection) {
        // Release the receivedData object.
        _receivedData = nil;
    }
}

- (void)signup
{
    NSString *deviceId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    NSUserDefaults *storeData = [NSUserDefaults standardUserDefaults];
//    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Alert" message:@"Please enter your phone number." delegate:self cancelButtonTitle:@"Submit" otherButtonTitles:nil];
//    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
//    [alert show];
    
    // Create the request.
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.networksocal.com/welcome/signup/%@/%@/%@/%@", [storeData valueForKey:@"fbUserId"], deviceId, [[storeData valueForKey:@"first_name"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], [[storeData valueForKey:@"last_name"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]]
                cachePolicy:NSURLRequestUseProtocolCachePolicy
            timeoutInterval:60.0];

    // Create the NSMutableData to hold the received data.
    _receivedData = [NSMutableData dataWithCapacity: 0];

    // create the connection with the request and start loading the data
    _signupConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if (!_signupConnection)
    {
        // Release the receivedData object.
        _receivedData = nil;
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
    if (connection == _authenticateConnection)
    {
//NSLog(@"ok it works now");
        // Parse the JSON that came in
        NSError *error;
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:_receivedData options:NSJSONReadingAllowFragments error:&error];
    
        if (jsonArray.count > 0)
        {
            NSString * Authkey = jsonArray[0][@"id"];;
            NSUserDefaults *storeData=[NSUserDefaults standardUserDefaults];
            [storeData setObject:Authkey forKey:@"userId"];
//            _userId = jsonArray[0][@"id"];
        }
        else
        {
            [self signup];
        }
    }
    else if (connection == _signupConnection)
    {
        NSError *error;
        NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:_receivedData options:NSJSONReadingAllowFragments error:&error];

        NSString * Authkey = jsonArray[0];
        NSUserDefaults *storeData = [NSUserDefaults standardUserDefaults];
        [storeData setObject:Authkey forKey:@"userId"];
//        _userId = jsonArray[0];
    }
    
    NSUserDefaults *storeData = [NSUserDefaults standardUserDefaults];
//    NSLog(@"FBLoginID: %@", [storeData valueForKey:@"fbUserId"]);
//    NSLog(@"CustomID: %@", [storeData valueForKey:@"userId"]);
NSLog(@"%@", [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]);
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
