//
//  API.m
//  BonAppetit
//
//  Created by Jay Yoon on 1/10/15.
//  Copyright (c) 2015 Jay Yoon. All rights reserved.
//

#import "API.h"
#import "NSObject+TypeValidation.h"
#import <AFHTTPRequestOperationManager.h>
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"
#import "BAUser.h"
#import "BAReview.h"
#import <GoogleMaps/GoogleMaps.h>

@interface API ()
//TODO: Find a better home for this
@property (nonatomic, strong) BAUser *signedInUser;
@end

@implementation API

#pragma mark - Singleton methods

+(id)sharedManager
{
    static API *sharedManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

//#pragma mark - Accessors
//
//- (CUCouple *)signedInCouple
//{
//    return self.signedInUser.couple;
//}
//
//#pragma mark - Sign In / Out
//
//- (void)signInUserWithEmail:(NSString *)email callback:(void (^)(NSError *error))callback
//{
//    [self fetchUserWithEmail:email callback:
//     ^(CUUser *user, NSError *error) {
//         if (error) {
//             callback(error);
//             return;
//         }
//         
//         self.signedInUser = user;
//         if (!self.signedInUser) {
//             NSLog(@"No user returned");
//             callback([NSError errorWithDomain:@"com.zoupple" code:0 userInfo:nil]);
//         } else {
//             [[NSUserDefaults standardUserDefaults] setObject:self.signedInUser.email forKey:@"SignedInUserEmail"];
//             [[NSUserDefaults standardUserDefaults] synchronize];
//             callback(nil);
//         }
//     }];
//}
//
//- (void)signOutUser
//{
//    //???: Do we want to be this aggressive? Fine for now since everything is couple-centric. Later maybe not.
//    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
//    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
//    
//    self.signedInUser = nil;
//    self.signedInUser.couple = nil;
//}
//
//#pragma mark - User
//
//- (void)fetchUserWithEmail:(NSString *)email callback:(void (^)(CUUser *user, NSError *error))callback
//{
//    if (email.length == 0) {
//        NSLog(@"Invalid email address");
//        //TODO: Pass a real error back
//        callback(nil, [NSError errorWithDomain:@"com.zoupple" code:0 userInfo:nil]);
//        return;
//    }
//    
//    NSString *endpoint = [NSString stringWithFormat:@"/users/email/%@", email];
//    
//    [[CUHTTPRequestOperationManager sharedManager]
//     GET:endpoint
//     parameters:nil
//     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         NSDictionary *responseDictionary = [responseObject dictionaryOrNilValue];
//         NSError *userError = nil;
//         CUUser *aUser = [[CUUser alloc] initWithDictionary:responseDictionary[@"data"] error:&userError];
//         if (userError) {
//             NSLog(@"Error fetching user with email: %@", userError);
//         }
//         callback(aUser, nil);
//     }
//     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         callback(nil, error);
//     }];
//}
//
//- (void)updateUser:(CUUser *)user location:(CLLocation *)location callback:(void (^)(NSDictionary *jsonDictionary, NSError *error))callback
//{
//    if ((user.userId.length == 0) || !location || !CLLocationCoordinate2DIsValid(location.coordinate)) {
//        NSLog(@"Invalid parameters");
//        //TODO: Pass a real error back
//        callback(nil, [NSError errorWithDomain:@"com.zoupple" code:0 userInfo:nil]);
//        return;
//    }
//    
//    NSString *endpoint = [NSString stringWithFormat:@"/users/%@/location", user.userId];
//    NSDictionary *parameters = @{ @"lat" : @(location.coordinate.latitude),
//                                  @"lon" : @(location.coordinate.longitude) };
//    
//    [[CUHTTPRequestOperationManager sharedManager]
//     PATCH:endpoint
//     parameters:parameters
//     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         //TODO: Parse out the important bits into a data model
//         NSDictionary *responseDictionary = [responseObject dictionaryOrNilValue];
//         callback(responseDictionary, nil);
//     }
//     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         callback(nil, error);
//     }];
//}
//
//- (void)updateUser:(CUUser *)user
//       deviceToken:(NSString *)deviceToken
//          callback:(void (^)(NSDictionary *jsonDictionary, NSError *error))callback{
//    if ((user.userId.length == 0) || !deviceToken) {
//        NSLog(@"Invalid parameters");
//        //TODO: Pass a real error back
//        callback(nil, [NSError errorWithDomain:@"com.zoupple" code:0 userInfo:nil]);
//        return;
//    }
//    
//    NSString *endpoint = [NSString stringWithFormat:@"/users/%@/deviceToken", user.userId];
//    NSDictionary *parameters = @{ @"deviceToken" : deviceToken };
//    
//    [[CUHTTPRequestOperationManager sharedManager]
//     PATCH:endpoint
//     parameters:parameters
//     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         //TODO: Parse out the important bits into a data model
//         NSDictionary *responseDictionary = [responseObject dictionaryOrNilValue];
//         callback(responseDictionary, nil);
//     }
//     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         callback(nil, error);
//     }];
//}
//
//#pragma mark - Couple
//
////!!!: No longer need this. Should we remove from here?
//- (void)fetchCoupleById:(NSString *)coupleId callback:(void (^)(CUCouple *couple, NSError *error))callback
//{
//    if (coupleId.length == 0) {
//        NSLog(@"Invalid parameters");
//        //TODO: Pass a real error back
//        callback(nil, [NSError errorWithDomain:@"com.zoupple" code:0 userInfo:nil]);
//        return;
//    }
//    
//    NSString *endpoint = [NSString stringWithFormat:@"/couples/%@", coupleId];
//    
//    [[CUHTTPRequestOperationManager sharedManager]
//     GET:endpoint
//     parameters:nil
//     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         NSDictionary *responseDictionary = [responseObject dictionaryOrNilValue];
//         NSError *coupleError = nil;
//         CUCouple *responseCouple = [[CUCouple alloc] initWithDictionary:responseDictionary[@"data"] error:&coupleError];
//         if (coupleError) {
//             NSLog(@"Error fetching couple by user ID: %@", coupleError);
//         }
//         callback(responseCouple, nil);
//     }
//     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         callback(nil, error);
//     }];
//}
//
//- (void)fetchCoupleListByDistance:(CLLocation *)originLocation callback:(void (^)(NSArray *couples, NSError *error))callback
//{
//    if (!originLocation || !CLLocationCoordinate2DIsValid(originLocation.coordinate)) {
//        NSLog(@"Invalid parameters");
//        //TODO: Pass a real error back
//        callback(nil, [NSError errorWithDomain:@"com.zoupple" code:0 userInfo:nil]);
//        return;
//    }
//    
//    NSString *endpoint = [NSString stringWithFormat:@"/couples/nearby/%f/%f",
//                          originLocation.coordinate.longitude,
//                          originLocation.coordinate.latitude];
//    
//    [[CUHTTPRequestOperationManager sharedManager]
//     GET:endpoint
//     parameters:nil
//     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         NSDictionary *responseDictionary = [responseObject dictionaryOrNilValue];
//         NSArray *coupleDictionaries = responseDictionary[@"data"];
//         
//         NSError *coupleError = nil;
//         NSArray *unsortedCouples = [CUCouple arrayOfModelsFromDictionaries:coupleDictionaries error:&coupleError];
//         if (coupleError) {
//             //???: Fatal?
//             NSLog(@"Error fetching couples: %@", coupleError);
//         }
//         
////         NSSortDescriptor *distanceSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"distanceToClosestUser" ascending:YES];
////         NSArray *couples = [unsortedCouples sortedArrayUsingDescriptors:@[distanceSortDescriptor]];
//         // Couples come back sorted with unknown locations at end
//         NSArray *couples = [NSArray arrayWithArray:unsortedCouples];
//         
//         callback(couples, nil);
//     }
//     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         callback(nil, error);
//     }];
//}
//
////???: Rename -createUser... instead?
//- (void)createCoupleWithUserEmail:(NSString *)userEmail
//                         userName:(NSString *)userName
//                     userLocation:(CLLocation *)userLocation
//                     coupleStatus:(NSString *)coupleStatus
//                       coupleName:(NSString *)coupleName
//                      deviceToken:(NSString *)deviceToken
//                         callback:(void (^)(NSError *error))callback
//{
//    // Sign out current couple (shouldn't be necessary, but to be safe)
//    [self signOutUser];
//    
//    if ((userEmail.length == 0) || (userName.length == 0)) {
//        NSLog(@"Invalid parameters");
//        //TODO: Pass a real error back
//        callback([NSError errorWithDomain:@"com.zoupple" code:0 userInfo:nil]);
//        return;
//    }
//    
//    NSString *endpoint = @"/couples";
//    NSMutableDictionary *mutableParameters = [NSMutableDictionary dictionary];
//    mutableParameters[@"userEmail"] = userEmail;
//    mutableParameters[@"userName"] = userName;
//    if (userLocation && CLLocationCoordinate2DIsValid(userLocation.coordinate)) {
//        mutableParameters[@"lat"] = @(userLocation.coordinate.latitude);
//        mutableParameters[@"lon"] = @(userLocation.coordinate.longitude);
//    }
//    if (coupleStatus) {
//        mutableParameters[@"coupleStatus"] = coupleStatus;
//    }
//    if (coupleName) {
//        mutableParameters[@"coupleName"] = coupleName;
//    }
//    if(deviceToken) {
//        mutableParameters[@"deviceToken"] = deviceToken;
//    }
//    NSDictionary *parameters = [NSDictionary dictionaryWithDictionary:mutableParameters];
//    
//    [[CUHTTPRequestOperationManager sharedManager]
//     PUT:endpoint
//     parameters:parameters
//     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         NSDictionary *responseDictionary = [responseObject dictionaryOrNilValue];
//         NSError *userError = nil;
//         CUUser *responseUser = [[CUUser alloc] initWithDictionary:responseDictionary[@"data"] error:&userError];
//         if (userError) {
//             NSLog(@"Error fetching couple by user ID: %@", userError);
//         }
//         self.signedInUser = responseUser;
//         //TODO: If nil couple, return error
//         callback(nil);
//     }
//     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         callback(error);
//     }];
//}
//
//- (void)updateCouple:(CUCouple *)couple
//    addMateWithEmail:(NSString *)email
//                name:(NSString *)name
//            location:(CLLocation *)location
//            callback:(void (^)(NSDictionary *jsonDictionary, NSError *error))callback
//{
//    if ((couple.coupleId.length == 0) || (email.length == 0) || (name.length == 0)) {
//        NSLog(@"Invalid parameters");
//        //TODO: Pass a real error back
//        callback(nil, [NSError errorWithDomain:@"com.zoupple" code:0 userInfo:nil]);
//        return;
//    }
//    
//    NSString *endpoint = [NSString stringWithFormat:@"/couples/%@/users", couple.coupleId];
//    NSMutableDictionary *mutableParameters = [NSMutableDictionary dictionary];
//    mutableParameters[@"email"] = email;
//    mutableParameters[@"name"] = name;
//    if (location && CLLocationCoordinate2DIsValid(location.coordinate)) {
//        mutableParameters[@"lat"] = @(location.coordinate.latitude);
//        mutableParameters[@"lon"] = @(location.coordinate.longitude);
//    }
//    NSDictionary *parameters = [NSDictionary dictionaryWithDictionary:mutableParameters];
//    
//    [[CUHTTPRequestOperationManager sharedManager]
//     PUT:endpoint
//     parameters:parameters
//     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         //TODO: Parse out the important bits into a data model
//         NSDictionary *responseDictionary = [responseObject dictionaryOrNilValue];
//         callback(responseDictionary, nil);
//     }
//     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         callback(nil, error);
//     }];
//}
//
//- (void)updateCouple:(CUCouple *)couple status:(NSString *)status callback:(void (^)(NSDictionary *jsonDictionary, NSError *error))callback
//{
//    if (couple.coupleId.length == 0) {
//        NSLog(@"Invalid parameters");
//        //TODO: Pass a real error back
//        callback(nil, [NSError errorWithDomain:@"com.zoupple" code:0 userInfo:nil]);
//        return;
//    }
//    
//    NSString *endpoint = [NSString stringWithFormat:@"/couples/%@/status", couple.coupleId];
//    NSDictionary *parameters = @{ @"status" : status };
//    
//    [[CUHTTPRequestOperationManager sharedManager]
//     PATCH:endpoint
//     parameters:parameters
//     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         //TODO: Parse out the important bits into a data model
//         NSDictionary *responseDictionary = [responseObject dictionaryOrNilValue];
//         callback(responseDictionary, nil);
//     }
//     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         callback(nil, error);
//     }];
//}
//
//- (void)updateCouple:(CUCouple *)couple name:(NSString *)name callback:(void (^)(NSDictionary *jsonDictionary, NSError *error))callback
//{
//    if ((couple.coupleId.length == 0) || (name.length == 0)) {
//        NSLog(@"Invalid parameters");
//        //TODO: Pass a real error back
//        callback(nil, [NSError errorWithDomain:@"com.zoupple" code:0 userInfo:nil]);
//        return;
//    }
//    
//    NSString *endpoint = [NSString stringWithFormat:@"/couples/%@/name", couple.coupleId];
//    NSDictionary *parameters = @{ @"name" : name };
//    
//    [[CUHTTPRequestOperationManager sharedManager]
//     PATCH:endpoint
//     parameters:parameters
//     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         //TODO: Parse out the important bits into a data model
//         NSDictionary *responseDictionary = [responseObject dictionaryOrNilValue];
//         callback(responseDictionary, nil);
//     }
//     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         callback(nil, error);
//     }];
//}
//
//- (void)updateCouple:(CUCouple *)couple profileInfo:(NSDictionary *)profileInfo callback:(void (^)(NSError *error))callback
//{
//    //???: What to verify for profileInfo parameter?
//    if (couple.coupleId.length == 0) {
//        NSLog(@"Invalid parameters");
//        //TODO: Pass a real error back
//        callback([NSError errorWithDomain:@"com.zoupple" code:0 userInfo:nil]);
//        return;
//    }
//    
//    NSString *endpoint = [NSString stringWithFormat:@"/couples/%@/info", couple.coupleId];
//    //**** need to break out this info into params?
//    NSDictionary *parameters = profileInfo;
//    NSLog(@"Params: %@", parameters);
//    
//    [[CUHTTPRequestOperationManager sharedManager]
//     PATCH:endpoint
//     parameters:parameters
//     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         NSDictionary *responseDictionary = [responseObject dictionaryOrNilValue];
//         NSError *coupleError = nil;
//         CUCouple *responseCouple = [[CUCouple alloc] initWithDictionary:responseDictionary[@"data"] error:&coupleError];
//         if (coupleError) {
//             NSLog(@"Error fetching couple by user ID: %@", coupleError);
//         } else if (responseCouple) {
//             //???: Verify that responseCouple.user1/2Id matches self.signedInUser.userId?
//             // Update couple. Or we couple replace it and post a notification for all views to refresh their references to this couple.
//             //TODO: See if there's a less-fragile way to handle this.
//             self.signedInCouple.name = responseCouple.name;
//             self.signedInCouple.status = responseCouple.status;
//             self.signedInCouple.hasKids = responseCouple.hasKids;
//             self.signedInCouple.pets = responseCouple.pets;
//             self.signedInCouple.typeOfCouple = responseCouple.typeOfCouple;
//             self.signedInCouple.describe = responseCouple.describe;
//             self.signedInCouple.livetogether = responseCouple.livetogether;
//             self.signedInCouple.wantfromapp = responseCouple.wantfromapp;
//             self.signedInCouple.agerange = responseCouple.agerange;
//             self.signedInCouple.religious = responseCouple.religious;
//             self.signedInCouple.meetingPeople = responseCouple.meetingPeople;
//             self.signedInCouple.favFood = responseCouple.favFood;
//             self.signedInCouple.favActivity = responseCouple.favActivity;
//             self.signedInCouple.destination = responseCouple.destination;
//             self.signedInCouple.transportation = responseCouple.transportation;
//             self.signedInCouple.madLib = responseCouple.madLib;
//         }
//         callback(nil);
//     }
//     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         callback(error);
//     }];
//}
//
//- (void)fetchFollowers:(CUCouple *)couple callback:(void (^)(NSArray *followers, NSError *error))callback
//{
//    if (couple.coupleId.length == 0) {
//        NSLog(@"Invalid parameters");
//        //TODO: Pass a real error back
//        callback(nil, [NSError errorWithDomain:@"com.zoupple" code:0 userInfo:nil]);
//        return;
//    }
//    
//    NSString *endpoint = [NSString stringWithFormat:@"/couples/%@/followers", couple.coupleId];
//    
//    [[CUHTTPRequestOperationManager sharedManager]
//     GET:endpoint
//     parameters:nil
//     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         NSDictionary *responseDictionary = [responseObject dictionaryOrNilValue];
//         NSArray *followDictionaries = responseDictionary[@"data"];
//         
//         NSError *followError = nil;
//         NSArray *follows = [CUCouple arrayOfModelsFromDictionaries:followDictionaries error:&followError];
//         if (followError) {
//             //???: Fatal?
//             NSLog(@"Error fetching followers: %@", followError);
//         }
//         
//         callback(follows, nil);
//     }
//     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         callback(nil, error);
//     }];
//}
//
//- (void)fetchFollowees:(CUCouple *)couple callback:(void (^)(NSArray *followees, NSError *error))callback
//{
//    if (couple.coupleId.length == 0) {
//        NSLog(@"Invalid parameters");
//        //TODO: Pass a real error back
//        callback(nil, [NSError errorWithDomain:@"com.zoupple" code:0 userInfo:nil]);
//        return;
//    }
//    
//    NSString *endpoint = [NSString stringWithFormat:@"/couples/%@/followees", couple.coupleId];
//    
//    [[CUHTTPRequestOperationManager sharedManager]
//     GET:endpoint
//     parameters:nil
//     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         NSDictionary *responseDictionary = [responseObject dictionaryOrNilValue];
//         NSArray *followDictionaries = responseDictionary[@"data"];
//         
//         NSError *followError = nil;
//         NSArray *follows = [CUCouple arrayOfModelsFromDictionaries:followDictionaries error:&followError];
//         if (followError) {
//             //???: Fatal?
//             NSLog(@"Error fetching followees: %@", followError);
//         }
//         
//         callback(follows, nil);
//     }
//     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         callback(nil, error);
//     }];
//}
//
//- (void)fetchConversations:(CUCouple *)couple callback:(void (^)(NSArray *followers, NSError *error))callback
//{
//    if (couple.coupleId.length == 0) {
//        NSLog(@"Invalid parameters");
//        //TODO: Pass a real error back
//        callback(nil, [NSError errorWithDomain:@"com.zoupple" code:0 userInfo:nil]);
//        return;
//    }
//    
//    NSString *endpoint = [NSString stringWithFormat:@"/couples/%@/conversations", couple.coupleId];
//    
//    [[CUHTTPRequestOperationManager sharedManager]
//     GET:endpoint
//     parameters:nil
//     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         NSLog(@"Response Object: %@", responseObject);
//         NSDictionary *responseDictionary = [responseObject dictionaryOrNilValue];
//         NSArray *followDictionaries = responseDictionary[@"data"];
//         
//         NSError *followError = nil;
//         NSArray *follows = [CUCouple arrayOfModelsFromDictionaries:followDictionaries error:&followError];
//         if (followError) {
//             //???: Fatal?
//             NSLog(@"Error fetching followers: %@", followError);
//         }
//         
//         callback(follows, nil);
//     }
//     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         callback(nil, error);
//     }];
//}
//
//- (void)fetchSingleConversation:(CUCouple *)couple callback:(void (^)(NSArray *followers, NSError *error))callback
//{
//    if (couple.coupleId.length == 0) {
//        NSLog(@"Invalid parameters");
//        //TODO: Pass a real error back
//        callback(nil, [NSError errorWithDomain:@"com.zoupple" code:0 userInfo:nil]);
//        return;
//    }
//    
//    NSString *endpoint = [NSString stringWithFormat:@"/couples/%@/conversation", couple.coupleId];
//    
//    [[CUHTTPRequestOperationManager sharedManager]
//     GET:endpoint
//     parameters:nil
//     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         NSLog(@"Response Object: %@", responseObject);
//         NSDictionary *responseDictionary = [responseObject dictionaryOrNilValue];
//         NSArray *conversationDictionaries = responseDictionary[@"data"];
//         
//         NSError *conversationError = nil;
//         NSArray *conversations = [CUConversation arrayOfModelsFromDictionaries:conversationDictionaries error:&conversationError];
//         if (conversationError) {
//             //???: Fatal?
//             NSLog(@"Error fetching followers: %@", conversationError);
//         }
//         
//         callback(conversations, nil);
//     }
//     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         callback(nil, error);
//     }];
//}
//
//- (void)fetchBoots:(CUCouple *)couple callback:(void (^)(NSArray *boots, NSError *error))callback
//{
//    if (couple.coupleId.length == 0) {
//        NSLog(@"Invalid parameters");
//        //TODO: Pass a real error back
//        callback(nil, [NSError errorWithDomain:@"com.zoupple" code:0 userInfo:nil]);
//        return;
//    }
//    
//    NSString *endpoint = [NSString stringWithFormat:@"/couples/%@/boots", couple.coupleId];
//    
//    [[CUHTTPRequestOperationManager sharedManager]
//     GET:endpoint
//     parameters:nil
//     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         NSDictionary *responseDictionary = [responseObject dictionaryOrNilValue];
//         NSArray *bootDictionaries = responseDictionary[@"data"];
//         
//         NSError *bootError = nil;
//         NSArray *boots = [CUBoot arrayOfModelsFromDictionaries:bootDictionaries error:&bootError];
//         if (bootError) {
//             //???: Fatal?
//             NSLog(@"Error fetching booted couples: %@", bootError);
//         }
//         
//         callback(boots, nil);
//     }
//     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         callback(nil, error);
//     }];
//}
//
////Send Push Notification
//-(void)sendPushNotification:(NSString *)type followee:(NSString *)followeeId callback:(void (^)(NSError *error))callback{
//    NSString *endpoint = [NSString stringWithFormat:@"/couples/pushnotify/%@/%@", followeeId, type];
//    
//    [[CUHTTPRequestOperationManager sharedManager]
//     GET:endpoint
//     parameters:nil
//     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         NSDictionary *responseDictionary = [responseObject dictionaryOrNilValue];
//         callback(nil);
//     }
//     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         callback(error);
//     }];
//}
//
//// Messenger methods
//-(void)postMessageToServer:(NSDictionary *)params callback:(void (^)(NSError *error))callback{
//    NSString *endpoint = [NSString stringWithFormat:@"/api.php"];
//    
//    [[CUHTTPRequestOperationManager sharedManager:@"http://ec2-54-183-248-60.us-west-1.compute.amazonaws.com"]
//     POST:endpoint
//     parameters:params
//     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         NSDictionary *responseDictionary = [responseObject dictionaryOrNilValue];
//         callback(nil);
//     }
//     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         callback(error);
//     }];
//}
//
//-(void)postJoinRequest:(NSDictionary *)params callback:(void (^)(NSError *error))callback{
//    NSString *endpoint = [NSString stringWithFormat:@"/api.php"];
//    
//    [[CUHTTPRequestOperationManager sharedManager:@"http://ec2-54-183-248-60.us-west-1.compute.amazonaws.com"]
//     POST:endpoint
//     parameters:params
//     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         NSDictionary *responseDictionary = [responseObject dictionaryOrNilValue];
//         callback(nil);
//     }
//     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         callback(error);
//     }];
//}
//
//-(void)fetchMessagesForDevice:(NSDictionary *)params callback:(void (^)(NSArray *followers, NSError *error))callback{
//    NSString *endpoint = [NSString stringWithFormat:@"/messages.php"];
//    
//    [[CUHTTPRequestOperationManager sharedManager:@"http://ec2-54-183-248-60.us-west-1.compute.amazonaws.com"]
//     GET:endpoint
//     parameters:params
//     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         NSLog(@"Response Object: %@", responseObject);
//         NSDictionary *responseDictionary = [responseObject dictionaryOrNilValue];
//         NSArray *messageDictionaries = responseDictionary[@"data"];
//         
//         NSError *messageError = nil;
////         NSArray *messages = [CUMessage arrayOfModelsFromDictionaries:messageDictionaries error:&messageError];
////         if (messageError) {
////             //???: Fatal?
////             NSLog(@"Error fetching followers: %@", messageError);
////         }
//         
//         
//         NSArray *unsortedAssets = [CUMessage arrayOfModelsFromDictionaries:messageDictionaries error:&messageError];
//         if (messageError) {
//             //???: Should this be fatal (i.e. return nil for sortedAssets)?
//             NSLog(@"Error creating asset: %@", messageError);
//         }
//         
//         NSSortDescriptor *time_queuedDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"time_queued" ascending:YES];
//         NSArray *messages = [unsortedAssets sortedArrayUsingDescriptors:@[time_queuedDescriptor]];
//         
//         callback(messages, nil);
//     }
//     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         NSLog(@"%@", error);
//         callback(nil, error);
//     }];
//}
//
//-(void)postLeaveRequest:(NSDictionary *)params callback:(void (^)(NSError *error))callback{
//    NSString *endpoint = [NSString stringWithFormat:@"/api.php"];
//    
//    [[CUHTTPRequestOperationManager sharedManager:@"http://192.168.1.105:44447"]
//     POST:endpoint
//     parameters:params
//     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         NSDictionary *responseDictionary = [responseObject dictionaryOrNilValue];
//         callback(nil);
//     }
//     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         callback(error);
//     }];
//}
//
////!!!: This method name is very confusing
//- (void)followCouple:(CUCouple *)follower followee:(NSString *)followeeId callback:(void (^)(NSError *error))callback
//{
//    if ((follower.coupleId.length == 0) || (followeeId.length == 0)) {
//        NSLog(@"Invalid parameters");
//        //TODO: Pass a real error back
//        callback([NSError errorWithDomain:@"com.zoupple" code:0 userInfo:nil]);
//        return;
//    }
//    
//    NSString *endpoint = [NSString stringWithFormat:@"/couples/%@/followees/%@", follower.coupleId, followeeId];
//    
//    [[CUHTTPRequestOperationManager sharedManager]
//     POST:endpoint
//     parameters:nil
//     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         NSDictionary *responseDictionary = [responseObject dictionaryOrNilValue];
//         NSError *coupleError = nil;
//         CUCouple *responseCouple = [[CUCouple alloc] initWithDictionary:responseDictionary[@"data"] error:&coupleError];
//         if (coupleError) {
//             NSLog(@"Error fetching couple by user ID: %@", coupleError);
//         } else if (responseCouple) {
//             //???: Verify that responseCouple.user1/2Id matches self.signedInUser.userId?
//             self.signedInUser.couple = responseCouple;
//         }
//         callback(nil);
//     }
//     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         callback(error);
//     }];
//}
//
////!!!: This method name is very confusing
//- (void)unfollowCouple:(CUCouple *)follower followee:(NSString *)followeeId callback:(void (^)(NSError *error))callback
//{
//    if ((follower.coupleId.length == 0) || (followeeId.length == 0)) {
//        NSLog(@"Invalid parameters");
//        //TODO: Pass a real error back
//        callback([NSError errorWithDomain:@"com.zoupple" code:0 userInfo:nil]);
//        return;
//    }
//    
//    NSString *endpoint = [NSString stringWithFormat:@"/couples/%@/followees/%@", follower.coupleId, followeeId];
//    
//    [[CUHTTPRequestOperationManager sharedManager]
//     DELETE:endpoint
//     parameters:nil
//     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         NSDictionary *responseDictionary = [responseObject dictionaryOrNilValue];
//         NSError *coupleError = nil;
//         CUCouple *responseCouple = [[CUCouple alloc] initWithDictionary:responseDictionary[@"data"] error:&coupleError];
//         if (coupleError) {
//             NSLog(@"Error fetching couple by user ID: %@", coupleError);
//         } else if (responseCouple) {
//             //???: Verify that responseCouple.user1/2Id matches self.signedInUser.userId?
//             self.signedInUser.couple = responseCouple;
//         }
//         callback(nil);
//     }
//     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         callback(error);
//     }];
//}
//
////!!!: This method name is very confusing
//- (void)messageCouple:(CUCouple *)follower followee:(NSString *)followeeId callback:(void (^)(NSError *error))callback
//{
//    if ((follower.coupleId.length == 0) || (followeeId.length == 0)) {
//        NSLog(@"Invalid parameters");
//        //TODO: Pass a real error back
//        callback([NSError errorWithDomain:@"com.zoupple" code:0 userInfo:nil]);
//        return;
//    }
//    
//    NSString *endpoint = [NSString stringWithFormat:@"/couples/message/%@/followees/%@", follower.coupleId, followeeId];
//    
//    [[CUHTTPRequestOperationManager sharedManager]
//     POST:endpoint
//     parameters:nil
//     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         NSDictionary *responseDictionary = [responseObject dictionaryOrNilValue];
//         NSError *coupleError = nil;
//         CUCouple *responseCouple = [[CUCouple alloc] initWithDictionary:responseDictionary[@"data"] error:&coupleError];
//         if (coupleError) {
//             NSLog(@"Error fetching couple by user ID: %@", coupleError);
//         } else if (responseCouple) {
//             //???: Verify that responseCouple.user1/2Id matches self.signedInUser.userId?
//             //self.signedInUser.couple = responseCouple;
//         }
//         callback(nil);
//     }
//     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         callback(error);
//     }];
//}
//
////!!!: This method name is very confusing
//- (void)bootCouple:(CUCouple *)booter bootee:(NSString *)booteeId callback:(void (^)(CUBoot *boot, NSError *error))callback
//{
//    if ((booter.coupleId.length == 0) || (booteeId.length == 0)) {
//        NSLog(@"Invalid parameters");
//        //TODO: Pass a real error back
//        callback(nil, [NSError errorWithDomain:@"com.zoupple" code:0 userInfo:nil]);
//        return;
//    }
//    
//    NSString *endpoint = [NSString stringWithFormat:@"/couples/%@/boots/%@", booter.coupleId, booteeId];
//    
//    [[CUHTTPRequestOperationManager sharedManager]
//     POST:endpoint
//     parameters:nil
//     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         NSDictionary *responseDictionary = [responseObject dictionaryOrNilValue];
////         //???: Should this come back from the API as an array?
////         NSDictionary *bootDictionary = [responseDictionary[@"data"] firstObject];
////         NSError *bootError = nil;
////         CUBoot *aBoot = [[CUBoot alloc] initWithDictionary:bootDictionary error:&bootError];
////         if (bootError) {
////             //???: Should this be fatal
////             NSLog(@"Error booting couple: %@", bootError);
////         }
////         callback(aBoot, bootError);
//         //!!!: Temp until we refactor this handler to whatever new API returns
//         callback(nil, nil);
//     }
//     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         callback(nil, error);
//     }];
//}
//
//#pragma mark - Asset
//
//- (void)fetchAssetById:(NSString *)assetId callback:(void (^)(CUAsset *asset, NSError *error))callback
//{
//    if (assetId.length == 0) {
//        NSLog(@"Invalid parameters");
//        //TODO: Pass a real error back
//        callback(nil, [NSError errorWithDomain:@"com.zoupple" code:0 userInfo:nil]);
//        return;
//    }
//    
//    NSString *endpoint = [NSString stringWithFormat:@"/assets/%@", assetId];
//    
//    [[CUHTTPRequestOperationManager sharedManager]
//     GET:endpoint
//     parameters:nil
//     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         NSDictionary *responseDictionary = [responseObject dictionaryOrNilValue];
//         NSError *assetError = nil;
//         CUAsset *anAsset = [[CUAsset alloc] initWithDictionary:responseDictionary[@"data"] error:&assetError];
//         if (assetError) {
//             //???: Should this be fatal (i.e. return nil for sortedAssets)?
//             NSLog(@"Error creating asset: %@", assetError);
//         }
//         callback(anAsset, assetError);
//     }
//     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         callback(nil, error);
//     }];
//}
//
//- (void)deleteAssetById:(NSString *)assetId callback:(void (^)(NSDictionary *jsonDictionary, NSError *error))callback
//{
//    if (assetId.length == 0) {
//        NSLog(@"Invalid parameters");
//        //TODO: Pass a real error back
//        callback(nil, [NSError errorWithDomain:@"com.zoupple" code:0 userInfo:nil]);
//        return;
//    }
//    
//    NSString *endpoint = [NSString stringWithFormat:@"/assets/%@", assetId];
//    
//    [[CUHTTPRequestOperationManager sharedManager]
//     DELETE:endpoint
//     parameters:nil
//     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         //TODO: Parse out the important bits into a data model
//         NSDictionary *responseDictionary = [responseObject dictionaryOrNilValue];
//         callback(responseDictionary, nil);
//     }
//     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         callback(nil, error);
//     }];
//}
//
//- (void)fetchAssetsForCouple:(CUCouple *)couple callback:(void (^)(NSArray *assets, NSError *error))callback
//{
//    if (couple.coupleId.length == 0) {
//        NSLog(@"Invalid parameters");
//        //TODO: Pass a real error back
//        callback(nil, [NSError errorWithDomain:@"com.zoupple" code:0 userInfo:nil]);
//        return;
//    }
//    
//    NSString *endpoint = [NSString stringWithFormat:@"/couples/%@/assets", couple.coupleId];
//    
//    [[CUHTTPRequestOperationManager sharedManager]
//     GET:endpoint
//     parameters:nil
//     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         NSDictionary *responseDictionary = [responseObject dictionaryOrNilValue];
//         NSArray *assetDictionaries = responseDictionary[@"data"];
//         
//         NSError *assetError = nil;
//         NSArray *assets = [CUAsset arrayOfModelsFromDictionaries:assetDictionaries error:&assetError];
//         if (assetError) {
//             //???: Should this be fatal (i.e. return nil for sortedAssets)?
//             NSLog(@"Error creating asset: %@", assetError);
//         }
//         
//         callback(assets, nil);
//     }
//     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         callback(nil, error);
//     }];
//}
//
//- (void)addAssetForCouple:(CUCouple *)couple user:(CUUser *)user filename:(NSString *)filename assetUrl:(NSString *)assetUrl caption:(NSString *)caption isProfileImage:(BOOL)isProfileImage callback:(void (^)(NSDictionary *jsonDictionary, NSError *error))callback
//{
//    if ((user.userId.length == 0) ||
//        (couple.coupleId.length == 0) ||
//        (filename.length == 0) ||
//        (assetUrl.length == 0))
//    {
//        NSLog(@"Invalid parameters");
//        //TODO: Pass a real error back
//        callback(nil, [NSError errorWithDomain:@"com.zoupple" code:0 userInfo:nil]);
//        return;
//    }
//    
//    NSString *endpoint = [NSString stringWithFormat:@"/couples/%@/assets", couple.coupleId];
//    NSDictionary *parameters = @{ @"userId" : user.userId,
//                                  @"filename" : filename,
//                                  @"assetUrl" : assetUrl,
//                                  @"caption" : caption,
//                                  @"isProfilePic" : @(isProfileImage) };
//    
//    [[CUHTTPRequestOperationManager sharedManager]
//     POST:endpoint
//     parameters:parameters
//     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         //TODO: Parse out the important bits into a data model
//         NSDictionary *responseDictionary = [responseObject dictionaryOrNilValue];
//         
//         // Change user profile URL if applicable. Alternately, could refresh entire user to get update.
//         if (isProfileImage) {
//             self.signedInCouple.profilePicUrl = [NSURL URLWithString:assetUrl];
//         }
//         
//         callback(responseDictionary, nil);
//     }
//     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         callback(nil, error);
//     }];
//}

- (void)fetchFolloweeReviewsForUser:(BAUser *)user exceptForOwn:(NSString *)userId callback:(void (^)(NSArray *sortedReviews, NSError *error))callback
{
//    if (user.userId.length == 0) {
//        NSLog(@"Invalid parameters");
//        //TODO: Pass a real error back
//        callback(nil, [NSError errorWithDomain:@"com.networksocal" code:0 userInfo:nil]);
//        return;
//    }

    //testing
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://www.networksocal.com/"]];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    NSData *imageData = UIImageJPEGRepresentation(self.imageView.image, 0.5);
//    NSString *timestamp = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
//    NSDictionary *parameters = @{
//        @"filepath": [NSString stringWithFormat:@"uploads/%@.jpg", timestamp],
//        @"rating": [NSString stringWithFormat:@"%f", rating]
//    };
    
    NSDictionary *parameters = @{
        @"userId": userId
    };
    
    AFHTTPRequestOperation *op = [manager
        POST:@"?c=review&m=readReviews"
        parameters:parameters
//        constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
//        {
//            [formData appendPartWithFileData:imageData name:@"file" fileName:[NSString stringWithFormat:@"%@.jpg", timestamp] mimeType:@"image/jpeg"];
//        }
        success:^(AFHTTPRequestOperation *operation, id responseObject)
        {
            NSDictionary *responseDictionary = [responseObject dictionaryOrNilValue];
            
            //Note that this is an array
            //!!!: Need to standardize "data" across API as dictionary or array (probably dict)
            NSArray *reviewDictionaries = responseDictionary[@"data"];

            NSError *reviewError = nil;
            NSArray *unsortedReviews = [BAReview arrayOfModelsFromDictionaries:reviewDictionaries error:&reviewError];
            if (reviewError) {
                //???: Should this be fatal (i.e. return nil for sortedAssets)?
                NSLog(@"Error creating review: %@", reviewError);
            }

            NSSortDescriptor *dateTimeAddedDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"createdAtDate" ascending:NO];
            NSArray *sortedReviews = [unsortedReviews sortedArrayUsingDescriptors:@[dateTimeAddedDescriptor]];

            callback(sortedReviews, nil);
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error)
        {
            callback(nil, error);
        }];
        [op start];


//        [self dismissViewControllerAnimated:YES completion:nil];
    //testing
}

- (void)addLike:(BAUser *)user
           review:(NSString *)reviewId
        callback:(void (^)(NSDictionary *jsonDictionary, NSError *error))callback
{
//    BOOL validVoterType = ((CUAssetJellyVoterType == voterType) ||
//                           (CUAssetHotsauceVoterType == voterType) ||
//                           (CUAssetCheeseballVoterType == voterType));
//    if ((voter.coupleId.length == 0) || (assetId.length == 0) || !validVoterType)
//    {
//        NSLog(@"Invalid parameters");
//        //TODO: Pass a real error back
//        callback(nil, [NSError errorWithDomain:@"com.zoupple" code:0 userInfo:nil]);
//        return;
//    }
    
//    NSString *endpoint = [NSString stringWithFormat:@"/assets/%@/%@voters/%@", assetId, voterType, voter.coupleId];
//    
//    [[CUHTTPRequestOperationManager sharedManager]
//     PATCH:endpoint
//     parameters:nil
//     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         //TODO: Parse out the important bits into a data model
//         NSDictionary *responseDictionary = [responseObject dictionaryOrNilValue];
//         callback(responseDictionary, nil);
//     }
//     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         callback(nil, error);
//     }];
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://www.networksocal.com/"]];

    NSDictionary *parameters = @{
        @"userId": @"17",
        @"reviewId": reviewId,
    };

    AFHTTPRequestOperation *op = [manager
        POST:@"?c=review&m=likeReview"
        parameters:parameters
        success:^(AFHTTPRequestOperation *operation, id responseObject)
        {
            NSDictionary *responseDictionary = [responseObject dictionaryOrNilValue];
            callback(responseDictionary, nil);
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error)
        {
            callback(nil, error);
        }];
        [op start];
}

//- (void)removeVoter:(NSString *)voterId
//          voterType:(NSString *)voterType
//              asset:(NSString *)assetId
//           callback:(void (^)(NSDictionary *jsonDictionary, NSError *error))callback
//{
//    BOOL validVoterType = ((CUAssetJellyVoterType == voterType) ||
//                           (CUAssetHotsauceVoterType == voterType) ||
//                           (CUAssetCheeseballVoterType == voterType));
//    if ((voterId.length == 0) || (assetId.length == 0) || !validVoterType)
//    {
//        NSLog(@"Invalid parameters");
//        //TODO: Pass a real error back
//        callback(nil, [NSError errorWithDomain:@"com.zoupple" code:0 userInfo:nil]);
//        return;
//    }
//    
//    NSString *endpoint = [NSString stringWithFormat:@"/assets/%@/%@voters/%@", assetId, voterType, voterId];
//    
//    [[CUHTTPRequestOperationManager sharedManager]
//     DELETE:endpoint
//     parameters:nil
//     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         //TODO: Parse out the important bits into a data model
//         NSDictionary *responseDictionary = [responseObject dictionaryOrNilValue];
//         callback(responseDictionary, nil);
//     }
//     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         callback(nil, error);
//     }];
//}
//
//#pragma mark - Notification
//
//- (void)fetchNotificationsForCouple:(CUCouple *)couple callback:(void (^)(NSArray *notifications, NSError *error))callback
//{
//    if (couple.coupleId.length == 0) {
//        NSLog(@"Invalid parameters");
//        //TODO: Pass a real error back
//        callback(nil, [NSError errorWithDomain:@"com.zoupple" code:0 userInfo:nil]);
//        return;
//    }
//    
//    NSString *endpoint = [NSString stringWithFormat:@"/couples/%@/notifications", couple.coupleId];
//    // Only fetch unacknowledged notifications
//    endpoint = [endpoint stringByAppendingString:@"?unseenOnly=1"];
//    
//    [[CUHTTPRequestOperationManager sharedManager]
//     GET:endpoint
//     parameters:nil
//     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         NSDictionary *responseDictionary = [responseObject dictionaryOrNilValue];
//         NSArray *notificationDictionaries = responseDictionary[@"data"];
//         NSLog(@"Notifications: %@", notificationDictionaries);
//         NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"dateTimeAdded" ascending:NO];
//         notificationDictionaries = [notificationDictionaries sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
//         NSLog(@"Notifications: %@", notificationDictionaries);
//         
//         NSError *notificationError = nil;
//         NSArray *notifications = [CUFollowerNotification arrayOfModelsFromDictionaries:notificationDictionaries error:&notificationError];
//         if (notificationError) {
//             //???: Fatal?
//             NSLog(@"Error fetching notifications: %@", notificationError);
//         }
//         
//         callback(notifications, nil);
//     }
//     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         callback(nil, error);
//     }];
//}
//
//- (void)acknowledgeNotifications:(NSArray *)notificationIds couple:(CUCouple *)couple callback:(void (^)(NSDictionary *jsonDictionary, NSError *error))callback
//{
//    if (couple.coupleId.length == 0) {
//        NSLog(@"Invalid parameters");
//        //TODO: Pass a real error back
//        callback(nil, [NSError errorWithDomain:@"com.zoupple" code:0 userInfo:nil]);
//        return;
//    }
//    
//    NSString *endpoint = [NSString stringWithFormat:@"/couples/%@/notifications", couple.coupleId];
//    //???: Is this the right way to pass these to API?
//    NSDictionary *parameters = @{ @"notificationIds" : notificationIds };
//    
//    [[CUHTTPRequestOperationManager sharedManager]
//     PATCH:endpoint
//     parameters:parameters
//     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         //TODO: Parse out the important bits into a data model
//         NSDictionary *responseDictionary = [responseObject dictionaryOrNilValue];
//         callback(responseDictionary, nil);
//     }
//     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         callback(nil, error);
//     }];
//}
//
//- (void)sendNotificationsForEmail:(NSString *)email callback:(void (^)(NSDictionary *jsonDictionary, NSError *error))callback
//{
//    if (email.length == 0) {
//        NSLog(@"Invalid parameters");
//        //TODO: Pass a real error back
//        callback(nil, [NSError errorWithDomain:@"com.zoupple" code:0 userInfo:nil]);
//        return;
//    }
//    
//    NSString *endpoint = @"/notifications/send";
//    NSDictionary *parameters = @{ @"email" : email };
//    
//    [[CUHTTPRequestOperationManager sharedManager]
//     POST:endpoint
//     parameters:parameters
//     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         //TODO: Parse out the important bits into a data model
//         NSDictionary *responseDictionary = [responseObject dictionaryOrNilValue];
//         callback(responseDictionary, nil);
//     }
//     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         callback(nil, error);
//     }];
//}
//
//#pragma mark - Report new feed item
//- (void)reportNewsFeedItem:(NSString *)coupleId
//                     asset:(NSString *)assetId
//                  callback:(void (^)(NSDictionary *jsonDictionary, NSError *error))callback
//{
//    NSString *endpoint = [NSString stringWithFormat:@"/assets/%@/flagcontent/%@", assetId, coupleId];
//    
//    [[CUHTTPRequestOperationManager sharedManager]
//     POST:endpoint
//     parameters:nil
//     success:^(AFHTTPRequestOperation *operation, id responseObject) {
//         //TODO: Parse out the important bits into a data model
//         NSDictionary *responseDictionary = [responseObject dictionaryOrNilValue];
//         callback(responseDictionary, nil);
//     }
//     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//         callback(nil, error);
//     }];
//}

- (void)fetchPlacesContainingKeyword:(NSString *)keyword nearLocation:(CLLocationCoordinate2D)location callback:(void (^)(NSArray *sortedPlaces, NSError *error))callback
{
//    if (user.userId.length == 0) {
//        NSLog(@"Invalid parameters");
//        //TODO: Pass a real error back
//        callback(nil, [NSError errorWithDomain:@"com.networksocal" code:0 userInfo:nil]);
//        return;
//    }
    //testing
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json"]];
    manager.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
    
//    NSDictionary *parameters = @{
//        @"userId": userId
//    };
    
    AFHTTPRequestOperation *op = [manager
    POST:@"?location=33.8235306000,-117.8340944000&radius=5&rankBy=distance&types=restaurant&key=AIzaSyAJzXxRP2bnEyV_SiI1g2B8yDUYchjdrkE"
        parameters:nil
        success:^(AFHTTPRequestOperation *operation, id responseObject)
        {
            NSDictionary *responseDictionary = [responseObject dictionaryOrNilValue];
            
            //Note that this is an array
            //!!!: Need to standardize "data" across API as dictionary or array (probably dict)
            NSArray *reviewDictionaries = responseDictionary[@"data"];

            NSError *reviewError = nil;
            NSArray *unsortedReviews = [BAReview arrayOfModelsFromDictionaries:reviewDictionaries error:&reviewError];
            if (reviewError) {
                //???: Should this be fatal (i.e. return nil for sortedAssets)?
                NSLog(@"Error creating review: %@", reviewError);
            }

//            NSSortDescriptor *dateTimeAddedDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"dateTimeAdded" ascending:NO];
//            NSArray *sortedAssets = [unsortedAssets sortedArrayUsingDescriptors:@[dateTimeAddedDescriptor]];

            callback(unsortedReviews, nil);
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error)
        {
NSLog(@"%@", operation.responseObject);
            callback(nil, error);
        }];
        [op start];


//        [self dismissViewControllerAnimated:YES completion:nil];
    //testing
}


@end
