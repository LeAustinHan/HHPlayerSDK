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

- (void)shareLocationToBaiDuMapAppWithTarget:(CLLocation *)targetLocation andTargetLocationInfo:(NSString *)targetLocationInfo{//打开系统地图App
    NSString *url = [[NSString stringWithFormat:@"baidumap://map/direction?origin=latlng:%f,%f|name:我的位置&destination=latlng:%f,%f|name:%@&mode=driving", [[LBOCHappyLocationManager sharedInstance] getLocation].coordinate.latitude, [[LBOCHappyLocationManager sharedInstance] getLocation].coordinate.longitude,targetLocation.coordinate.latitude, targetLocation.coordinate.longitude, targetLocationInfo] stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString: @"baidumap://"]]){
        if ([[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]] == NO){
            
        }

        } else {
     
            //[AutoAlertView ShowMessage:@"没有安装百度地图"];
    }
}

@end
