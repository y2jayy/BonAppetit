//
//  API.h
//  BonAppetit
//
//  Created by Jay Yoon on 1/10/15.
//  Copyright (c) 2015 Jay Yoon. All rights reserved.
//

#import <Foundation/Foundation.h>
//todo: change the way you import CoreLocation
#import <CoreLocation/CoreLocation.h>
@class CLLocation;
@class BAUser;
@class BAReview;

@interface API : NSObject

@property (nonatomic, readonly) BAUser *signedInUser;

+ (id)sharedManager;

//#pragma mark - Sign In / Out
//
//- (void)signInUserWithEmail:(NSString *)email
//                     callback:(void (^)(NSError *error))callback;
//
//- (void)signOutUser;
//
//#pragma mark - User
//
//- (void)fetchUserWithEmail:(NSString *)email
//                  callback:(void (^)(CUUser *user, NSError *error))callback;
//
//- (void)updateUser:(CUUser *)user
//          location:(CLLocation *)location
//          callback:(void (^)(NSDictionary *jsonDictionary, NSError *error))callback;
//
//- (void)updateUser:(CUUser *)user
//          deviceToken:(NSString *)deviceToken
//          callback:(void (^)(NSDictionary *jsonDictionary, NSError *error))callback;
//
//#pragma mark - Couple
//
//- (void)fetchCoupleById:(NSString *)coupleId
//               callback:(void (^)(CUCouple *couple, NSError *error))callback;
//
//- (void)fetchCoupleListByDistance:(CLLocation *)originLocation
//                         callback:(void (^)(NSArray *couples, NSError *error))callback;
//
//- (void)createCoupleWithUserEmail:(NSString *)userEmail
//                         userName:(NSString *)userName
//                     userLocation:(CLLocation *)userLocation
//                     coupleStatus:(NSString *)coupleStatus
//                       coupleName:(NSString *)coupleName
//                      deviceToken:(NSString *)deviceToken
//                         callback:(void (^)(NSError *error))callback;
//
//- (void)updateCouple:(CUCouple *)couple
//    addMateWithEmail:(NSString *)email
//                name:(NSString *)name
//            location:(CLLocation *)location
//            callback:(void (^)(NSDictionary *jsonDictionary, NSError *error))callback;
//
//- (void)updateCouple:(CUCouple *)couple
//              status:(NSString *)status
//            callback:(void (^)(NSDictionary *jsonDictionary, NSError *error))callback;
//
//- (void)updateCouple:(CUCouple *)couple
//                name:(NSString *)name
//            callback:(void (^)(NSDictionary *jsonDictionary, NSError *error))callback;
//
//- (void)updateCouple:(CUCouple *)couple
//         profileInfo:(NSDictionary *)profileInfo
//            callback:(void (^)(NSError *error))callback;
//
//- (void)fetchFollowers:(CUCouple *)couple
//              callback:(void (^)(NSArray *followers, NSError *error))callback;
//
//- (void)fetchFollowees:(CUCouple *)couple
//              callback:(void (^)(NSArray *followees, NSError *error))callback;
//
//- (void)fetchConversations:(CUCouple *)couple
//              callback:(void (^)(NSArray *followers, NSError *error))callback;
//- (void)fetchSingleConversation:(CUCouple *)couple
//                       callback:(void (^)(NSArray *followers, NSError *error))callback;
//
//- (void)fetchBoots:(CUCouple *)couple
//          callback:(void (^)(NSArray *boots, NSError *error))callback;
//
//-(void)sendPushNotification:(NSString *)type
//                   followee:(NSString *)followeeId
//                   callback:(void (^)(NSError *error))callback;
//
//- (void)followCouple:(CUCouple *)follower
//            followee:(NSString *)followeeId
//            callback:(void (^)(NSError *error))callback;
//
//- (void)unfollowCouple:(CUCouple *)follower
//              followee:(NSString *)followeeId
//              callback:(void (^)(NSError *error))callback;
//
//- (void)bootCouple:(CUCouple *)booter
//            bootee:(NSString *)booteeId
//          callback:(void (^)(CUBoot *boot, NSError *error))callback;
//
//#pragma mark - Asset
//
//- (void)fetchAssetById:(NSString *)assetId
//              callback:(void (^)(CUAsset *asset, NSError *error))callback;
//
//- (void)deleteAssetById:(NSString *)assetId
//               callback:(void (^)(NSDictionary *jsonDictionary, NSError *error))callback;
//
//- (void)fetchAssetsForCouple:(CUCouple *)couple
//                    callback:(void (^)(NSArray *assets, NSError *error))callback;
//
//- (void)addAssetForCouple:(CUCouple *)couple
//                     user:(CUUser *)user
//                 filename:(NSString *)filename
//                 assetUrl:(NSString *)assetUrl
//                  caption:(NSString *)caption
//           isProfileImage:(BOOL)isProfileImage
//                 callback:(void (^)(NSDictionary *jsonDictionary, NSError *error))callback;

- (void)fetchFolloweeReviewsForUser:(BAUser *)user
                            exceptForOwn:(NSString *)userId
                            callback:(void (^)(NSArray *sortedReviews, NSError *error))callback;

- (void)addLike:(BAUser *)user
           review:(NSString *)reviewId
        callback:(void (^)(NSDictionary *jsonDictionary, NSError *error))callback;

//- (void)removeVoter:(NSString *)voterId
//          voterType:(NSString *)voterType
//              asset:(NSString *)assetId
//           callback:(void (^)(NSDictionary *jsonDictionary, NSError *error))callback;
//
//#pragma mark - Notification
//
//- (void)fetchNotificationsForCouple:(CUCouple *)couple
//                           callback:(void (^)(NSArray *notifications, NSError *error))callback;
//
//- (void)acknowledgeNotifications:(NSArray *)notificationIds
//                          couple:(CUCouple *)couple
//                        callback:(void (^)(NSDictionary *jsonDictionary, NSError *error))callback;
//
//- (void)sendNotificationsForEmail:(NSString *)email
//                         callback:(void (^)(NSDictionary *jsonDictionary, NSError *error))callback;
//
//#pragma mark - Messenger
//-(void)postMessageToServer:(NSDictionary *)params callback:(void (^)(NSError *error))callback;
//-(void)postJoinRequest:(NSDictionary *)params callback:(void (^)(NSError *error))callback;
//-(void)postLeaveRequest:(NSDictionary *)params callback:(void (^)(NSError *error))callback;
//-(void)messageCouple:(CUCouple *)follower followee:(NSString *)followeeId callback:(void (^)(NSError *error))callback;
//-(void)fetchMessagesForDevice:(NSDictionary *)params callback:(void (^)(NSArray *followers, NSError *error))callback;
//
//#pragma mark - Report new feed item
//- (void)reportNewsFeedItem:(NSString *)coupleId
//                     asset:(NSString *)assetId
//                  callback:(void (^)(NSDictionary *jsonDictionary, NSError *error))callback;

- (void)fetchPlacesContainingKeyword:(NSString *)keyword
                            nearLocation:(CLLocationCoordinate2D)location
                            callback:(void (^)(NSArray *sortedPlaces, NSError *error))callback;
@end