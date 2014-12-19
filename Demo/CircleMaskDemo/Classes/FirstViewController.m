//
//  FirstViewController.m
//  CircleMaskDemo
//
//  Created by Ali Karagoz on 19/12/14.
//  Copyright (c) 2014 Ali Karagoz. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"

#import "AKCircleMaskTransitionController.h"

@interface FirstViewController ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) AKCircleMaskTransitionController *transitionController;

@end

@implementation FirstViewController

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
    
    self.view.backgroundColor = [UIColor colorWithRed:63.0/255.0 green:81.0/255.0 blue:181.0/255.0 alpha:1.0];
    
    // Button
    self.button = [[UIButton alloc] init];
    self.button.autoresizingMask = (UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin);
    [self.button setTitle:@"Present View Controller" forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    self.button.titleLabel.font = [UIFont fontWithName:@"Avenir Light" size:20.0];
    [self.button setTitleColor:[UIColor colorWithRed:90.0/255.0 green:93.0/255.0 blue:107.0/255.0 alpha:1.0] forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor colorWithRed:60.0/255.0 green:63.0/255.0 blue:87.0/255.0 alpha:1.0] forState:UIControlStateHighlighted];
    self.button.backgroundColor = [UIColor colorWithRed:197.0/255.0 green:202.0/255.0 blue:233.0/255.0 alpha:1.0];
    self.button.layer.cornerRadius = 5.0;
    [self.view addSubview:self.button];
    
    [self.button sizeToFit];
    CGRect buttonFrame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.button.bounds) + 20.0, CGRectGetHeight(self.button.bounds) + 10.0);
    self.button.frame = buttonFrame;
    self.button.center = self.view.center;
    
    // Transition
    self.transitionController = [[AKCircleMaskTransitionController alloc] init];
}

#pragma mark - Button

- (void)didTapButton:(id)sender {
    
    self.transitionController.center = self.button.center;
    
    SecondViewController *secondViewController = [[SecondViewController alloc] init];
    secondViewController.transitioningDelegate = self.transitionController;
    secondViewController.modalPresentationStyle = UIModalPresentationCustom;
    secondViewController.modalPresentationCapturesStatusBarAppearance = YES;
    [self presentViewController:secondViewController animated:YES completion:nil];
}

#pragma mark - Status Bar

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
