//
//  SecondViewController.m
//  CircleMaskDemo
//
//  Created by Ali Karagoz on 19/12/14.
//  Copyright (c) 2014 Ali Karagoz. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@property (nonatomic, strong) UIButton *button;

@end


@implementation SecondViewController

#pragma mark - Init

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithRed:197.0/255.0 green:202.0/255.0 blue:233.0/255.0 alpha:1.0];
    
    // Button
    self.button = [[UIButton alloc] init];
    self.button.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin);
    [self.button setTitle:@"Dismiss" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    self.button.titleLabel.font = [UIFont fontWithName:@"Avenir Light" size:20.0];
    [self.button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor colorWithRed:210.0/255.0 green:210.0/255.0 blue:210.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    self.button.backgroundColor = [UIColor colorWithRed:63.0/255.0 green:81.0/255.0 blue:181.0/255.0 alpha:1.0];
    self.button.layer.cornerRadius = 5.0;
    [self.view addSubview:self.button];
    
    [self.button sizeToFit];
    CGRect buttonFrame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.button.bounds) + 20.0, CGRectGetHeight(self.button.bounds) + 10.0);
    self.button.frame = buttonFrame;
    self.button.center = self.view.center;
}

#pragma mark - Button

- (void)didTapButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Status Bar

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

@end
