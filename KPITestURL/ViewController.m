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

@property (nonatomic, weak) UIButton *myButtonBackground;
@property (nonatomic, weak) UIImageView *myImageFromBasckground;
@end


@implementation ViewController

-(void)viewWillLayoutSubviews{
    CGRect rect = CGRectMake(self.view.frame.size.width / 2 - 145, self.view.frame.size.height / 2 - 14, 140, 28);
    CGRect rectTwo = CGRectMake(self.view.frame.size.width / 2 + 5, self.view.frame.size.height / 2 - 14, 140, 28);
    if (!self.myButton) {
        self.myButton = [self buttonSetStatesofTitle:@"Download image" plaseRect:rect targetactionSelector:@selector(buttonTapped:)];
       
        self.myButtonBackground = [self buttonSetStatesofTitle:@"Background" plaseRect:rectTwo targetactionSelector:@selector(buttonTapped:)];
        
        [self.view addSubview: self.myButton];
        [self.view addSubview: self.myButtonBackground];
        
        
    } else{
        self.myButton.frame = rect;
        
        if (self.myImage) {
           
            self.myImage.frame =  CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 2);
        }
    }
}

-(UIButton*) buttonSetStatesofTitle: (NSString*) title plaseRect:(CGRect) valueOfRect targetactionSelector:(SEL) selectorOfAction{
    UIButton* button = [[[UIButton alloc] initWithFrame:valueOfRect] autorelease];
    button.layer.cornerRadius = 7;
    button.showsTouchWhenHighlighted = YES;
    button.backgroundColor = UIColor.grayColor;
    [button setTitle:[NSString stringWithFormat:@"%@", title] forState:UIControlStateNormal];
    [button addTarget:self action:selectorOfAction forControlEvents:UIControlEventTouchUpInside];
    return button;
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

    if ([button isEqual:self.myButton]) {
         [self testURLSessionDataTaskWithURL:[NSURL URLWithString:[links objectAtIndex:0]]];
    }
    
//    else if ([button isEqual:self.myButtonBackground]){
//        [self testURLSessionBackgroundTaskWithURL:[NSURL URLWithString:[links objectAtIndex:1]]];
//    }
    
}


- (void)testURLSessionDataTaskWithURL:(NSURL*)url {
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

//- (void) testURLSessionBackgroundTaskWithURL:(NSURL*)url{
//    NSURLSessionConfiguration* config = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"curentBackgroundSession"];
//    NSURLSession* session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:nil];
//    NSURLSessionDownloadTask *newTask = [session downloadTaskWithURL:url];
//
//    UIImage *newImage = [UIImage imageWithContentsOfFile:newTask.accessibilityPath];
//
//    NSLog(@"hello from backgriund, %@", [NSValue valueWithCGSize:newImage.size]);
//    [self showImage:newImage];
//    [newTask resume];
//   }


- (void) alert{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Alert" message:@"Something went wrong. Try again later" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [self presentViewController:alert animated:YES completion:nil];
}



- (void)showImage:(UIImage*)image {

    //if (!self.myImage){
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"start image");
            self.myImage = [[[UIImageView alloc] initWithImage:image] autorelease];
            self.myImage.frame =  CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height / 2);
            self.myImage.contentMode = UIViewContentModeScaleAspectFit;
            [self.view addSubview:self.myImage];
        });

//}

}
@end
