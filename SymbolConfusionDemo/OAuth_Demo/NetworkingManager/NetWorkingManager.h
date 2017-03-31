//
//  NetWorkingManager.h
//  ATOM
//
//  Created by InnoeriOS1 on 2016/12/28.
//  Copyright © 2016年 KingY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWorkingManager : NSObject


#pragma mark  默认数据格式

/**
 * url eg:http://oauth.zmallplanet.com:8031/api/values.ashx
 * param 参数  可传入NSDictionary 或者 NSObject
 * resultClass传入class model 类 解析直接返回model数组
 * tokenExpire token 过期回调
 * success  成功回调  返回数组数据
 * failure
 */
+(void)postWithUrl:(NSString *)url
             paramter:(id)paramter
       resultClass:(Class)resultClass
       tokenExpire:(void(^)())tokenExpire
           success:(void (^)(NSArray *results))success
           failure:(void (^)(NSError *error))failure;

/**
 *  上传图片
 *  fileName则是直接上传上去的图片， 注意一定要加 .jpg或者.png，（这个根据你得到这个imgData是通过jepg还是png的方式来获取决定）
 *  folderName 用来后台解析数据
 */
#pragma mark data 图片，附件
+ (void)postDataWithUrl:(NSString *)url
                 images:(NSArray *)images
             imageNames:(NSArray *)imageNames
             folderName:(NSString *)folderName
                 params:(NSDictionary *)params
               progress:(void (^)(float pro))progress
                success:(void (^)(id responseObject))success
                failure:(void (^)( NSError *error))failure;
@end
