//
//  NetWorkingManager.m
//  ATOM
//
//  Created by InnoeriOS1 on 2016/12/28.
//  Copyright © 2016年 KingY. All rights reserved.
//

#import "NetWorkingManager.h"
#import "AFNetworking/AFNetworking.h"
#import "WHC_DataModel.h"
#import "NSObject+WHC_Model.h"
@interface DataResults : NSObject

/** 提示 */
@property (nonatomic, copy) NSString *Msg;

/** 状态 */
@property (nonatomic, copy) NSString *Status;

/** 数据 */
@property (nonatomic, strong) NSArray *Data;

@end

@implementation  DataResults
@end

@implementation NetWorkingManager


+(void)postWithUrl:(NSString *)url paramter:(id)paramter resultClass:(Class)resultClass tokenExpire:(void(^)())tokenExpire success:(void (^)(NSArray *))success  failure:(void (^)(NSError *))failure
{
    NSDictionary *dictParam;
    if ([paramter isKindOfClass:[NSDictionary class]]) {
        dictParam = paramter;
    }else
    {
        dictParam = [paramter whc_Dictionary];
    }
    
    [NetWorkingManager postWithUrl:url param:dictParam success:^(DataResults *result) {
        if (success) {
                if ([result.Status isEqualToString:@"1"]) {
                    NSArray *array = [[resultClass class] whc_ModelWithJson:result.Data];
                    success(array);
                }else if ([result.Status isEqualToString:@"10"])//token失效
                {
                    tokenExpire();
                }
                else
                {
                    success(nil);
                }
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}


+(void)postWithUrl:(NSString *)url param:(NSDictionary *)param success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    
    [NetWorkingManager post:url params:param success:^(id result) {
        if (success) {
         //   NSString *str = [[NSString alloc]initWithData:result encoding:NSUTF8StringEncoding];
            
            DataResults *resultObj = [DataResults whc_ModelWithJson:result];
            success(resultObj);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    
   
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    session.requestSerializer.timeoutInterval = 30;
    
    [session.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",@"text/html",@"text/javascript",@"text/xml",nil]];
    [session POST:url
       parameters:params
         progress:nil
          success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}

//fileName则是直接上传上去的图片， 注意一定要加 .jpg或者.png，（这个根据你得到这个imgData是通过jepg还是png的方式来获取决定）
+ (void)postDataWithUrl:(NSString *)url
                 images:(NSArray *)images
             imageNames:(NSArray *)imageNames
             folderName:(NSString *)folderName
                 params:(NSDictionary *)params
               progress:(void (^)(float pro))progress
                success:(void (^)(id responseObject))success
                failure:(void (^)( NSError *error))failure
{
    NSCharacterSet *characterSet = [[NSCharacterSet characterSetWithCharactersInString:url] invertedSet];
    url = [url stringByAddingPercentEncodingWithAllowedCharacters:characterSet];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30;
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json",@"text/html",@"text/javascript",@"text/xml",@"image/jpeg",@"image/png",nil]];
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (images.count == 0) {
           
            failure(nil);
            return ;
        }else{
           
            for (NSInteger i = 0; i<images.count; i++) {
                NSString *fileName =imageNames[i];
                NSData *imageData = UIImageJPEGRepresentation(images[i], 0.75);
                [formData appendPartWithFileData:imageData name:folderName fileName:fileName mimeType:@"image/jpeg"];
            }
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        NSString *prores = [NSString stringWithFormat:@"%lld",uploadProgress.completedUnitCount/uploadProgress.totalUnitCount];
        if (progress) {
            progress([prores floatValue]);
        }
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (success) {
            success(dic);
        }
        
    }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
    
}




@end
