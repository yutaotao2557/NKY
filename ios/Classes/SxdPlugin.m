#import "SxdPlugin.h"
#import <AECC_Setnet_SDK/AECCSetnetManager.h>

@implementation SxdPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
            methodChannelWithName:@"sxd"
            binaryMessenger:[registrar messenger]];
  SxdPlugin* instance = [[SxdPlugin alloc] init];
  [registrar
            addMethodCallDelegate:instance
            channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"getPlatformVersion" isEqualToString:call.method]) {
        result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
    } else if([@"enCodeWithParams" isEqualToString:call.method]){
        [
            [AECCSetnetManager sharedInstance] enCodeWithParams:call.arguments
                block:^(NSDictionary * _Nonnull encryptionDataDic)
                {
                    result(encryptionDataDic);
                }
        ];
    } else if([@"DeCodeWithInputData" isEqualToString:call.method]){
        //NSData *sata = @[];

        //NSLog(@"--------");
        //NSLog(@"%@",NSStringFromClass([sata class]));
        //NSLog(@"--------");
        FlutterStandardTypedData *typedData = call.arguments;
        NSData *ttdata = typedData.data;
        //NSLog(@"%@",NSStringFromClass([ttdata class]));
        //NSLog(@"--------");
        //NSData *mmData = [NSKeyedArchiver archivedDataWithRootObject:call.arguments];
        //NSLog(@"%@",NSStringFromClass(ttdata));
        //NSLog(@"--------");
        [
            [AECCSetnetManager sharedInstance] DeCodeWithInputData:ttdata
            block:^(NSDictionary * _Nonnull decryptDataDic) {
                NSLog(@"-s-%@",decryptDataDic);
                result(decryptDataDic);
            }
        ];
    }  else {
        result(FlutterMethodNotImplemented);
    }
}

@end
