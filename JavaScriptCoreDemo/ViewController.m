//
//  ViewController.m
//  JavaScriptCoreDemo
//
//  Created by zly on 16/5/11.
//  Copyright © 2016年 zly. All rights reserved.
//

#import "ViewController.h"
#import "ZJavaScript/ZJavaScript.h"

@interface ViewController ()<UIWebViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIWebView *_webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"demo" withExtension:@"html"];
    [_webView loadRequest:[[NSURLRequest alloc] initWithURL:url]];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    ZJavaScript* js = [ZJavaScript Create:webView DefJSDomain:@"gb"];
    [js webtoios_str_Block:^(NSString *strJS)
     {
         NSLog(@"%@",strJS);
         
     }];
    
    [js AddWebToiOSFunction:@"webtoios_n" webToiOSBlock_n:^
    {
        NSLog(@"webToiOSBlock_n");
        
    }];
    
    //增加作用域
    [js AddJSDomain:@"gb2"];
    __weak typeof(self) weakSelf = self;
    [js webtoios_str2_Block:^(NSString *strJS)
    {
        NSLog(@"%@",strJS);
        [weakSelf ShowMsg:strJS];
    }];
    
}

-(void)ShowMsg:(NSString*)strMsg
{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"msg from js" message:strMsg delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
    [alert show];
    
    //如果需要操作界面，需要切换到主程线
    [self performSelectorOnMainThread:@selector(ToMain:) withObject:strMsg waitUntilDone:YES];
}

-(void)ToMain:(NSString*)strMsg
{
    NSLog(@"已经到了主线程%@",strMsg);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
