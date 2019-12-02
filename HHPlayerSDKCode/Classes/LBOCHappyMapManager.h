//
//  LBOCHappyMapManager.h
//  HHPlayerSDK
//
//  Created by Han Jize on 2019/12/2.
//

#import <Foundation/Foundation.h>

#import "LBOCHappyLocationManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface LBOCHappyMapManager : NSObject


@property (nonatomic,strong) LBOCHappyLocationManager *locationManager;/** 设置manager */

/**

获取单例

@return GPS定位控制器单例

*/

+ (instancetype)sharedInstance;

/**

获取单例

@return 导航到目标位置

*/
- (void)shareLocationToMapAppWithTarget:(CLLocation *)targetLocation andTargetLocationInfo:(NSString *)targetLocationInfo;

/**

获取单例

@return 导航到目标位置

*/
- (void)shareLocationToBaiDuMapAppWithTarget:(CLLocation *)targetLocation andTargetLocationInfo:(NSString *)targetLocationInfo;

@end

NS_ASSUME_NONNULL_END
