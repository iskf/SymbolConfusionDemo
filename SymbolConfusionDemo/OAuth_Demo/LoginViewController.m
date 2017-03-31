//
//  LoginViewController.m
//  OAuth_Demo
//
//  Created by InnoeriOS1 on 2017/2/14.
//
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *username;
@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}



- (IBAction)loginEventResponse:(id)sender {
    if (self.username.text.length <= 0 ||
        self.password.text.length <= 0) {
        return;
    }    
}

- (NSString *)stringWithFormat:(NSString *)format date:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setLocale:[NSLocale currentLocale]];
    return [formatter stringFromDate:date];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
