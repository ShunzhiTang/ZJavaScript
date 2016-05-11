//
//  ZJavaScript.m
//  JavaScriptCoreDemo
//
//  Created by zly on 16/5/11.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "ZJavaScript.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface ZJavaScript ()<JSObjcDelegate>
{
    
}
@end


@implementation ZJavaScript


/**
 *  绑定需要交互的webview,在webViewDidFinishLoad中调用
 *
 *  @param webView     <#webView description#>
 *  @param strJSDomain <#strJSDomain description#>
 *
 *  @return <#return value description#>
 */
+(ZJavaScript*)Create:(UIWebView*)webView DefJSDomain:(NSString*)strJSDomain
{
    ZJavaScript * js = [[ZJavaScript alloc]init];
    if (js)
    {
        js.webView = webView;
        js.jsContext = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
        
        //使用JSExport处理
        js.jsContext[strJSDomain] = js;
        
        //初始化
        [js InitJavaScript];
    }
    
    return js;
}

/**
 *  增加js作用域
 *
 *  @param strJSDomain <#strJSDomain description#>
 */
-(void)AddJSDomain:(NSString*)strJSDomain
{
    //增加JSExport处理，方法还是写在JSObjcDelegate
    self.jsContext[strJSDomain] = self;
}


//初始化参数
-(void)InitJavaScript
{
    //异常回调
    _jsContext.exceptionHandler = ^(JSContext *context, JSValue *exceptionValue)
    {
        context.exception = exceptionValue;
        NSLog(@"error：%@", exceptionValue);
    };
}

/**
 *  调用js
 *
 *  @param strJSFunName js方法名
 *  @param arrParams    参数，为空则不传参数
 */
-(void)iOSToWeb:(NSString *)strJSFunName Params:(NSArray *)arrParams
{
    if (strJSFunName)
    {
        NSLog(@"没有传js函数名称！");
        return;
    }
    
    if (_jsContext)
    {
        JSValue *CallbackWeb = _jsContext[strJSFunName];
        [CallbackWeb callWithArguments:arrParams];
    }
}


/**
 *  增加全局js调用ios的回调无参数
 *
 *  @param strFunctionName js的方法名
 *  @param webToiOSBlock_n 回调
 */
-(void)AddWebToiOSFunction:(NSString*)strFunctionName webToiOSBlock_n:(WebToiOSBlock_n)webToiOSBlock_n
{
    if (!_jsContext)
        return;
    
    _jsContext[strFunctionName] =^()
    {
        if (webToiOSBlock_n)
        {
            webToiOSBlock_n();
        }
    };
}

/**
 *  增加全局js调用ios的回调整形参数
 *
 *  @param strFunctionName js的方法名
 *  @param webToiOSBlock_i 回调
 */
-(void)AddWebToiOSFunction:(NSString*)strFunctionName webToiOSBlock_i:(WebToiOSBlock_i)webToiOSBlock_i
{
    if (!_jsContext)
        return;
    
    _jsContext[strFunctionName] =^(int nJS)
    {
        if (webToiOSBlock_i)
        {
            webToiOSBlock_i(nJS);
        }
    };
}

/**
 *  增加全局js调用ios的回调字符形参数
 *
 *  @param strFunctionName js的方法名
 *  @param webToiOSBlock_i 回调
 */
-(void)AddWebToiOSFunction:(NSString*)strFunctionName webToiOSBlock_str:(WebToiOSBlock_str)webToiOSBlock_str
{
    if (!_jsContext)
        return;
    
    _jsContext[strFunctionName] =^(NSString *strJS)
    {
        if (webToiOSBlock_str)
        {
            webToiOSBlock_str(strJS);
        }
    };
}

/**
 *  增加全局js调用ios的回调数组参数
 *
 *  @param strFunctionName js的方法名
 *  @param webToiOSBlock_i 回调
 */
-(void)AddWebToiOSFunction:(NSString*)strFunctionName webToiOSBlock_arr:(WebToiOSBlock_arr)webToiOSBlock_arr
{
    if (!_jsContext)
        return;
    
    _jsContext[strFunctionName] =^(NSArray *arrJS)
    {
        if (webToiOSBlock_arr)
        {
            webToiOSBlock_arr(arrJS);
        }
    };
}

/**
 *  增加全局js调用ios的回调json参数
 *
 *  @param strFunctionName js的方法名
 *  @param webToiOSBlock_i 回调
 */
-(void)AddWebToiOSFunction:(NSString*)strFunctionName webToiOSBlock_dic:(WebToiOSBlock_dic)webToiOSBlock_dic
{
    if (!_jsContext)
        return;
    
    _jsContext[strFunctionName] =^(NSDictionary *dicJS)
    {
        if (webToiOSBlock_dic)
        {
            webToiOSBlock_dic(dicJS);
        }
    };
}


//自定义的函数实现_add1
-(void)webtoios_str:(NSString *)strJS
{
    if (self.m_webToiOSBlock_str)
    {
        self.m_webToiOSBlock_str(strJS);
    }
}

//自定义的函数实现_add2
- (void)webtoios_str_Block:(WebToiOSBlock_str)webToiOSBlock_str
{
    self.m_webToiOSBlock_str = webToiOSBlock_str;
}


//自定义的函数实现_add1
-(void)webtoios_str2:(NSString *)strJS
{
    if (self.m_webToiOSBlock_str2)
    {
        self.m_webToiOSBlock_str2(strJS);
    }
}

//自定义的函数_add2
- (void)webtoios_str2_Block:(WebToiOSBlock_str)webToiOSBlock_str
{
    self.m_webToiOSBlock_str2 = webToiOSBlock_str;
}


@end
