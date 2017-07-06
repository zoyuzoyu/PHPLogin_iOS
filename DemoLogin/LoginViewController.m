//
//  ViewController.m
//  DemoLogin
//
//  Created by 周玉 on 2017/6/29.
//  Copyright © 2017年 周玉. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *tfUsername;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)loginBtnAction:(UIButton *)sender {
    
    NSString *URLString = [NSString stringWithFormat:@"%@/login",kBaseURL];
    NSDictionary *parameters = @{@"username": self.tfUsername.text, @"password": self.tfPassword.text};
    
//    NSURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:URLString parameters:parameters error:nil];
    NSURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:URLString parameters:parameters error:nil];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.responseSerializer = [AFJSONResponseSerializer
                                         serializerWithReadingOptions:NSJSONReadingAllowFragments];

    
    //    NSURL *URL = [NSURL URLWithString:@"http://httpbin.org/get"];
    //    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            NSLog(@"Error: %@", error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
        }
    }];
    [dataTask resume];
}


@end
