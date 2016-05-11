//
//  ZJavaScript.h
//  JavaScriptCoreDemo
//
//  Created by zly on 16/5/11.
//  Copyright © 2016年 zly. All rights reserved.
//
//  需要iOS7以上版本才能使用

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

//需要响应的回调
typedef void(^WebToiOSBlock_n)();
typedef void(^WebToiOSBlock_i)(int nJS);
typedef void(^WebToiOSBlock_str)(NSString * strJS);
typedef void(^WebToiOSBlock_arr)(NSArray * arrJS);
typedef void(^WebToiOSBlock_dic)(NSDictionary * dicJS);

//需要有多种类型的回调需要自己添加



//这里定义web调用ios的方法名
@protocol JSObjcDelegate <JSExport>

/**
 *  不带参数
 */
- (void)WebToiOS_n;

/**
 *  传回一个整形
 *
 *  @param strJS <#strJS description#>
 */
-(void)WebToiOS_i:(int)nJS;

/**
 *  传回一个字符串
 *
 *  @param strJS <#strJS description#>
 */
-(void)WebToiOS_str:(NSString *)strJS;

/**
 *  传回一个数组
 *
 *  @param arrJS <#arrJS description#>
 */
-(void)WebToiOS_arr:(NSArray *)arrJS;

/**
 *  传回一个Json
 *
 *  @param arrJS <#arrJS description#>
 */
-(void)WebToiOS_dic:(NSDictionary *)dicJS;




//自定义的函数_add1
-(void)webtoios_str:(NSString *)strJS;

//自定义的函数_add1
-(void)webtoios_str2:(NSString *)strJS;


@end


@class UIWebView;

/**
 *  ios与js交互类，方法完成后需要切换到主线程
 //换到主线程
 [self performSelectorOnMainThread:@selector(toMain:) withObject:xxx waitUntilDone:YES];
 */
@interface ZJavaScript : NSObject

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) JSContext *jsContext;


/**
 *  绑定需要交互的webview,在webViewDidFinishLoad中调用
 *
 *  @param webView     <#webView description#>
 *  @param strJSDomain <#strJSDomain description#>
 *
 *  @return <#return value description#>
 */
+(ZJavaScript*)Create:(UIWebView*)webView DefJSDomain:(NSString*)strJSDomain;

/**
 *  增加js作用域
 *
 *  @param strJSDomain <#strJSDomain description#>
 */
-(void)AddJSDomain:(NSString*)strJSDomain;


/**
 *  调用js
 *
 *  @param strJSFunName js方法名
 *  @param arrParams    参数，为空则不传参数
 */
-(void)iOSToWeb:(NSString *)strJSFunName Params:(NSArray *)arrParams;


/**
 *  增加全局js调用ios的回调无参数
 *
 *  @param strFunctionName js的方法名
 *  @param webToiOSBlock_n 回调
 */
-(void)AddWebToiOSFunction:(NSString*)strFunctionName webToiOSBlock_n:(WebToiOSBlock_n)webToiOSBlock_n;

/**
 *  增加全局js调用ios的回调整形参数
 *
 *  @param strFunctionName js的方法名
 *  @param webToiOSBlock_i 回调
 */
-(void)AddWebToiOSFunction:(NSString*)strFunctionName webToiOSBlock_i:(WebToiOSBlock_i)webToiOSBlock_i;

/**
 *  增加全局js调用ios的回调字符形参数
 *
 *  @param strFunctionName js的方法名
 *  @param webToiOSBlock_i 回调
 */
-(void)AddWebToiOSFunction:(NSString*)strFunctionName webToiOSBlock_str:(WebToiOSBlock_str)webToiOSBlock_str;

/**
 *  增加全局js调用ios的回调数组参数
 *
 *  @param strFunctionName js的方法名
 *  @param webToiOSBlock_i 回调
 */
-(void)AddWebToiOSFunction:(NSString*)strFunctionName webToiOSBlock_arr:(WebToiOSBlock_arr)webToiOSBlock_arr;

/**
 *  增加全局js调用ios的回调json参数
 *
 *  @param strFunctionName js的方法名
 *  @param webToiOSBlock_i 回调
 */
-(void)AddWebToiOSFunction:(NSString*)strFunctionName webToiOSBlock_dic:(WebToiOSBlock_dic)webToiOSBlock_dic;


//自定义的函数_add2
- (void)webtoios_str_Block:(WebToiOSBlock_str)webToiOSBlock_str;
//自定义的函数_add3
@property (nonatomic, copy) WebToiOSBlock_str m_webToiOSBlock_str;

//自定义的函数_add2
- (void)webtoios_str2_Block:(WebToiOSBlock_str)webToiOSBlock_str;
//自定义的函数_add3
@property (nonatomic, copy) WebToiOSBlock_str m_webToiOSBlock_str2;


@end
