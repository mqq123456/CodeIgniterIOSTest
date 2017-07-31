//
//  ViewController.m
//  CodeIgniterIOSTest
//
//  Created by HeQin on 2017/7/28.
//  Copyright © 2017年 chinamobile.cmcc. All rights reserved.
//

#import "ViewController.h"
#import "CMMapNetworkingManager.h"
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
}
- (IBAction)btn1Click:(id)sender {
    [CMMapNetworkingManager GET:@"http://localhost/CodeIgniter.5/index.php/Welcome/insertData/xiaoming/345" parameters:nil headers:nil timeout:0 requestType:0 responseType:0 success:^(NSDictionary *responseObject) {
        _textView.text = [NSString stringWithFormat:@"add = \n %@",responseObject.description];
    } failure:^(NSError *error) {
        
    }];
}
- (IBAction)deleteClick:(id)sender {
    [CMMapNetworkingManager GET:@"http://localhost/CodeIgniter.5/index.php/Welcome/deleteData/xiaoming" parameters:nil headers:nil timeout:0 requestType:0 responseType:0 success:^(NSDictionary *responseObject) {
        _textView.text = [NSString stringWithFormat:@"delete = \n %@",responseObject.description];
    } failure:^(NSError *error) {
        
    }];
}
- (IBAction)modifyClick:(id)sender {
    [CMMapNetworkingManager GET:@"http://localhost/CodeIgniter.5/index.php/Welcome/updateData/1/009" parameters:nil headers:nil timeout:0 requestType:0 responseType:0 success:^(NSDictionary *responseObject) {
        _textView.text = [NSString stringWithFormat:@"select = \n %@",responseObject.description];
    } failure:^(NSError *error) {
        
    }];
}
- (IBAction)selectClick:(id)sender {
    [CMMapNetworkingManager GET:@"http://localhost/CodeIgniter.5/index.php/Welcome/selectData" parameters:nil headers:nil timeout:0 requestType:0 responseType:0 success:^(NSDictionary *responseObject) {
        _textView.text = [NSString stringWithFormat:@"select = \n %@",responseObject.description];
    } failure:^(NSError *error) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
