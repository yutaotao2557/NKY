#import "SdxPlugin.h"
#import <AECC_Setnet_SDK/AECCSetnetManager.h>

@implementation SdxPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
            methodChannelWithName:@"sdx"
            binaryMessenger:[registrar messenger]];
  SdxPlugin* instance = [[SdxPlugin alloc] init];
  [registrar
            addMethodCallDelegate:instance
            channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"getPlatformVersion" isEqualToString:call.method]) {
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    } else if(@"enCodeWithParams" isEqualToString:call.method){
        [
            [AECCSetnetManager sharedInstance] enCodeWithParams:call.arguments
                block:^(NSDictionary * _Nonnull encryptionDataDic)
                {
                    result(encryptionDataDic);
                }
        ];
    } else if(@"encode26WithPatams" isEqualToString:call.method){
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    } else if(@"encode17WithPatams" isEqualToString:call.method){
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    } else if(@"deCode17WithParams" isEqualToString:call.method){
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    } else if(@"deCodeWithParams" isEqualToString:call.method){
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    }  else {
        result(FlutterMethodNotImplemented);
    }
}

@end
