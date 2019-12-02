//
//  LBOCHappyMapManager.m
//  HHPlayerSDK
//
//  Created by Han Jize on 2019/12/2.
//

#import "LBOCHappyMapManager.h"

#import <MapKit/MapKit.h>

static LBOCHappyMapManager *_singleInstance = nil;

@implementation LBOCHappyMapManager

+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_singleInstance == nil) {
            _singleInstance = [[self alloc] init];
        }
    });
    return _singleInstance;
}


- (void)shareLocationToMapAppWithTarget:(CLLocation *)targetLocation andTargetLocationInfo:(NSString *)targetLocationInfo{//打开系统地图App
    // 起点
    MKMapItem *currentLocationItem = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:
                                                                           [[LBOCHappyLocationManager sharedInstance] getLocation].coordinate addressDictionary: nil]];
    currentLocationItem.name = [[LBOCHappyLocationManager sharedInstance] getLocationAddressInfo];

    // 目的地的位置
    MKMapItem *toLocationItem = [[MKMapItem alloc] initWithPlacemark: [[MKPlacemark alloc] initWithCoordinate:
                                                                       targetLocation.coordinate addressDictionary:nil]];
    toLocationItem.name = targetLocationInfo;

    NSArray *items = [NSArray arrayWithObjects:currentLocationItem, toLocationItem, nil];
    NSDictionary *options = @{ MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,
                               MKLaunchOptionsMapTypeKey: [NSNumber numberWithInteger:MKMapTypeStandard],
                               MKLaunchOptionsShowsTrafficKey: @YES };
     
    //打开苹果地图应用，并呈现指定的item
    [MKMapItem openMapsWithItems:items launchOptions:options];
}

@end
