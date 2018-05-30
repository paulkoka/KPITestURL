//
//  ViewController.m
//  KPITestURL
//
//  Created by paul on 5/29/18.
//  Copyright © 2018 Paul. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, weak) UIButton *myButton;
@property (nonatomic, weak) UIImageView *myImage;
@end


@implementation ViewController

-(void)viewWillLayoutSubviews{
    CGRect rect = CGRectMake(self.view.frame.size.width / 2 - 70, self.view.frame.size.height / 2 - 14, 140, 28);
    
    if (!self.myButton) {
        self.myButton = [[[UIButton alloc] initWithFrame: rect] autorelease];
        self.myButton.layer.cornerRadius = 7;
        self.myButton.showsTouchWhenHighlighted = YES;
        self.myButton.backgroundColor = UIColor.grayColor;
        [ self.myButton setTitle:@"Download image" forState:UIControlStateNormal];
        [ self.myButton addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview: self.myButton];
    } else{
        self.myButton.frame = rect;
        
        if (self.myImage) {
           
            self.myImage.frame =  CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 2);
        }
    }
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib
 }


- (void)buttonTapped:(UIButton*)button {
    NSArray *links = @[@"http://www.stickpng.com/assets/thumbs/580b57fcd9996e24bc43c543.png",
                       @"https://upload.wikimedia.org/wikipedia/commons/d/d6/EPAM_logo.png",
                       @"http://www.stickpng.com/assets/thumbs/580b57fcd9996e24bc43c548.png",
                       @"https://gallery.yopriceville.com/var/albums/Free-Clipart-Pictures/Sport-PNG/Olympic%20Games%20Rio%202016%20Official%20PNG%20Transparent%20Logo.png?m=1469242502"];
    

 [self testURLSession:[NSURL URLWithString:[links objectAtIndex:3]]];
    
    }


- (void)testURLSession:(NSURL*)url {
     NSURLSession* session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (error == nil) {
           
                UIImage *newImage = [UIImage imageWithData:data];
                [self showImage:newImage];
            
        } else{
            [self alert];
        }
            });
        
      
    }]resume] ;
};



- (void) alert{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Something went wrong. Try again later" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}



- (void)showImage:(UIImage*)image {

    if (!self.myImage){
        dispatch_async(dispatch_get_main_queue(), ^{
            self.myImage = [[[UIImageView alloc] initWithImage:image] autorelease];
            self.myImage.frame =  CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 2);
            self.myImage.contentMode = UIViewContentModeScaleAspectFit;
            [self.view addSubview:self.myImage];
        });

}

}
@end
